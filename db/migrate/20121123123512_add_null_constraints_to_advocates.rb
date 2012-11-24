class AddNullConstraintsToAdvocates < ActiveRecord::Migration
  def up
    change_column :advocates, :reg_num, :string, :null => false
    change_column :advocates, :status, :string, :null => false
    change_column :advocates, :acol_id, :integer, :null => false
  end
  def down
    change_column :advocates, :reg_num, :string
    change_column :advocates, :status, :string
    change_column :advocates, :acol_id, :integer
  end
end
