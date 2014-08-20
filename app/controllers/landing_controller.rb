class LandingController < ApplicationController
  def index
    @users = User.all
    # binding.pry
    if current_user.profile.blank?
      # go to profile new page
      # depending on what function - go to single page app of that function
      # puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@ we need a profile!"
    elsif current_user.profile.function == "recycler"
      # go to recycler single page app
      puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@ I am a recycler!"
    elsif current_user.profile.function == "redeemer"
      # go to redeemer single page app
      puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@ I am a redeemer!"
    end

    respond_to do |format|
      format.json
      format.html          # /app/views/landing/index.html.erb
      format.html.phone    # /app/views/landing/index.html+phone.erb
      format.html.tablet   # /app/views/landing/index.html+tablet.erb
    end

  end
end
