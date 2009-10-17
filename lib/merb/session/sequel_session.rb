require 'sequel'
require 'sequel/extensions/migration' if Merb::Orms::Sequel.new_sequel? 
require 'merb-core/dispatch/session'

module Merb

  Merb::Plugins.config[:merb_sequel][:session_table_name] ||= 'sessions'

  # Default session migration run if a sessions table does not yet exist.
  #
  # Will create a table with a name of 'sessions' by default, or as 
  # set by Merb::Plugins.config[:merb_sequel][:session_table_name]
  
  class CreateSessionMigration < Sequel::Migration
    def up
      table_name = Merb::Plugins.config[:merb_sequel][:session_table_name].to_sym
      unless table_exists?(table_name)
        puts "Warning: The database did not contain a '#{table_name}' table for sessions."
        
        create_table table_name do
          primary_key :id
          varchar :session_id
          text :data
          timestamp :created_at
        end
        
        puts "Created '#{table_name}' session table."
      end
    end
  end

  CreateSessionMigration.apply(Sequel::Model.db, :up)

  # Sessions stored in Sequel model.
  #
  # To use Sequel based sessions add the following to config/init.rb:
  #
  # Merb::Config[:session_store] = 'sequel'

  class SequelSessionStore < Sequel::Model(Merb::Plugins.config[:merb_sequel][:session_table_name].to_sym)

    class << self
      
      # ==== Parameters
      # session_id<String>:: ID of the session to retrieve.
      #
      # ==== Returns
      # ContainerSession:: The session corresponding to the ID.
      def retrieve_session(session_id)
        if item = find(:session_id => session_id)
          Marshal.load(item.data.unpack('m').first)
        end
      end

      # ==== Parameters
      # session_id<String>:: ID of the session to set.
      # data<ContainerSession>:: The session to set.
      def store_session(session_id, session_data)
        session_data = session_data.empty? ? nil : [Marshal.dump(session_data)].pack('m')
        begin
          if item = self.find(:session_id => session_id)
            item.update(:data => session_data)
          else
            item = self.new(:session_id => session_id,
                            :data => session_data,
                            :created_at => Time.now)
            item.save
          end
        rescue => e
          Merb.logger.error("#{e.message} when trying to save #{session_data}")
        end
      end

      # ==== Parameters
      # session_id<String>:: ID of the session to delete.
      def delete_session(session_id)
        if item = find(:session_id => session_id)
          item.delete
        end
      end

      unless Merb::Orms::Sequel.new_sequel?
        alias :create_table! :create_table
        alias :drop_table! :drop_table
      end
    end
  end
  
  class SequelSession < SessionStoreContainer
    # The session store type
    self.session_store_type = :sequel
    
    # The store object is the model class itself
    self.store = SequelSessionStore
  end

end
