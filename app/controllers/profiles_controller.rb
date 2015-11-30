class ProfilesController < ApplicationController

  def index
    # for test only
    users = Profile.all
    # image = ["img": "some image"]
    respond_to do |format|
      format.html
      format.json { render :json => users }
    end
  end

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
        WelcomeEmailTextRedeemerWorker.perform_async(profile.user.id)
      else
        WelcomeEmailTextRecyclerWorker.perform_async(profile.user.id)
      end
      # redirecting to show - ultimately redirect to "function" page
      redirect_to root_path
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
      ProfileUpdatedEmailTextWorker.perform_async(profile.user)
      redirect_to root_path
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