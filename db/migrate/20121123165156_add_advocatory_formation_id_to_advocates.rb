class AddAdvocatoryFormationIdToAdvocates < ActiveRecord::Migration
  def change
    add_column :advocates, :advocatory_formation_id, :integer
    add_index :advocates, :advocatory_formation_id
  end
end
