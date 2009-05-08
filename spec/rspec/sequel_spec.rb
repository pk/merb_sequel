require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../../lib/merb_sequel/rspec/sequel'

describe "Transaction enabled examples" do

  before(:all) do
    CreateSpecModel.apply(SpecModel.db, :up)
  end

  after(:all) do
    CreateSpecModel.apply(SpecModel.db, :down)
  end

  it "should wrap each example in transaction and rollback" do
    a = SpecModel.create(:name => 'Pavel')
    a.should_not be_new
  end

  it "should not have Pavel in the database" do
    a = SpecModel.find(:name => 'Pavel')
    a.should be_nil
  end
end
