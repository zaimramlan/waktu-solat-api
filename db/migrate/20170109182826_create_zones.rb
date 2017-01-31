class CreateZones < ActiveRecord::Migration[5.0]
  def change
    create_table :zones do |t|
      t.string :name
      t.integer :state_id
      t.string :code

      t.timestamps
    end
  end
end
