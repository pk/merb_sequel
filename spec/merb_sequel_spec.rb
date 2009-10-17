require File.dirname(__FILE__) + "/spec_helper"

describe Merb::Orms::Sequel::Connect do
  it "should be loaded at plugin bootstrap" do
    defined?(Merb::Orms::Sequel::Connect).should == "constant"
  end

  it "should be Merb::BootLoader" do
    Merb::Orms::Sequel::Connect.superclass.should eql(Merb::BootLoader)
  end

  it "should provide default settings" do
    Merb::Plugins.config[:merb_sequel].should include(:load_activemodel_compatibility)
  end
end
