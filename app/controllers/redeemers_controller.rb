class RedeemersController < ApplicationController

  def index
    @redeemables = Recyclable.where(trans_type: "redeemable", selected: false, completed: false).near([current_user.profile.latitude, current_user.profile.longitude], current_user.profile.radius)
    @samaritans = Recyclable.where(trans_type: "samaritan", selected: false, completed: false).near([current_user.profile.latitude, current_user.profile.longitude], current_user.profile.radius)
    # for testing geocoder in rails console:
    # @redeemables = Recyclable.where(trans_type: "redeemable", selected: false, completed: false).near([user.profile.latitude, user.profile.longitude], user.profile.radius)

    sql = "select user_recyclables.recyclable_id, recyclables.selected,
    users.email, profiles.address, profiles.city,
    recyclables.plastic, recyclables.glass, recyclables.cans,
    recyclables.other, recyclables.selected_date, recyclables.id
    from user_recyclables
    join recyclables
    on user_recyclables.recyclable_id = recyclables.id
    join users
    on users.id = user_recyclables.user_id
    join profiles
    on users.id = profiles.user_id
    where user_recyclables.redeemer_id = #{current_user.id}
    and recyclables.selected = 'true'
    and recyclables.completed = 'false'
    and recyclables.trans_type = 'redeemable';"
    @redeemables_selected = ActiveRecord::Base.connection.execute(sql)

    sql = "select user_recyclables.recyclable_id, recyclables.selected,
    users.email, profiles.address, profiles.city,
    recyclables.cardboard,recyclables.newspaper, recyclables.magazines,
    recyclables.paper,recyclables.non_hi5_plastic, recyclables.non_hi5_glass,
    recyclables.non_hi5_cans, recyclables.selected_date, recyclables.id
    from user_recyclables
    join recyclables
    on user_recyclables.recyclable_id = recyclables.id
    join users
    on users.id = user_recyclables.user_id
    join profiles
    on users.id = profiles.user_id
    where user_recyclables.redeemer_id = #{current_user.id}
    and recyclables.selected = 'true'
    and recyclables.completed = 'false'
    and recyclables.trans_type = 'samaritan';"
    @samaritans_selected = ActiveRecord::Base.connection.execute(sql)
    # binding.pry
  end

end