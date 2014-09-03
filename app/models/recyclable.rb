class Recyclable < ActiveRecord::Base
  has_many :user_recyclables
  has_many :users, :through => :user_recyclables

  validates :trans_type, presence: true

  geocoded_by :full_address
  after_validation :geocode

  private

    def full_address
      # user = User.find(self.user_id)
       # "#{user.profile.address}, #{user.profile.city} #{user.profile.state} #{user.profile.zipcode}"
       "#{address}, #{city} #{state} #{zipcode}"
    end

end