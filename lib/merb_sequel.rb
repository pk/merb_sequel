if defined?(Merb::Plugins)

  # Default settings
  Merb::Plugins.config[:merb_sequel] = { :load_activemodel_compatibility => true }

  require File.join(File.dirname(__FILE__) / "merb" / "orms" / "sequel" / "model")
  require File.join(File.dirname(__FILE__) / "merb" / "orms" / "sequel" / "connection")
  Merb::Plugins.add_rakefiles "merb_sequel" / "merbtasks"
  
  # Connects to the database and handles session
  #
  # Connects to the database and loads sequel sessions if we use them.
  # Sets router to identify models using Model.pk.
  class Merb::Orms::Sequel::Connect < Merb::BootLoader
    after BeforeAppLoads

    def self.run
      Merb::Orms::Sequel.connect
      if Merb::Config.session_stores.include?(:sequel)
        Merb.logger.debug "Using Sequel sessions"
        require File.join(File.dirname(__FILE__) / "merb" / "session" / "sequel_session")
      end
      
      # Set identifiy to use Sequel primary key field
      Merb::Router.root_behavior = Merb::Router.root_behavior.identify(Sequel::Model => :pk)

      # Load compatibility extensions
      if Merb::Plugins.config[:merb_sequel][:load_activemodel_compatibility]
        load_activemodel_compatibility
      end
    end

    # Load active model plugin if available
    #
    # Merb > 1.0.13 expects models to be ActiveModel compatible
    # Sequel 3.5.0 added plugin to make Sequel models AtciveModel
    # compatible.
    #
    # We're loading plugin to all models here if plugin is available 
    # if the plugin is not available we must include compatibility module.
    def self.load_activemodel_compatibility
      begin
        Sequel::Model.plugin :active_model
      rescue LoadError, NoMethodError
        Sequel::Model.send(:include, Merb::Orms::Sequel::Model::ActiveModelCompatibility)
      end
    end

  end

  # Disconnects from DB before reaping workers
  #
  # We must disconnect from the DB before the worker process dies to be nice 
  # and not cause IO blocking.
  #
  # Disconnect only when fork_for_class_relaod is set and we're not in
  # testing mode.
  Merb::BootLoader.before_worker_shutdown do
    if Merb::Config[:fork_for_class_load] && !Merb.testing?
      Merb.logger.info "Disconnecting database connection before worker shutdown..."
      dbs = []
      ::Sequel::DATABASES.each { |db| db.disconnect; dbs << db } 
      # Cleanup disconnected databases so they can be GCed
      dbs.each {|db| ::Sequel::DATABASES.delete(db) }
    end
  end
  
  # Disconnects from DB before starting reloading classes
  #
  # We must disconnect from the DB before the worker process dies to be nice 
  # and not cause IO blocking.
  #
  # Disconnect only when fork_for_class_relaod is set and we're not in
  # testing mode.
  class Merb::BootLoader::DisconnectBeforeStartTransaction < Merb::BootLoader
    before LoadClasses

    def self.run
      if Merb::Config[:fork_for_class_load] && !Merb.testing?
        Merb.logger.info "Disconnecting database connection before starting transaction."
        ::Sequel::DATABASES.each { |db| db.disconnect }
      end
    end
  end
  
  # Load generators
  generators = File.join(File.dirname(__FILE__), 'generators')
  Merb.add_generators generators / :migration
  Merb.add_generators generators / :model
  Merb.add_generators generators / :resource_controller
  Merb.add_generators generators / :session_migration
end
