class RecyclablesController < ApplicationController

  def index
    user = User.find(logged_in_user_id)
    @recyclables = user.recyclables.where(trans_type: 'redeemable', completed: false)
    @samaritans = user.recyclables.where(trans_type: 'samaritan', completed: false)
    @selections = ['none', '1 bag', '2 bags', '3 bags', '4 bags', '5 bags']
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
        :completed, :completed_date)
    end

    def recyclable_params
      params.require(:recyclable).permit(
        :plastic, :glass, :cans, :other, :trans_type,
        :cardboard, :newspaper, :magazines, :paper,
        :non_hi5_plastic, :non_hi5_glass, :non_hi5_cans,
        :user_id)
    end

    def create_flash_notice(user)
      if user.recyclables.last.trans_type == 'redeemable'
        flash.notice = "Redeemable transaction has been created!"
      elsif user.recyclables.last.trans_type == 'samaritan'
        flash.notice = "Samaritan transaction has been created!"
      end
    end

    def update_flash_notice(recyclable)
      if recyclable.selected and !recyclable.completed
        if recyclable.trans_type == "redeemable"
          flash.notice = "Redeemable transaction has been selected!"
        else
          flash.notice = "Good Samaritan transaction has been selected!"
        end
        Hi5Mailer.selected(recyclable.users[0]).deliver
        redirect_to redeemers_path
      end
      if recyclable.selected and recyclable.completed
        if recyclable.trans_type == "redeemable"
          flash.notice = "Redeemable transaction has been completed!"
        else
          flash.notice = "Good Samaritan transaction has been completed!"
        end
        Hi5Mailer.completed(recyclable.users[0]).deliver
        redirect_to recyclables_path
      end
    end

end