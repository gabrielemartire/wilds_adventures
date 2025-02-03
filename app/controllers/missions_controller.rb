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
    @mission = Mission.create_mission
  end

  # GET /missions/1/edit
  def edit
  end

  # POST /missions or /missions.json
  def create
    @mission = Mission.new(mission_params)

    respond_to do |format|
      if @mission.save
        new_planet_discovered = create_planet(@mission)
        if new_planet_discovered
          format.html { redirect_to @mission, notice: "Mission was successfully created." }
          format.json { render :show, status: :created, location: @mission }
        else
          format.html { redirect_to @mission, notice: "Mission does not found planet" }
        end
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
      planet.name = rand(1..999).to_s + " " + [ "a", "b", "c", "d" ].sample
      planet.mission_id = mission.id
      planet.supply_oxygen = rand(-10..1)
      planet.supply_food = rand(-3..2)
      planet.supply_energy = rand(-10..10)
      planet.radiation = rand(0..10)
      planet.temperature = rand(-100..100)
      planet.save
    end
end
