class Recyclable < ActiveRecord::Base
  has_many :user_recyclables
  has_many :users, :through => :user_recyclables

  validates :trans_type, presence: true

end