class CreateNominates < ActiveRecord::Migration
  def change
    create_table :nominates do |t|
      t.integer :user_id, null: false
      t.string :candidate, null: false, limit: 32
      t.string :reason, null: false, limit: 140

      t.timestamps
    end
  end
end
