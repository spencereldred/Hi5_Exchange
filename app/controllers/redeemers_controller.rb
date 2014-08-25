class RedeemersController < ApplicationController

  def index
    @redeemables = Recyclable.where(trans_type: "redeemable", selected: false, completed: false)
    @samaritans = Recyclable.where(trans_type: "samaritan", selected: false, completed: false)
    # TODO: add geocoding to selection
    sql = "select users.email, profiles.address,
    user_recyclables.id as user_recyclables_id, recyclables.plastic,
    recyclables.cardboard from users join profiles on users.id = profiles.user_id
    join user_recyclables on users.id = user_recyclables.redeemer_id
    join recyclables on user_recyclables.recyclable_id = recyclables.id
    where recyclables.selected = true
    and recyclables.completed = false
    and users.id = 1
    and recyclables.trans_type = 'redeemable';"
    @redeemables_selected = ActiveRecord::Base.connection.execute(sql)
    sql = "select users.email, profiles.address,
    user_recyclables.id as user_recyclables_id, recyclables.plastic,
    recyclables.cardboard from users join profiles on users.id = profiles.user_id
    join user_recyclables on users.id = user_recyclables.redeemer_id
    join recyclables on user_recyclables.recyclable_id = recyclables.id
    where recyclables.selected = true
    and recyclables.completed = false
    and users.id = 1
    and recyclables.trans_type = 'samaritan';"
    @samaritans_selected = ActiveRecord::Base.connection.execute(sql)
    # binding.pry
  end


end