class LandingController < ApplicationController
  def index
    @users = User.all
    # binding.pry
    # case user[:function]
    #   when "redeemer"
    #     redirect_to redeemers_path
    #   when "recycler"
    #     redirect_to transactions_path
    #   when "admin"
    #     redirect_to admins_path
    #   when "super_admin"
    #     redirect_to admins_path
    #   else
    #     puts "I'm not a redeemer."
    # end
    if current_user.profile.blank?
      redirect_to new_profile_path
    elsif current_user.profile.function == "recycler"
      redirect_to transactions_path
    elsif current_user.profile.function == "redeemer"
      redirect_to redeemers_path
    elsif current_user.profile.function == "admin"
      redirect_to admins_path
    elsif current_user.profile.function == "super_admin"
      redirect_to admins_path
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
