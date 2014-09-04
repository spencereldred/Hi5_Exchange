class RedeemersController < ApplicationController

  def index
    @redeemables = Recyclable.where(trans_type: "redeemable", selected: false, completed: false).near([current_user.profile.latitude, current_user.profile.longitude], current_user.profile.radius)
    @samaritans = Recyclable.where(trans_type: "samaritan", selected: false, completed: false).near([current_user.profile.latitude, current_user.profile.longitude], current_user.profile.radius)
    # for testing geocoder in rails console:
    # @redeemables = Recyclable.where(trans_type: "redeemable", selected: false, completed: false).near([user.profile.latitude, user.profile.longitude], user.profile.radius)

    @redeemables_selected = Recyclable.where(selected_redeemer_id: current_user.id, trans_type: "redeemable", selected: true, completed: false)
    @samaritans_selected = Recyclable.where(selected_redeemer_id: current_user.id, trans_type: "samaritan", selected: true, completed: false)
    trans = Recyclable.near([current_user.profile.latitude, current_user.profile.longitude], current_user.profile.radius)
    respond_to do |format|
      format.html
      format.json { render :json => trans }
    end
  end

end