class RecyclablesController < ApplicationController

  def index
    user = User.find(logged_in_user_id)
    @recyclables = user.recyclables.where(trans_type: 'redeemable', completed: false)
    @samaritans = user.recyclables.where(trans_type: 'samaritan', completed: false)
    @selections = ['none', '1 bag', '2 bags', '3 bags', '4 bags', '5 bags']
    # binding.pry
  end

  def new
    @recyclable = Recyclable.new
  end

  def create
    user = User.find(logged_in_user_id)
    user.recyclables.create(recyclable_params)
    if user.recyclables.last.trans_type == 'redeemable'
      flash.notice = "Redeemable transaction has been created!"
    elsif user.recyclables.last.trans_type == 'samaritan'
      flash.notice = "Samaritan transaction has been created!"
    end
    redirect_to recyclables_path
  end

  def update
    @recyclable = Recyclable.find(params_id)
    @recyclable.update_attributes(recyclable_update)
    if @recyclable.selected == true and @recyclable.completed == false
      if @recyclable.trans_type == "redeemable"
        flash.notice = "Redeemable transaction has been selected!"
      else
        flash.notice = "Good Samaritan transaction has been selected!"
      end
    end
    redirect_to redeemers_path
  end

  private

    def params_id
      params[:id]
    end

    def logged_in_user_id
      current_user.id
    end

    def recyclable_update
      params.require(:recyclable).permit(:selected, :completed)
    end

    def recyclable_params
      params.require(:recyclable).permit(
        :plastic, :glass, :cans, :other, :trans_type,
        :cardboard, :newspaper, :magazines, :paper,
        :non_hi5_plastic, :non_hi5_glass, :non_hi5_cans,
        :user_id)
    end

end