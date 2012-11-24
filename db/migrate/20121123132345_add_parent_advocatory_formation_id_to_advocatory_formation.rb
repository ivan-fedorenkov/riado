class AddParentAdvocatoryFormationIdToAdvocatoryFormation < ActiveRecord::Migration
  def change
    add_column :advocatory_formations, :advocatory_formation_id, :integer 
    add_index :advocatory_formations, :advocatory_formation_id
  end
end
