require 'test_helper'

class RoostersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rooster = roosters(:one)
  end

  test "should get index" do
    get roosters_url, as: :json
    assert_response :success
  end

  test "should create rooster" do
    assert_difference('Rooster.count') do
      post roosters_url, params: { rooster: { name: @rooster.name } }, as: :json
    end

    assert_response 201
  end

  test "should show rooster" do
    get rooster_url(@rooster), as: :json
    assert_response :success
  end

  test "should update rooster" do
    patch rooster_url(@rooster), params: { rooster: { name: @rooster.name } }, as: :json
    assert_response 200
  end

  test "should destroy rooster" do
    assert_difference('Rooster.count', -1) do
      delete rooster_url(@rooster), as: :json
    end

    assert_response 204
  end
end
