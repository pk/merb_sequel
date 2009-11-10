require 'rubygems'

# Use current merb-core sources if running from a typical dev checkout.
lib = File.expand_path('../../../merb/merb-core/lib', __FILE__)
$LOAD_PATH.unshift(lib) if File.directory?(lib)
require "merb-core"
require "sequel"
require "merb_sequel"

Merb.start(:adapter       => 'runner',
           :log_level     => :error,
           :merb_root     => File.dirname(__FILE__),
           :session_store => 'sequel',
           :environment   => 'test'
          )

# Load extensions if we use new versions of Sequel
require 'sequel/extensions/migration' if Merb::Orms::Sequel.new_sequel?

Spec::Runner.configure do |config|
  config.include Merb::Test::RequestHelper

  config.after(:all) do
    CreateSpecModel.apply(Sequel::Model.db, :up)
  end
end

require File.join( File.dirname(__FILE__), 'spec_model')
require File.join( File.dirname(__FILE__), 'spec_controller')

Merb::Router.prepare do
  match('/change').to(:controller => :spec_controller, :action => :change).name(:change)
  match('/clear').to(:controller => :spec_controller, :action => :clear).name(:clear)
  match('/get').to(:controller => :spec_controller, :action => :get).name(:get)
  match('/set').to(:controller => :spec_controller, :action => :set).name(:set)
end
