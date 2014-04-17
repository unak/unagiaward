require 'test_helper'

class TopControllerTest < ActionController::TestCase
  teardown do
    session.clear
  end

  test "should get index" do
    get :index, locale: "en"
    assert_response :success
    assert_equal :en, I18n.locale
    assert_nil @controller.__send__(:page_title)

    get :index, locale: "ja"
    assert_response :success
    assert_equal :ja, I18n.locale
    assert_nil @controller.__send__(:page_title)
  end

  test "login_user" do
    assert_nil @controller.__send__(:login_user)

    login(:one)
    assert_equal users(:one), @controller.__send__(:login_user)
  end

  test "adminp" do
    refute @controller.__send__(:'admin?')

    login(:one)
    refute @controller.__send__(:'admin?')

    login(:admin)
    assert @controller.__send__(:'admin?')
  end
end
