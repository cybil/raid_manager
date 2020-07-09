require 'test_helper'

class BasicComposControllerTest < ActionDispatch::IntegrationTest
  setup do
    @basic_compo = basic_compos(:one)
  end

  test "should get index" do
    get basic_compos_url, as: :json
    assert_response :success
  end

  test "should create basic_compo" do
    assert_difference('BasicCompo.count') do
      post basic_compos_url, params: { basic_compo: { name: @basic_compo.name, template: @basic_compo.template } }, as: :json
    end

    assert_response 201
  end

  test "should show basic_compo" do
    get basic_compo_url(@basic_compo), as: :json
    assert_response :success
  end

  test "should update basic_compo" do
    patch basic_compo_url(@basic_compo), params: { basic_compo: { name: @basic_compo.name, template: @basic_compo.template } }, as: :json
    assert_response 200
  end

  test "should destroy basic_compo" do
    assert_difference('BasicCompo.count', -1) do
      delete basic_compo_url(@basic_compo), as: :json
    end

    assert_response 204
  end
end
