def create_users_and_transactions
@red1 = User.create(
  email: 'red1@example.com', password: 'password',
  password_confirmation: 'password')

@red1_profile = Profile.create(
  user_id: @red1.id, first_name: 'Joe-redeemer', last_name: 'Colorado',
  address: '460 Humboldt St.', city: 'Denver', state: 'CO',
  zipcode: '80209', phone: '8082803758',function: 'redeemer')

sleep(1)

@rec1 = User.create(
  email: 'rec1@example.com', password: 'password',
  password_confirmation: 'password')

@rec1_profile = Profile.create(
  user_id: @rec1.id, first_name: 'Joe-recycler', last_name: 'Colorado',
  address: '1062 Delaware St.', city: 'Denver', state: 'CO',
  zipcode: '80204', phone: '8082803758',function: 'recycler')

sleep(1)

@red2 = User.create(
  email: 'red2@example.com', password: 'password',
  password_confirmation: 'password')

@red2_profile = Profile.create(
  user_id: @red2.id, first_name: 'Joe-redeemer', last_name: 'SanFrancisco',
  address: '414 Brannan St.', city: 'San Francisco', state: 'CA',
  zipcode: '94107', phone: '8082803758',function: 'redeemer')

sleep(1)

@rec2 = User.create(
  email: 'rec2@example.com', password: 'password',
  password_confirmation: 'password')

@rec2_profile = Profile.create(
  user_id: @rec2.id, first_name: 'Joe-recycler', last_name: 'SanFrancisco',
  address: '268 St. Charles Ave.', city: 'San Francisco', state: 'CA',
  zipcode: '94132', phone: '8082803758',function: 'recycler')

sleep(1)

@co_recyclable1 = Recyclable.create(trans_type: "redeemable", plastic: 1,
  cans: 1, glass: 1, other: 1, user_id: @rec1.id)

sleep(1)

@co_recyclable2 = Recyclable.create(trans_type: "redeemable", plastic: 2,
  cans: 2, glass: 2, other: 2, selected: true, user_id: @rec1.id)

sleep(1)

@co_recyclable3 = Recyclable.create(trans_type: "samaritan", cardboard: true,
  non_hi5_plastic: true, non_hi5_cans: true, non_hi5_glass: true,
  magazines: true, paper: true, newspaper: true, user_id: @rec1.id)

sleep(1)

@co_recyclable4 = Recyclable.create(trans_type: "samaritan", cardboard: true,
  non_hi5_plastic: true, non_hi5_cans: true, non_hi5_glass: true,
  magazines: true, paper: true, newspaper: true, selected: true,
  user_id: @rec1.id)

sleep(1)

@co_recyclable5 = Recyclable.create(trans_type: "redeemable", plastic: 2,
  cans: 2, glass: 2, other: 2, selected: true, completed: true,
  user_id: @rec1.id)

sleep(1)

@co_recyclable6 = Recyclable.create(trans_type: "samaritan", cardboard: true,
  non_hi5_plastic: true, non_hi5_cans: true, non_hi5_glass: true,
  magazines: true, paper: true, newspaper: true, selected: true,
  completed: true, user_id: @rec1.id)

sleep(1)

@sf_recyclable1 = Recyclable.create(trans_type: "redeemable", plastic: 3,
  cans: 3, glass: 3, other: 3, user_id: @rec2.id)

sleep(1)

@sf_recyclable2 = Recyclable.create(trans_type: "redeemable", plastic: 4,
  cans: 4, glass: 4, other: 4, selected: true, user_id: @rec2.id)

sleep(1)

@sf_recyclable3 = Recyclable.create(trans_type: "samaritan", cardboard: true,
  non_hi5_plastic: true, non_hi5_cans: false, non_hi5_glass: true,
  magazines: false, paper: true, newspaper: false, user_id: @rec2.id)

sleep(1)

@sf_recyclable4 = Recyclable.create(trans_type: "samaritan", cardboard: true,
  non_hi5_plastic: true, non_hi5_cans: false, non_hi5_glass: true,
  magazines: false, paper: true, newspaper: false, selected: true,
  user_id: @rec2.id)

sleep(1)

@sf_recyclable5 = Recyclable.create(trans_type: "redeemable", plastic: 4,
  cans: 4, glass: 4, other: 4, selected: true, completed: true,
  user_id: @rec2.id)

sleep(1)

@sf_recyclable6 = Recyclable.create(trans_type: "samaritan", cardboard: true,
  non_hi5_plastic: true, non_hi5_cans: false, non_hi5_glass: true,
  magazines: false, paper: true, newspaper: false, selected: true,
  completed: true, user_id: @rec2.id)

user_recyclable = UserRecyclable.create([
  {user_id: @rec1.id , recyclable_id: @co_recyclable1.id},
  {user_id: @rec1.id , recyclable_id: @co_recyclable2.id, redeemer_id: @red1.id },
  {user_id: @rec1.id , recyclable_id: @co_recyclable3.id },
  {user_id: @rec1.id , recyclable_id: @co_recyclable4.id, redeemer_id: @red1.id },
  {user_id: @rec1.id , recyclable_id: @co_recyclable5.id, redeemer_id: @red1.id },
  {user_id: @rec1.id , recyclable_id: @co_recyclable6.id, redeemer_id: @red1.id },

  {user_id: @rec2.id , recyclable_id: @sf_recyclable1.id},
  {user_id: @rec2.id , recyclable_id: @sf_recyclable2.id, redeemer_id: @red2.id },
  {user_id: @rec2.id , recyclable_id: @sf_recyclable3.id },
  {user_id: @rec2.id , recyclable_id: @sf_recyclable4.id, redeemer_id: @red2.id },
  {user_id: @rec2.id , recyclable_id: @sf_recyclable5.id, redeemer_id: @red2.id },
  {user_id: @rec2.id , recyclable_id: @sf_recyclable6.id, redeemer_id: @red2.id }

  ])



end

def delete_users_and_transactions
    User.destroy_all
    Recyclable.destroy_all
    UserRecyclable.destroy_all
end
