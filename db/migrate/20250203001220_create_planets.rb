class CreatePlanets < ActiveRecord::Migration[8.0]
  def change
    create_table :planets do |t|
      t.string :name
      t.references :mission, null: false, foreign_key: true
      t.integer :supply_oxygen
      t.integer :supply_food
      t.integer :supply_energy
      t.integer :radiation
      t.integer :temperature

      t.timestamps
    end
  end
end
