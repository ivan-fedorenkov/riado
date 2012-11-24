class RecreateRegionsTable < ActiveRecord::Migration
  def up
    drop_table :regions
    create_table :regions do |t|
      t.string :name, :null => false
    end
    add_index :regions, :name, :uniqeue => true
  end

  def down
    create_table "regions", :primary_key => "code", :force => true do |t|
      t.string "name"
    end
  
    add_index "regions", ["name"], :name => "index_regions_on_name", :unique => true
  end
end
