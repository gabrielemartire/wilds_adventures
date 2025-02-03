json.extract! planet, :id, :name, :mission_id, :supply_oxygen, :supply_food, :supply_energy, :radiation, :temperature, :created_at, :updated_at
json.url planet_url(planet, format: :json)
