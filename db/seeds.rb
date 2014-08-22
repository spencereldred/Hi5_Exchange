#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

red1_co = User.create(
  email: 'red1_co@example.com', password: 'password',
  password_confirmation: 'password')

red1_co_profile = Profile.create(
  user_id: red1_co.id, first_name: 'Joe-redeemer', last_name: 'Colorado',
  address: '460 Humboldt St.', city: 'Denver', state: 'CO',
  zipcode: '80209', phone: '8082803758',function: 'redeemer')

rec1_co = User.create(
  email: 'rec1_co@example.com', password: 'password',
  password_confirmation: 'password')

rec1_co_profile = Profile.create(
  user_id: rec1_co.id, first_name: 'Joe-recycler', last_name: 'Colorado',
  address: '1062 Delaware St.', city: 'Denver', state: 'CO',
  zipcode: '80204', phone: '8082803758',function: 'recycler')

red2_sf = User.create(
  email: 'red2_sf@example.com', password: 'password',
  password_confirmation: 'password')

red2_sf_profile = Profile.create(
  user_id: red2_sf.id, first_name: 'Joe-redeemer', last_name: 'SanFrancisco',
  address: '414 Brannan St.', city: 'San Francisco', state: 'CA',
  zipcode: '94107', phone: '8082803758',function: 'redeemer')

rec2_sf = User.create(
  email: 'rec2_sf@example.com', password: 'password',
  password_confirmation: 'password')

rec2_sf_profile = Profile.create(
  user_id: rec2_sf.id, first_name: 'Joe-recycler', last_name: 'SanFrancisco',
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
  {user_id: rec1_co.id , recyclable_id: co_recyclable1.id, redeemer_id: red1_co.id },
  {user_id: rec1_co.id , recyclable_id: co_recyclable2.id, redeemer_id: red1_co.id },
  {user_id: rec2_sf.id , recyclable_id: sf_recyclable3.id, redeemer_id: red2_sf.id },
  {user_id: rec2_sf.id , recyclable_id: sf_recyclable4.id, redeemer_id: red2_sf.id }
  ])


