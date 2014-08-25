class RecyclablesController < ApplicationController

  def index
    user = User.find(logged_in_user_id)
    @recyclables = user.recyclables.where(trans_type: 'redeemable')
    @samaritans = user.recyclables.where(trans_type: 'samaritan')
    @selections = ['none', '1 bag', '2 bags', '3 bags', '4 bags', '5 bags']
    # binding.pry
  end

  def new
    @recyclable = Recyclable.new
  end

  def create
    user = User.find(logged_in_user_id)
    user.recyclables.create(recyclable_params)
    redirect_to recyclables_path
  end

  def update
    # binding.pry
    @recyclable = Recyclable.find(params_id)
    @recyclable.selected = true
    @recyclable.save
    # binding.pry
    redirect_to redeemers_path
  end

  private

    def params_id
      params[:id]
    end

    def logged_in_user_id
      current_user.id
    end

    def recyclable_params
      params.require(:recyclable).permit(
        :plastic, :glass, :cans, :other, :trans_type,
        :cardboard, :newspaper, :magazines, :paper,
        :non_hi5_plastic, :non_hi5_glass, :non_hi5_cans)
    end

end