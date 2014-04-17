class Nominate < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :candidate, presence: true, length: { maximum: 32 }
  validates :reason, presence: true, length: { maximum: 140 }
end
