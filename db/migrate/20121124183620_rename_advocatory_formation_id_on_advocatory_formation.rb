class RenameAdvocatoryFormationIdOnAdvocatoryFormation < ActiveRecord::Migration
  def up 
    remove_index :advocatory_formations, :advocatory_formation_id
    rename_column :advocatory_formations, :advocatory_formation_id, :head_department_id
    add_index :advocatory_formations, :head_department_id
  end
  def down
    remove_index :advocatory_formations, :head_department_id
    rename_column :advocatory_formations, :head_department_id, :advocatory_formation_id
    add_index :advocatory_formations, :advocatory_formation_id
  end
end
