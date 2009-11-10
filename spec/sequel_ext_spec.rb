require File.dirname(__FILE__) + "/spec_helper"

CreateSpecModel.apply(Sequel::Model.db, :up)
class SpecModel < Sequel::Model; end

describe 'Merb::Orms::Sequel::Model' do

  describe "active model" do
    it "should load active model plugin when > 3.5" do
      begin
        SpecModel.plugins.should include(Sequel::Plugins::ActiveModel)
      rescue NoMethodError
        pending("For this SPEC to run and pass you need to install Sequel >= 3.5") 
      end
    end

    it "should include ActiveModelCompatibility module if plugin is not available" do
      begin
        Sequel::Model.plugin :active_model
        pending("For this SPEC to run and pass you need to install Sequel < 3.5") 
      rescue LoadError, NoMethodError
        SpecModel.ancestors.should include(Merb::Orms::Sequel::Model::ActiveModelCompatibility)
      end
    end
  end

  describe "ActiveModelCompatiblity" do
    it "should add new_record?" do
      m = SpecModel.new
      m.should be_new_record
    end
  end
end
