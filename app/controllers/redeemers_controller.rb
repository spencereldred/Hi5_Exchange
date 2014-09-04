class RedeemersController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def index
    @redeemables = Recyclable.where(trans_type: "redeemable", selected: false, completed: false).near([current_user.profile.latitude, current_user.profile.longitude], current_user.profile.radius)
    @samaritans = Recyclable.where(trans_type: "samaritan", selected: false, completed: false).near([current_user.profile.latitude, current_user.profile.longitude], current_user.profile.radius)
    # for testing geocoder in rails console:
    # @redeemables = Recyclable.where(trans_type: "redeemable", selected: false, completed: false).near([user.profile.latitude, user.profile.longitude], user.profile.radius)

    @redeemables_selected = Recyclable.where(selected_redeemer_id: current_user.id, trans_type: "redeemable", selected: true, completed: false).near([current_user.profile.latitude, current_user.profile.longitude], current_user.profile.radius)
    @samaritans_selected = Recyclable.where(selected_redeemer_id: current_user.id, trans_type: "samaritan", selected: true, completed: false).near([current_user.profile.latitude, current_user.profile.longitude], current_user.profile.radius)
    trans = Recyclable.near([current_user.profile.latitude, current_user.profile.longitude], current_user.profile.radius)
    respond_to do |format|
      format.html
      format.json { render :json => trans }
    end
  end

  def update
    # Update is triggered by the "select" and "completed" links
    # on the Redeemers index page
    trans = Recyclable.find(params[:id])
    trans.update_attributes(recyclable_update)
    TransactionUpdateEmailTextWorker.perform_async(trans.id)
    respond_to do |format|
      format.json {render :json => trans}
      format.html
    end
  end

  private

    def recyclable_update
      params.require(:redeemer).permit(
        :selected, :selected_date,
        :completed, :completed_date,
        :selected_redeemer_id)
    end

end