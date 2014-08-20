class ProfilesController < ApplicationController

  def show
    @profile = Profile.find(params[:id])
  end

  def new
    @profile = Profile.new
  end

  def create
    profile = Profile.new(profile_params)
    profile.user_id = current_user.id
    if profile.save
      flash[:notice] = "Profile was created successfully!"
      redirect_to profile_path(profile.id)
    else
      flash[:notice] = "Your profile could not be created."
      render :new
    end
    # ultimately redirect to "function" page
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  # def update
  # end

  private

    def profile_params
      params.require(:profile).permit(:first_name,
                                      :last_name,
                                      :address,
                                      :city,
                                      :state,
                                      :zipcode,
                                      :phone,
                                      :function)
    end

end