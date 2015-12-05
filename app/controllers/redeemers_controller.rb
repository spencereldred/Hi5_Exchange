class RedeemersController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  # before_action :authenticate_user!

  def index
    # returns transactions in a 20 mile radius to Redeemers index page
    @current_profile = Profile.where(user_id: current_user.id)[0]
    public_group_id = Group.where(name: "public_group")[0].id;
    puts "@@@@@@@@@@@@@@@@@??????????!!!!!!!!!!!!!!!! #{@current_profile.inspect} !!!!!!!!!!????????@@@@@"
    # Device.where("parent_id =" +  @parent.id.to_s + " OR status = 0")
    trans = Transaction.where("group_id =" + @current_profile.group_id.to_s + " OR group_id =" + public_group_id.to_s)
            .near([@current_profile.latitude, @current_profile.longitude], @current_profile.radius)
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
      update_flash_notice_and_send_update_notifications(trans)
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

    def update_flash_notice_and_send_update_notifications(trans)
      if trans.selected and !trans.completed
        if trans.trans_type == "redeemable"
          flash.notice = "Redeemable transaction has been selected!"
        else
          flash.notice = "Good Samaritan transaction has been selected!"
        end
        # TransactionUpdateEmailTextWorker.perform_async(trans.id)
      end
      if trans.selected and trans.completed
        if trans.trans_type == "redeemable"
          flash.notice = "Redeemable transaction has been completed!"
        else
          flash.notice = "Good Samaritan transaction has been completed!"
        end
        # TransactionUpdateEmailTextWorker.perform_async(trans.id)
      end
      redirect_to redeemers_path
    end

end