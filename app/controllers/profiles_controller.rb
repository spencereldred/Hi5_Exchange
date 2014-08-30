class ProfilesController < ApplicationController

  def show
    @profile = Profile.find(params_id)
  end

  def new
    @profile = Profile.new
  end

  def create
    profile = Profile.new(profile_params)
    profile.user_id = current_user.id
    if profile.save
      flash.notice = "Profile was created successfully!"
      if profile.function == "redeemer"
        Hi5Mailer.welcome_redeemer(profile.user).deliver
      else
        Hi5Mailer.welcome_recycler(profile.user).deliver
      end
      # redirecting to show - ultimately redirect to "function" page
      redirect_to profile_path(profile.id)
    else
      flash.notice = "Your profile could not be created."
      redirect_to new_profile_path
    end

  end

  def edit
    @profile = Profile.find(params_id)
  end

  def update
    profile = Profile.find(params_id)
    if profile.update_attributes(profile_params)
      flash.notice = "Profile was successfully updated!"
      # binding.pry
      ProfileUpdatedEmailTextWorker.perform_async(profile.user.id)
      # Hi5Mailer.profile_updated(profile.user).deliver
      # redirecting to show - ultimately redirect to "function" page
      redirect_to profile_path(params_id)
    else
      flash.notice = "Profile could not be updated."
      redirect_to edit_profile_path(params_id)
    end

  end

  private

    def params_id
      params[:id]
    end

    def profile_params
      params.require(:profile).permit(:first_name, :last_name,
                                      :address,    :city,
                                      :state,      :zipcode,
                                      :phone,      :function)
    end

end