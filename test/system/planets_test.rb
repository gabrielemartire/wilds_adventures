require "application_system_test_case"

class PlanetsTest < ApplicationSystemTestCase
  setup do
    @planet = planets(:one)
  end

  test "visiting the index" do
    visit planets_url
    assert_selector "h1", text: "Planets"
  end

  test "should create planet" do
    visit planets_url
    click_on "New planet"

    fill_in "Mission", with: @planet.mission_id
    fill_in "Name", with: @planet.name
    fill_in "Radiation", with: @planet.radiation
    fill_in "Supply energy", with: @planet.supply_energy
    fill_in "Supply food", with: @planet.supply_food
    fill_in "Supply oxygen", with: @planet.supply_oxygen
    fill_in "Temperature", with: @planet.temperature
    click_on "Create Planet"

    assert_text "Planet was successfully created"
    click_on "Back"
  end

  test "should update Planet" do
    visit planet_url(@planet)
    click_on "Edit this planet", match: :first

    fill_in "Mission", with: @planet.mission_id
    fill_in "Name", with: @planet.name
    fill_in "Radiation", with: @planet.radiation
    fill_in "Supply energy", with: @planet.supply_energy
    fill_in "Supply food", with: @planet.supply_food
    fill_in "Supply oxygen", with: @planet.supply_oxygen
    fill_in "Temperature", with: @planet.temperature
    click_on "Update Planet"

    assert_text "Planet was successfully updated"
    click_on "Back"
  end

  test "should destroy Planet" do
    visit planet_url(@planet)
    click_on "Destroy this planet", match: :first

    assert_text "Planet was successfully destroyed"
  end
end
