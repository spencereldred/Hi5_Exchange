class Group < ActiveRecord::Base
  has_many :profiles
  has_many :transactions

  validates :name, presence: true
  validates :promo_code, presence: true

end
