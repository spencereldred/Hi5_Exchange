class LandingController < ApplicationController
  def index
    @users = User.all

    if current_user.profile.blank?
      redirect_to new_profile_path
    else
      case current_user.profile.function
        when "redeemer"
          redirect_to redeemers_path
        when "recycler"
          redirect_to transactions_path
        when "group_admin"
          redirect_to admins_path
        when "super_admin"
          redirect_to admins_path
        else
          puts "I'm not a redeemer."
      end
    end

    # respond_to do |format|
    #   format.json
    #   format.html          # /app/views/landing/index.html.erb
    #   format.html.phone    # /app/views/landing/index.html+phone.erb
    #   format.html.tablet   # /app/views/landing/index.html+tablet.erb
    # end

  end

  def about
  end
end
