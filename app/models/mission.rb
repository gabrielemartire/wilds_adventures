class Mission < ApplicationRecord
  has_one :planet, dependent: :destroy

  def self.create_mission
    mission = Mission.new
    mission.name = [ "Apollo", "Artemis", "Ares", "Hermes", "Zeus", "Hera", "Athena", "Poseidon", "Hades", "Demeter" ].sample
    mission.name += " " + rand(1..99).to_s
    mission.status = "pending"
    mission.log = "Mission " + mission.name + " is pending."
    mission.level_oxygen = 100
    mission.level_food = 100
    mission.level_energy = 100
    mission
  end

  def is_alive?
    level_oxygen > 0 || level_food > 0
  end

  def offline?
    level_energy <= 0
  end

  def self.in_progress
    where(status: "in_progress")
  end
end
