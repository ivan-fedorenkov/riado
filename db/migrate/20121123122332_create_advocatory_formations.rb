class CreateAdvocatoryFormations < ActiveRecord::Migration
  def change
    create_table :advocatory_formations do |t|
      t.string :name, :null => false
      t.string :form, :null => false
      t.references :acol

      t.timestamps
    end
    add_index :advocatory_formations, :name
    add_index :advocatory_formations, :form
    add_index :advocatory_formations, :acol_id
  end
end
