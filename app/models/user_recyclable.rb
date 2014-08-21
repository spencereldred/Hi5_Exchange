class UserRecyclable < ActiveRecord::Base
  belongs_to :user
  belongs_to :recyclable

  validates :user_id, presence: true
  validates :recyclable_id, presence: true

end