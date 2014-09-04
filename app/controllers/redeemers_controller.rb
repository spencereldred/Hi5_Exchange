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
    # Update is triggered by the "select" and "unselect" checkboxes and
    # by the complete button on the Redeemers index page
    binding.pry
    trans = Recyclable.find(params[:id])
    puts "@@@@@@@@@@ this is trans: #{trans}"
    redeemer = {selected: params[:selected],
                selected_date: params[:selected_date],
                selected_redeemer_id: params[:selected_redeemer_id],
                completed: params[:completed],
                completed_date: params[:completed_date]}
    trans.update_attributes(redeemer)
    # TransactionUpdateEmailTextWorker.perform_async(trans.id)
    respond_to do |format|
      format.json {render :json => trans}
      format.html
    end
  end

  private

    def recyclable_update
      params.require(:recyclable).permit(
        :selected, :selected_date,
        :completed, :completed_date,
        :selected_redeemer_id)
    end

end