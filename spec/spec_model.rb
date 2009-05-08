# Dummy model for testing
class SpecModel < Sequel::Model
end

# Migrations to create the table
class CreateSpecModel < Sequel::Migration
  def up
    create_table! :spec_models do
      primary_key :id
      text :name
    end
  end
  
  def down
    drop_table :spec_models
  end
end

# Shared describe to run migration
describe "it has a SpecModel", :shared => true do
  before(:each) do
    CreateSpecModel.apply(SpecModel.db, :up)
  end
  
  after(:each) do
    CreateSpecModel.apply(SpecModel.db, :down)
  end
end
