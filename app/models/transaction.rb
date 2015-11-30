class Transaction < ActiveRecord::Base
  belongs_to :group

  validates :trans_type, presence: true
  validates :recycler_user_id, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true

  geocoded_by :full_address
  after_validation :geocode

  def full_address
     "#{self.address}, #{self.city} #{self.state} #{self.zipcode}"
  end

  # geocoded_by :full_address
  # after_validation :geocode

  # private

  #   def full_address
  #     # user = User.find(self.user_id)
  #      # "#{user.profile.address}, #{user.profile.city} #{user.profile.state} #{user.profile.zipcode}"
  #      "#{address}, #{city} #{state} #{zipcode}"
  #   end

end