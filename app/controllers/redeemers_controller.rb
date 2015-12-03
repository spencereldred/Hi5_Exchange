class RedeemersController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  # before_action :authenticate_user!

  def index
    # returns transactions in a 20 mile radius to Redeemers index page
    @current_profile = Profile.where(user_id: current_user.id)[0]
    puts "@@@@@@@@@@@@@@@@@??????????!!!!!!!!!!!!!!!! #{@current_profile.inspect} !!!!!!!!!!????????@@@@@"
    trans = Transaction.near([@current_profile.latitude, @current_profile.longitude], @current_profile.radius)
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
      trans.update_attributes(transaction_update_params)
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

  private

    def transaction_update_params
      params.require(:redeemer).permit(
                                        :selected,  :selection_date,
                                        :completed, :completion_date,
                                        :redeemer_user_id
                                      )
    end

    def update_flash_notice(recyclable)
      if recyclable.selected and !recyclable.completed
        user_recyclable = UserRecyclable.all.where(recyclable_id: recyclable.id)
        user_recyclable.last.redeemer_id = current_user.id
        user_recyclable.last.save
        if recyclable.trans_type == "redeemable"
          flash.notice = "Redeemable transaction has been selected!"
        else
          flash.notice = "Good Samaritan transaction has been selected!"
        end
        # TransactionUpdateEmailTextWorker.perform_async(recyclable.id)
      end
      if recyclable.selected and recyclable.completed
        if recyclable.trans_type == "redeemable"
          flash.notice = "Redeemable transaction has been completed!"
        else
          flash.notice = "Good Samaritan transaction has been completed!"
        end
        # TransactionUpdateEmailTextWorker.perform_async(recyclable.id)
      end
      redirect_to redeemers_path
    end

end