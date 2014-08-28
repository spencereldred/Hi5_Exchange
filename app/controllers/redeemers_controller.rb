class RedeemersController < ApplicationController

  def index
    @redeemables = Recyclable.where(trans_type: "redeemable", selected: false, completed: false).near([current_user.profile.latitude, current_user.profile.longitude], current_user.profile.radius)
    @samaritans = Recyclable.where(trans_type: "samaritan", selected: false, completed: false).near([current_user.profile.latitude, current_user.profile.longitude], current_user.profile.radius)
    # for testing in rails console:
    # @redeemables = Recyclable.where(trans_type: "redeemable", selected: false, completed: false).near([user.profile.latitude, user.profile.longitude], user.profile.radius)
    sql = "select users.email, profiles.address, profiles.city,
    user_recyclables.id as user_recyclables_id, recyclables.plastic,
    recyclables.glass, recyclables.cans, recyclables.other from users
    join profiles on users.id = profiles.user_id
    join user_recyclables on users.id = user_recyclables.redeemer_id
    join recyclables on user_recyclables.recyclable_id = recyclables.id
    where recyclables.selected = true
    and recyclables.completed = false
    and users.id = #{current_user.id}
    and recyclables.trans_type = 'redeemable';"
    @redeemables_selected = ActiveRecord::Base.connection.execute(sql)
    sql = "select users.email, profiles.address, profiles.city,
    user_recyclables.id as user_recyclables_id, recyclables.cardboard,
    recyclables.newspaper, recyclables.magazines, recyclables.paper,
    recyclables.non_hi5_plastic, recyclables.non_hi5_glass,
    recyclables.non_hi5_cans from users
    join profiles on users.id = profiles.user_id
    join user_recyclables on users.id = user_recyclables.redeemer_id
    join recyclables on user_recyclables.recyclable_id = recyclables.id
    where recyclables.selected = true
    and recyclables.completed = false
    and users.id = #{current_user.id}
    and recyclables.trans_type = 'samaritan';"
    @samaritans_selected = ActiveRecord::Base.connection.execute(sql)
    # binding.pry
  end




end