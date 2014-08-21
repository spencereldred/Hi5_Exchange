class UserRecyclable < ActiveRecord::Base
  belongs_to :user
  belongs_to :recyclable
end