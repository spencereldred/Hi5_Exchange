class RedeemersController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  # before_action :authenticate_user!

  def index
    # returns transactions in a 20 mile radius to Redeemers index page
    @current_profile = Profile.where(user_id: current_user.id)[0]
    puts "@@@@@@@@@@@@@@@@@??????????!!!!!!!!!!!!!!!! #{@current_profile.inspect} !!!!!!!!!!????????@@@@@"
    # binding.pry
    trans = Transaction.near([@current_profile.latitude, @current_profile.longitude], @current_profile.radius)
    # binding.pry
    # trans = Transaction.all
    respond_to do |format|
      format.html
      format.json { render :json => trans }
    end
  end

  def update
    # Update is triggered by the "select" and "unselect" checkboxes and
    # by the complete button on the Redeemers index page
    trans = Transaction.find(params[:id])
    # only update selected if it has not been selected already
    if ( (params[:selected] == true && trans.selected == false) ||
         (params[:selected] == true && trans.selected == true &&
          params[:completed] == true && trans.completed == false) )
      # redeemer = {selected: params[:selected],
      #           selection_date: params[:selection_date],
      #           redeemer_user_id: params[:redeemer_user_id],
      #           completed: params[:completed],
      #           completion_date: params[:completion_date]}
      trans.update_attributes(recyclable_update)
    end

    if trans.errors.empty?
      # TransactionUpdateEmailWorker.perform_async(trans.id)
      # TransactionUpdateTextWorker.perform_async(trans.id)
    end

    respond_to do |format|
      format.json {render :json => trans}
      format.html
    end
  end

  # def index
  #   # @redeemables = Recyclable.where(trans_type: "redeemable", selected: false, completed: false).near([current_user.profile.latitude, current_user.profile.longitude], current_user.profile.radius)
  #   # @samaritans = Recyclable.where(trans_type: "samaritan", selected: false, completed: false).near([current_user.profile.latitude, current_user.profile.longitude], current_user.profile.radius)
  #   # for testing geocoder in rails console:
  #   # @redeemables = Recyclable.where(trans_type: "redeemable", selected: false, completed: false).near([user.profile.latitude, user.profile.longitude], user.profile.radius)

  #   # @redeemables_selected = Recyclable.where(selected_redeemer_id: current_user.id, trans_type: "redeemable", selected: true, completed: false).near([current_user.profile.latitude, current_user.profile.longitude], current_user.profile.radius)
  #   # @samaritans_selected = Recyclable.where(selected_redeemer_id: current_user.id, trans_type: "samaritan", selected: true, completed: false).near([current_user.profile.latitude, current_user.profile.longitude], current_user.profile.radius)
  #   trans = Recyclable.where(completed: false).near([current_user.profile.latitude, current_user.profile.longitude], current_user.profile.radius)
  #   respond_to do |format|
  #     format.html
  #     format.json { render :json => trans }
  #   end
  # end

  # def update
  #   # Update is triggered by the "select" and "completed" links
  #   # on the Redeemers index page
  #   trans = Recyclable.find(params[:id])
  #   trans.update_attributes(recyclable_update)
  #   # TransactionUpdateEmailTextWorker.perform_async(trans.id)
  #   respond_to do |format|
  #     format.json {render :json => trans}
  #     format.html
  #   end
  # end

  private

    def recyclable_update
      params.require(:redeemer).permit(
        :selected, :selection_date, :completed, :completion_date,
        :id, :redeemer_user_id, :recycler_user_id, :group_id,
        :address, :city, :state, :zipcode,
        :plastic, :cans, :glass, :other,
        :rating, :longitude, :latitude,
        :cardboard, :non_hi5_plastic, :non_hi5_cans, :non_hi5_glass,
        :magazines, :newspaper, :paper,
        :trans_type, :created_at, :updated_at, :distance, :bearing)
    end

end