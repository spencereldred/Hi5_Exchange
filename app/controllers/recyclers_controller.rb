class RecyclersController < ApplicationController

  def index
    user = User.find(current_user.id)
    @recyclables = user.recyclables.where(trans_type: 'redeemable')
    @samaritans = user.recyclables.where(trans_type: 'samaritan')
    # binding.pry
  end

end