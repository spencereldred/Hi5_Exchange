class Profile < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence:true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true

end