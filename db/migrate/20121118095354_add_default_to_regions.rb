class AddDefaultToRegions < ActiveRecord::Migration
  def change
    add_column :regions, :default, :boolean, :default => false
  end
end
