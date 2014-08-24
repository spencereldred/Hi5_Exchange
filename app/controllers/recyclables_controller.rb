class RecyclablesController < ApplicationController

  def index
    user = User.find(current_user.id)
    @recyclables = user.recyclables.where(trans_type: 'redeemable')
    @samaritans = user.recyclables.where(trans_type: 'samaritan')
    @selections = ['none', '1 bag', '2 bags', '3 bags', '4 bags', '5 bags']
    # binding.pry
  end

  def new
    @recyclable = Recyclable.new
  end

  def create
    user = User.find(current_user.id)
    user.recyclables.create(recyclable_params)
    redirect_to recyclables_path
  end

  private

    def recyclable_params
      params.require(:recyclable).permit(
        :plastic, :glass, :cans, :other, :trans_type,
        :cardboard, :newspaper, :magazines, :paper,
        :non_hi5_plastic, :non_hi5_glass, :non_hi5_cans)
    end

end