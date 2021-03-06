class Profile < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  validates :user_id, presence:true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true
  validates :function, presence: true
  # :phone is optional

  geocoded_by :full_address
  after_validation :geocode

  def full_address
     "#{self.address}, #{self.city} #{self.state} #{self.zipcode}"
  end

end