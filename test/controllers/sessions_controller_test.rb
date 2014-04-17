require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get create" do
    request.env["omniauth.auth"] = { 'provider' => 'twitter', 'uid' => '1', 'info' => { 'nickname' => 'twitter_user' } }
    session.clear
    get :create
    assert_redirected_to root_path
    assert_not_nil session['user_id']

    request.env["omniauth.auth"] = { 'provider' => 'twitter', 'uid' => '1', 'info' => { 'nickname' => 'twitter_user' } }
    session.clear
    session[:previous] = nominates_path
    get :create
    assert_redirected_to nominates_path
    assert_not_nil session['user_id']
  end

  test "should get destroy" do
    session['user_id'] = users(:one).id
    get :destroy
    assert_redirected_to root_path
    assert_nil session['user_id']
  end
end
