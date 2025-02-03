require "sidekiq"

class MissionEventJob < ApplicationJob
  queue_as :default

  def perform
    Mission.in_progress.each do |mission|
      puts "++++++++ A new day for #{mission.name} on [#{mission.planet&.name}] +++++++"
      a_day_passed(mission, mission.planet)
      event = generate_random_event(mission)
      mission.update(
        log: mission.log + "\n - #{event[:description]}",
        level_oxygen: mission.level_oxygen + event[:oxygen],
        level_food: mission.level_food + event[:food],
        level_energy: mission.level_energy + event[:energy]
      )
    end
  end

  private

  def generate_random_event(mission)
    events = [
      { description: "Meteora colpisce la base", oxygen: -5, food: 0, energy: -5 },
      { description: "Tempesta di sabbia", oxygen: 0, food: -3, energy: -5 },
      { description: "Incendio nella base", oxygen: -5, food: -5, energy: -5 },
      { description: "Rottura del sistema di riciclo dell'aria", oxygen: -10, food: 0, energy: 0 },
      { description: "Rottura del sistema di riciclo dell'acqua", oxygen: 0, food: -10, energy: 0 },
      { description: "Rottura del sistema di riciclo dell'energia", oxygen: 0, food: 0, energy: -10 },
      { description: "malfunzionamento Rover", oxygen: -5, food: 0, energy: -5 },
      { description: "Niente da dichiarare", oxygen: 0, food: 0, energy: 0 },
      { description: "Niente da dichiarare", oxygen: 0, food: 0, energy: 0 },
      { description: "Niente da dichiarare", oxygen: 0, food: 0, energy: 0 },
      { description: "oggi pranzo completo", oxygen: 0, food: -1, energy: 0 },
      { description: "Tempesta Solare", oxygen: 0, food: 0, energy: 10 },
      { description: "Piantagione di Patate a regime", oxygen: 0, food: 10, energy: 0 },
      { description: "H2O a regime", oxygen: 10, food: 0, energy: 0 }
    ]
    events.sample
  end

  def a_day_passed(mission, planet)
    mission.update(
      level_oxygen: mission.level_oxygen + planet.supply_oxygen,
      level_food: mission.level_food + planet.supply_food,
      level_energy: mission.level_energy + planet.supply_energy
    )
  end
end
