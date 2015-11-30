class Group < ActiveRecord::Base
  has_many :profiles
  has_many :transactions


end
