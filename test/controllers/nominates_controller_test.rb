require 'test_helper'

class NominatesControllerTest < ActionController::TestCase
  setup do
    @nominate = nominates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nominates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nominate" do
    assert_difference('Nominate.count') do
      post :create, nominate: { candidate: @nominate.candidate, reason: @nominate.reason, user_id: @nominate.user_id }
    end

    assert_redirected_to nominate_path(assigns(:nominate))
  end

  test "should show nominate" do
    get :show, id: @nominate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @nominate
    assert_response :success
  end

  test "should update nominate" do
    patch :update, id: @nominate, nominate: { candidate: @nominate.candidate, reason: @nominate.reason, user_id: @nominate.user_id }
    assert_redirected_to nominate_path(assigns(:nominate))
  end

  test "should destroy nominate" do
    assert_difference('Nominate.count', -1) do
      delete :destroy, id: @nominate
    end

    assert_redirected_to nominates_path
  end
end
