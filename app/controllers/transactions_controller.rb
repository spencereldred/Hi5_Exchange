class TransactionsController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def index
    @current_profile = Profile.where(user_id: current_user.id)[0]
    if @current_profile.function == 'super_admin'
      trans = Transaction.all
    else
      trans = Transaction.where(group_id: @current_profile.group_id)
                         .near([@current_profile.latitude, @current_profile.longitude], @current_profile.radius)
    end
    respond_to do |format|
      format.html
      format.json { render :json => trans }
    end
  end

  def new
    respond_to do |format|
      format.html
      format.json { render :json => Transaction.new }
    end
  end

  def create
    trans = Transaction.create(transaction_create_params)
    respond_to do |format|
      format.html
      format.json { render :json => trans }
    end
    if trans.errors.empty?
      create_flash_notice_and_send_create_notifications(trans)
    end
  end

  private

    def params_id
      params[:id]
    end

    def logged_in_user_id
      current_user.id
    end

    def transaction_create_params
      params.require(:transaction).permit(
                                          :recycler_user_id,
                                          :trans_type, :group_id,
                                          :address, :city,
                                          :state, :zipcode,
                                          :plastic,  :cans,
                                          :glass,    :other
                                          )
    end

    def create_flash_notice_and_send_create_notifications(trans)
      if trans.trans_type == 'redeemable'
        flash.notice = "Redeemable transaction has been created!"
      elsif trans.trans_type == 'samaritan'
        flash.notice = "Samaritan transaction has been created!"
      end
      # JobAvailableEmailTextWorker.perform_async(user.id)
    end



end