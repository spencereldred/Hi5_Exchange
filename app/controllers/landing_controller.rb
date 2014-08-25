class LandingController < ApplicationController
  def index
    @users = User.all
    # binding.pry
    if current_user.profile.blank?
      redirect_to new_profile_path
    elsif current_user.profile.function == "recycler"
      redirect_to recyclables_path
    elsif current_user.profile.function == "redeemer"
      # go to redeemer controller index
      redirect_to redeemers_path
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
