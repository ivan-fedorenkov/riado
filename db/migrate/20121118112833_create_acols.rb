class CreateAcols < ActiveRecord::Migration
  def change
    create_table :acols do |t|
      t.string :name, :null => false
      t.references :region

      t.timestamps
    end
    add_index :acols, :name, :unique => true
  end
end
