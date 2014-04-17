require 'test_helper'

class NominateTest < ActiveSupport::TestCase
  test "validations" do
    nominate = Nominate.new
    refute nominate.valid?
    assert nominate.errors[:user].any?
    assert nominate.errors[:candidate].any?
    assert nominate.errors[:reason].any?

    nominate.user = users(:one)
    refute nominate.valid?
    refute nominate.errors[:user].any?
    assert nominate.errors[:candidate].any?
    assert nominate.errors[:reason].any?

    nominate.candidate = ""
    refute nominate.valid?
    assert nominate.errors[:candidate].any?
    assert nominate.errors[:reason].any?

    nominate.candidate = "a" * 33
    refute nominate.valid?
    assert nominate.errors[:candidate].any?
    assert nominate.errors[:reason].any?

    nominate.candidate = "a" * 32
    refute nominate.valid?
    refute nominate.errors[:candidate].any?
    assert nominate.errors[:reason].any?

    nominate.reason = ""
    refute nominate.valid?
    assert nominate.errors[:reason].any?

    nominate.reason = "a" * 141
    refute nominate.valid?
    assert nominate.errors[:reason].any?

    nominate.reason = "a" * 140
    assert nominate.valid?
    refute nominate.errors[:reason].any?
  end
end
