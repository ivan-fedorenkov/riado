class CreateAdvocates < ActiveRecord::Migration
  def change
    create_table :advocates do |t|
      t.string :second_name
      t.string :first_name
      t.string :patronomic
      t.string :reg_num
      t.string :status
      t.string :sex
      t.references :acol

      t.timestamps
    end
    add_index :advocates, :second_name
    add_index :advocates, :reg_num, :unique => true
    add_index :advocates, :status
  end
end
