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
