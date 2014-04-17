require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "validations" do
    user = User.new
    refute user.valid?
    assert user.errors[:provider].any?
    assert user.errors[:uid].any?
    assert user.errors[:name].any?

    user.provider = ""
    refute user.valid?
    assert user.errors[:provider].any?
    assert user.errors[:uid].any?
    assert user.errors[:name].any?

    user.provider = "twitter"
    refute user.valid?
    refute user.errors[:provider].any?
    assert user.errors[:uid].any?
    assert user.errors[:name].any?

    user.uid = ""
    refute user.valid?
    assert user.errors[:uid].any?
    assert user.errors[:name].any?

    user.uid = "999"
    refute user.valid?
    refute user.errors[:uid].any?
    assert user.errors[:name].any?

    user.name = ""
    refute user.valid?
    assert user.errors[:name].any?

    user.name = "foo"
    assert user.valid?
    refute user.errors[:name].any?

    user.provider = users(:one).provider
    user.uid = users(:one).uid
    refute user.valid?
    assert user.errors[:uid].any?

    user.provider = users(:one).provider
    user.uid = "999"
    assert user.valid?
    refute user.errors[:uid].any?

    user.provider = "github"
    user.uid = users(:one).uid
    assert user.valid?
    refute user.errors[:uid].any?
  end

  test "create_with_auth" do
    user = nil

    assert_difference("User.count") do
      user = User.create_with_auth("provider" => "twitter", "uid" => "999", "info" => { "nickname" => "nick" })
    end
    assert_equal "twitter", user.provider
    assert_equal "999", user.uid
    assert_equal "nick", user.name

    assert_difference("User.count") do
      user = User.create_with_auth("provider" => "twitter", "uid" => "998", "info" => { "name" => "name" })
    end
    assert_equal "twitter", user.provider
    assert_equal "998", user.uid
    assert_equal "name", user.name

    assert_difference("User.count") do
      user = User.create_with_auth("provider" => "twitter", "uid" => "997", "info" => { "nickname" => "nick", "name" => "name" })
    end
    assert_equal "twitter", user.provider
    assert_equal "997", user.uid
    assert_equal "nick", user.name
  end
end
