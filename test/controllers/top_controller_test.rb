require 'test_helper'

class TopControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, locale: "en"
    assert_response :success
    assert_equal :en, I18n.locale

    get :index, locale: "ja"
    assert_response :success
    assert_equal :ja, I18n.locale
  end
end
