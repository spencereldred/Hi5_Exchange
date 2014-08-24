class LandingController < ApplicationController
  def index
    @users = User.all
    # binding.pry
    if current_user.profile.blank?
      # go to profile new page
      redirect_to new_profile_path
    elsif current_user.profile.function == "recycler"
      # go to recycler controller index
      recyclers_path
    elsif current_user.profile.function == "redeemer"
      # go to redeemer controller index
      # redeemers_path
      puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@ I am a redeemer!"
    end

    # respond_to do |format|
    #   format.json
    #   format.html          # /app/views/landing/index.html.erb
    #   format.html.phone    # /app/views/landing/index.html+phone.erb
    #   format.html.tablet   # /app/views/landing/index.html+tablet.erb
    # end

  end
end
