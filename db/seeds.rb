#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

red1 = User.create(
  email: 'red1@example.com', password: 'password',
  password_confirmation: 'password')

red1_profile = Profile.create(
  user_id: red1.id, first_name: 'Joe-redeemer', last_name: 'Colorado',
  address: '460 Humboldt St.', city: 'Denver', state: 'CO',
  zipcode: '80209', phone: '8082803758',function: 'redeemer')

rec1 = User.create(
  email: 'rec1@example.com', password: 'password',
  password_confirmation: 'password')

rec1_profile = Profile.create(
  user_id: rec1.id, first_name: 'Joe-recycler', last_name: 'Colorado',
  address: '1062 Delaware St.', city: 'Denver', state: 'CO',
  zipcode: '80204', phone: '8082803758',function: 'recycler')

red2 = User.create(
  email: 'red2@example.com', password: 'password',
  password_confirmation: 'password')

red2_profile = Profile.create(
  user_id: red2.id, first_name: 'Joe-redeemer', last_name: 'SanFrancisco',
  address: '414 Brannan St.', city: 'San Francisco', state: 'CA',
  zipcode: '94107', phone: '8082803758',function: 'redeemer')

rec2 = User.create(
  email: 'rec2@example.com', password: 'password',
  password_confirmation: 'password')

rec2_profile = Profile.create(
  user_id: rec2.id, first_name: 'Joe-recycler', last_name: 'SanFrancisco',
  address: '268 St. Charles Ave.', city: 'San Francisco', state: 'CA',
  zipcode: '94132', phone: '8082803758',function: 'recycler')

co_recyclable1 = Recyclable.create(trans_type: "redeemable", plastic: 1,
  cans: 1, glass: 1, other: 1)

co_recyclable2 = Recyclable.create(trans_type: "samaritan", cardboard: true,
  non_hi5_plastic: true, non_hi5_cans: true, non_hi5_glass: true,
  magazines: true, paper: true, newspaper: true)

sf_recyclable3 = Recyclable.create(trans_type: "redeemable", plastic: 2,
  cans: 2, glass: 2, other: 2)

sf_recyclable4 = Recyclable.create(trans_type: "samaritan", cardboard: true,
  non_hi5_plastic: true, non_hi5_cans: false, non_hi5_glass: true,
  magazines: false, paper: true, newspaper: false)

user_recyclable = UserRecyclable.create([
  {user_id: rec1.id , recyclable_id: co_recyclable1.id, redeemer_id: red1.id },
  {user_id: rec1.id , recyclable_id: co_recyclable2.id, redeemer_id: red1.id },
  {user_id: rec2.id , recyclable_id: sf_recyclable3.id, redeemer_id: red2.id },
  {user_id: rec2.id , recyclable_id: sf_recyclable4.id, redeemer_id: red2.id }
  ])


