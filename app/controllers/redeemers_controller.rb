class RedeemersController < ApplicationController

  def index
    # TODO: add geocoding to selection
    redeemable_sql = "select users.id, users.email, user_recyclables.id,
    recyclables.plastic, recyclables.glass, recyclables.cans,
    recyclables.other, recyclables.non_hi5_plastic, recyclables.non_hi5_glass,
    recyclables.non_hi5_cans, recyclables.magazines, recyclables.newspaper,
    recyclables.cardboard, recyclables.paper from users
    join user_recyclables on users.id = user_recyclables.redeemer_id
    join recyclables on user_recyclables.id = recyclables.id
    where users.id = 1 and recyclables.trans_type = 'redeemable';"
    @redeemables = ActiveRecord::Base.connection.execute(redeemable_sql)
    samaritan_sql = "select users.id, users.email, user_recyclables.id,
    recyclables.plastic, recyclables.glass, recyclables.cans,
    recyclables.other, recyclables.non_hi5_plastic, recyclables.non_hi5_glass,
    recyclables.non_hi5_cans, recyclables.magazines, recyclables.newspaper,
    recyclables.cardboard, recyclables.paper from users
    join user_recyclables on users.id = user_recyclables.redeemer_id
    join recyclables on user_recyclables.id = recyclables.id
    where users.id = 1 and recyclables.trans_type = 'samaritan';"
    @samaritans = ActiveRecord::Base.connection.execute(samaritan_sql)
    # binding.pry
  end


end