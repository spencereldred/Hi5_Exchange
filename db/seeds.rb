#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  @sf_group1 = Group.create(name: 'sf_group', promo_code: 'sf', description: 'first sf group', url: 'sf.com')

  @co_group1 = Group.create(name: 'co_group', promo_code: 'co', description: 'first co group', url: 'co.com')

  @admin_group1 = Group.create(name: 'admin_group', promo_code: 'admin', description: 'first admin group', url: 'admin.com')

  @admin1 = User.create(
    email: 'admin1@example.com', password: 'password',
    password_confirmation: 'password')

  @admin1_profile = Profile.create(
    user_id: @admin1.id, first_name: 'Spencer', last_name: 'Eldred',
    address: '460 Humboldt St.', city: 'Denver', state: 'CO',
    zipcode: '80209', phone: '8082803758', email: 'user@fakemail.com',
    function: 'super_admin', group_id: @admin_group1.id)


  @red1 = User.create(
    email: 'red1@example.com', password: 'password',
    password_confirmation: 'password')

  @red1_profile = Profile.create(
    user_id: @red1.id, first_name: 'Joe-redeemer', last_name: 'Colorado',
    address: '460 Humboldt St.', city: 'Denver', state: 'CO',
    zipcode: '80209', phone: '8082803758', email: 'user@fakemail.com',
    function: 'redeemer', group_id: @co_group1.id)

  sleep(1)

  @rec1 = User.create(
    email: 'rec1@example.com', password: 'password',
    password_confirmation: 'password')

  @rec1_profile = Profile.create(
    user_id: @rec1.id, first_name: 'Joe-recycler', last_name: 'Colorado',
    address: '1062 Delaware St.', city: 'Denver', state: 'CO',
    zipcode: '80204', phone: '8082803758', email: 'user@fakemail.com',
    function: 'recycler', group_id: @co_group1.id)

  sleep(1)

  @red2 = User.create(
    email: 'red2@example.com', password: 'password',
    password_confirmation: 'password')

  @red2_profile = Profile.create(
    user_id: @red2.id, first_name: 'Joe-redeemer', last_name: 'SanFrancisco',
    address: '414 Brannan St.', city: 'San Francisco', state: 'CA',
    zipcode: '94107', phone: '8082803758', email: 'user@fakemail.com',
    function: 'redeemer', group_id: @sf_group1.id)

  sleep(1)

  @rec2 = User.create(
    email: 'rec2@example.com', password: 'password',
    password_confirmation: 'password')

  @rec2_profile = Profile.create(
    user_id: @rec2.id, first_name: 'Joe-recycler', last_name: 'SanFrancisco',
    address: '268 St. Charles Ave.', city: 'San Francisco', state: 'CA',
    zipcode: '94132', phone: '8082803758', email: 'user@fakemail.com',
    function: 'recycler', group_id: @sf_group1.id)

  sleep(1)

  @co_recyclable1 = Transaction.create(trans_type: "redeemable",
    plastic: 1, cans: 1, glass: 1, other: 1,
    address: '1062 Delaware St.', city: 'Denver', state: 'CO',
    zipcode: '80204', recycler_user_id: @rec1.id, group_id: @co_group1.id)

  sleep(1)

  @co_recyclable2 = Transaction.create(trans_type: "redeemable",
    plastic: 2, cans: 2, glass: 2, other: 2,
    address: '1062 Delaware St.', city: 'Denver', state: 'CO',
    zipcode: '80204', redeemer_user_id: @red1.id,
    selected: true, selection_date: (Time.now + (60*60*24)),
    recycler_user_id: @rec1.id, group_id: @co_group1.id)

  sleep(1)

  @co_recyclable5 = Transaction.create(trans_type: "redeemable",
    plastic: 3, cans: 3, glass: 3, other: 3,
    address: '1062 Delaware St.', city: 'Denver', state: 'CO',
    zipcode: '80204', redeemer_user_id: @red1.id,
    selected: true, selection_date: (Time.now + (60*60*24)),
    completed: true, completion_date: (Time.now + (2*60*60*24)),
    recycler_user_id: @rec1.id, group_id: @co_group1.id)


  sleep(1)

  @sf_recyclable1 = Transaction.create(trans_type: "redeemable",
    plastic: 3, cans: 3, glass: 3, other: 3,
    address: '268 St. Charles Ave.', city: 'San Francisco', state: 'CA',
    zipcode: '94132', recycler_user_id: @rec2.id, group_id: @sf_group1.id)

  sleep(1)

  @sf_recyclable2 = Transaction.create(trans_type: "redeemable",
    plastic: 4, cans: 4, glass: 4, other: 4,
    address: '268 St. Charles Ave.', city: 'San Francisco', state: 'CA',
    zipcode: '94132', redeemer_user_id: @red2.id,
    selected: true, selection_date: (Time.now + (60*60*24)),
    recycler_user_id: @rec2.id, group_id: @sf_group1.id)


  sleep(1)

  @sf_recyclable5 = Transaction.create(trans_type: "redeemable",
    plastic: 4, cans: 4, glass: 4, other: 4,
    address: '268 St. Charles Ave.', city: 'San Francisco', state: 'CA',
    zipcode: '94132', redeemer_user_id: @red1.id,
    selected: true, selection_date: (Time.now + (60*60*24)),
    completed: true, completion_date: (Time.now + (2*60*60*24)),
    recycler_user_id: @rec2.id, group_id: @sf_group1.id)







