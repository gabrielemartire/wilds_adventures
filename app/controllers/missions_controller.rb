class MissionsController < ApplicationController
  before_action :set_mission, only: %i[ show edit update destroy ]

  # GET /missions or /missions.json
  def index
    @missions = Mission.all
  end

  # GET /missions/1 or /missions/1.json
  def show
  end

  # GET /missions/new
  def new
    @mission = Mission.new
    @mission_name = [ "Apollo", "Artemis", "Ares", "Hermes", "Zeus", "Hera", "Athena", "Poseidon", "Hades", "Demeter" ].sample
    @mission_name += " " + rand(1..99).to_s
    @mission.name = @mission_name
    @mission.status = "pending"
    @mission.log = "Mission " + @mission_name + " is pending."
    @mission.level_oxygen = 100
    @mission.level_food = 100
    @mission.level_energy = 100
  end

  # GET /missions/1/edit
  def edit
  end

  # POST /missions or /missions.json
  def create
    @mission = Mission.new(mission_params)

    respond_to do |format|
      if @mission.save
        create_planet(@mission)
        format.html { redirect_to @mission, notice: "Mission was successfully created." }
        format.json { render :show, status: :created, location: @mission }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @mission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /missions/1 or /missions/1.json
  def update
    respond_to do |format|
      if @mission.update(mission_params)
        format.html { redirect_to @mission, notice: "Mission was successfully updated." }
        format.json { render :show, status: :ok, location: @mission }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @mission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /missions/1 or /missions/1.json
  def destroy
    @mission.destroy!

    respond_to do |format|
      format.html { redirect_to missions_path, status: :see_other, notice: "Mission was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mission
      @mission = Mission.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def mission_params
      params.expect(mission: [ :name, :status, :log, :level_oxygen, :level_food, :level_energy ])
    end

    def create_planet(mission)
      planet = Planet.new
      planet.name = rand(1..999).to_s + "-" + [ "a", "b", "c", "d" ].sample
      planet.mission_id = mission.id

      planet.supply_oxygen = rand(0..50)
      planet.supply_food = rand(-30..100)
      planet.supply_energy = rand(-100..100)
      planet.radiation = rand(0..10)
      planet.temperature = rand(-100..100)
      planet.save
    end
end
