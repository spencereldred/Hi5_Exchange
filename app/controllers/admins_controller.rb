class AdminsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  # before_action :authenticate_user!


  def index
    @current_profile = Profile.where(user_id: current_user.id)[0]

  end

end