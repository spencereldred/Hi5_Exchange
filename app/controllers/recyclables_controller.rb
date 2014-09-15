class RecyclablesController < ApplicationController

  def index
    user = User.find(logged_in_user_id)
    trans = user.recyclables.where(completed:false)
    respond_to do |format|
      format.html
      format.json { render :json => trans }
    end
  end

  def new
    @recyclable = Recyclable.new
  end

  def create
    user = User.find(logged_in_user_id)
    user.recyclables.create(recyclable_params)
    create_flash_notice(user)
    redirect_to recyclables_path
  end

  def update
    @recyclable = Recyclable.find(params_id)
    @recyclable.update_attributes(recyclable_update)
    update_flash_notice(@recyclable)
  end

  private

    def params_id
      params[:id]
    end

    def logged_in_user_id
      current_user.id
    end

    def recyclable_update
      params.require(:recyclable).permit(
        :selected, :selected_date,
        :completed, :completed_date,
        :selected_redeemer_id)
    end

    def recyclable_params
      params.require(:recyclable).permit(
        :plastic, :glass, :cans, :other, :trans_type,
        :cardboard, :newspaper, :magazines, :paper,
        :non_hi5_plastic, :non_hi5_glass, :non_hi5_cans,
        :user_id, :address, :city, :state, :zipcode)
    end

    def create_flash_notice(user)
      if user.recyclables.last.trans_type == 'redeemable'
        flash.notice = "Redeemable transaction has been created!"
      elsif user.recyclables.last.trans_type == 'samaritan'
        flash.notice = "Samaritan transaction has been created!"
      end
      JobAvailableEmailTextWorker.perform_async(user.id)
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
        TransactionUpdateEmailTextWorker.perform_async(recyclable.id)
      end
      if recyclable.selected and recyclable.completed
        if recyclable.trans_type == "redeemable"
          flash.notice = "Redeemable transaction has been completed!"
        else
          flash.notice = "Good Samaritan transaction has been completed!"
        end
        TransactionUpdateEmailTextWorker.perform_async(recyclable.id)
      end
      redirect_to redeemers_path
    end

end