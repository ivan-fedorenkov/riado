class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions, :id => false do |t|
      t.primary_key :code
      t.string :name
    end
    add_index :regions, :name, :unique => true
  end
end
