require 'test_helper'

class CharacterRosterRolesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @character_roster_role = character_roster_roles(:one)
  end

  test "should get index" do
    get character_roster_roles_url, as: :json
    assert_response :success
  end

  test "should create character_roster_role" do
    assert_difference('CharacterRosterRole.count') do
      post character_roster_roles_url, params: { character_roster_role: { character_id: @character_roster_role.character_id, role: @character_roster_role.role, roster_id: @character_roster_role.roster_id } }, as: :json
    end

    assert_response 201
  end

  test "should show character_roster_role" do
    get character_roster_role_url(@character_roster_role), as: :json
    assert_response :success
  end

  test "should update character_roster_role" do
    patch character_roster_role_url(@character_roster_role), params: { character_roster_role: { character_id: @character_roster_role.character_id, role: @character_roster_role.role, roster_id: @character_roster_role.roster_id } }, as: :json
    assert_response 200
  end

  test "should destroy character_roster_role" do
    assert_difference('CharacterRosterRole.count', -1) do
      delete character_roster_role_url(@character_roster_role), as: :json
    end

    assert_response 204
  end
end
