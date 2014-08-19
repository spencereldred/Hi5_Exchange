class LandingController < ApplicationController
  def index
    @users = User.all
    if current_user.profile.blank?
      # go to profile new page
      # depending on what function - go to single page app of that function
      puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@ we need a profile!"
    elsif current_user.profile.function == "recycler"
      # go to recycler single page app
      puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@ I am a recycler!"
    elsif current_user.profile.function == "redeemer"
      # go to redeemer single page app
      puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@ I am a redeemer!"
    end

  end
end
