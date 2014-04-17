require 'test_helper'

class NominatesControllerTest < ActionController::TestCase
  setup do
    %i(one two).each do |e|
      n = nominates(e)
      n.user_id = users(:one).id
      n.save!
    end

    @nominate = nominates(:one)
  end

  teardown do
    session.clear
  end

  def login(user = :one)
    session[:user_id] = users(user).id
  end

  test "should get index" do
    get :index, locale: "en"
    assert_redirected_to root_path
    assert_not_nil flash[:alert]
    flash.clear

    login
    get :index, locale: "en"
    assert_redirected_to root_path
    assert_not_nil flash[:alert]
    flash.clear

    login(:admin)
    get :index, locale: "en"
    assert_response :success
    assert_not_nil assigns(:nominates)
    assert_nil flash[:alert]
  end

  test "should get new" do
    get :new, locale: "en"
    assert_response :success
    assert_nil flash[:alert]
  end

  test "should create nominate" do
    assert_no_difference('Nominate.count') do
      post :create, locale: "en", nominate: { candidate: @nominate.candidate, reason: @nominate.reason, user_id: @nominate.user_id }
    end
    assert_response :success
    assert_template :new
    flash.clear

    login
    assert_difference('Nominate.count') do
      post :create, locale: "en", nominate: { candidate: @nominate.candidate, reason: @nominate.reason, user_id: @nominate.user_id }
    end
    assert_redirected_to action: :new
    assert_nil flash[:alert]
    assert_not_nil flash[:notice]
    flash.clear

    login(:admin)
    assert_difference('Nominate.count') do
      post :create, locale: "en", nominate: { candidate: @nominate.candidate, reason: @nominate.reason, user_id: @nominate.user_id }
    end
    assert_redirected_to action: :new
    assert_nil flash[:alert]
    assert_not_nil flash[:notice]
  end

  test "should show nominate" do
    get :show, locale: "en", id: @nominate
    assert_redirected_to root_path
    assert_not_nil flash[:alert]
    flash.clear

    login
    get :show, locale: "en", id: @nominate
    assert_redirected_to root_path
    assert_not_nil flash[:alert]
    flash.clear

    login(:admin)
    get :show, locale: "en", id: @nominate
    assert_response :success
    assert_nil flash[:alert]
  end

  test "should get edit" do
    get :edit, locale: "en", id: @nominate
    assert_redirected_to root_path
    assert_not_nil flash[:alert]
    flash.clear

    login
    get :edit, locale: "en", id: @nominate
    assert_redirected_to root_path
    assert_not_nil flash[:alert]
    flash.clear

    login(:admin)
    get :edit, locale: "en", id: @nominate
    assert_response :success
    assert_nil flash[:alert]
  end

  test "should update nominate" do
    patch :update, locale: "en", id: @nominate, nominate: { candidate: @nominate.candidate, reason: @nominate.reason, user_id: @nominate.user_id }
    assert_redirected_to root_path
    assert_not_nil flash[:alert]
    flash.clear

    login
    patch :update, locale: "en", id: @nominate, nominate: { candidate: @nominate.candidate, reason: @nominate.reason, user_id: @nominate.user_id }
    assert_redirected_to root_path
    assert_not_nil flash[:alert]
    flash.clear

    login(:admin)
    patch :update, locale: "en", id: @nominate, nominate: { candidate: @nominate.candidate, reason: @nominate.reason, user_id: @nominate.user_id }
    assert_redirected_to nominate_path(assigns(:nominate), locale: "en")
    assert_nil flash[:alert]
    assert_not_nil flash[:notice]
  end

  test "should destroy nominate" do
    assert_no_difference('Nominate.count', -1) do
      delete :destroy, locale: "en", id: @nominate
    end
    assert_redirected_to root_path
    assert_not_nil flash[:alert]
    flash.clear

    login
    assert_no_difference('Nominate.count', -1) do
      delete :destroy, locale: "en", id: @nominate
    end
    assert_redirected_to root_path
    assert_not_nil flash[:alert]
    flash.clear

    login(:admin)
    assert_difference('Nominate.count', -1) do
      delete :destroy, locale: "en", id: @nominate
    end
    assert_redirected_to nominates_path
    assert_nil flash[:alert]
    assert_not_nil flash[:notice]
  end
end
