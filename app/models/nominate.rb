class Nominate < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :candidate, presence: true
  validates :reason, presence: true
end
