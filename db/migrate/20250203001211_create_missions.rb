class CreateMissions < ActiveRecord::Migration[8.0]
  def change
    create_table :missions do |t|
      t.string :name
      t.string :status
      t.text :log
      t.integer :level_oxygen
      t.integer :level_food
      t.integer :level_energy

      t.timestamps
    end
  end
end
