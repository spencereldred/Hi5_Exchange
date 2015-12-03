class TransactionsController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def index
    @current_profile = Profile.where(user_id: current_user.id)[0]
    respond_to do |format|
      format.html
      format.json { render :json => Transaction.near([@current_profile.latitude, @current_profile.longitude], @current_profile.radius) }
    end
  end

  def new
    respond_to do |format|
      format.html
      format.json { render :json => Transaction.new }
    end
  end

  def create
    binding.pry
    trans = Transaction.create(transaction_create_params)
    respond_to do |format|
      format.html
      format.json { render :json => trans }
    end
    if trans.trans_type == "redeemable"
      # JobAvailableEmailWorker.perform_async(trans.recycler_user_id)
      # JobAvailableTextWorker.perform_async(trans.recycler_user_id)
    end
  end

  def update
    binding.pry
    trans = Transaction.find(params_id)
    trans.update_attributes(transaction_update_params)
    respond_to do |format|
      format.html
      format.json { render :json => trans }
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

    def transaction_update_params
      params.require(:transaction).permit(
                                          :selected,  :selected_date,
                                          :completed, :completed_date,
                                          :selected_redeemer_id
                                          )
    end

    def create_flash_notice(user)
      if user.recyclables.last.trans_type == 'redeemable'
        flash.notice = "Redeemable transaction has been created!"
      elsif user.recyclables.last.trans_type == 'samaritan'
        flash.notice = "Samaritan transaction has been created!"
      end
      # JobAvailableEmailTextWorker.perform_async(user.id)
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