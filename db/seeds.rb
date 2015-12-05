  ####  Super Admin  ####

  @super_admin_group = Group.create(
    name: 'super_admin_group', promo_code: 'super_admin',
    description: 'first admin group', url: 'admin.com'
    )

  @super_admin = User.create(
    email: 'super_admin@example.com', password: 'password',
    password_confirmation: 'password')

  @super_admin_profile = Profile.create(
    user_id: @super_admin.id, first_name: 'Spencer', last_name: 'Eldred',
    address: '2741 Leolani Place', city: 'Makawao', state: 'HI',
    zipcode: '96768', phone: '8082803758', email: 'eldredspencer@gmail.com',
    function: 'super_admin', group_id: @super_admin_group.id)

  sleep(1)

  ####  HI  ####

  @maui_group = Group.create(
    name: 'maui_group', promo_code: 'maui',
    description: 'first maui group', url: 'maui.com'
    )

  @maui_group_admin = User.create(
    email: 'maui_group_admin@example.com', password: 'password',
    password_confirmation: 'password')

  @maui_admin_profile = Profile.create(
    user_id: @maui_group_admin.id, first_name: 'Spencer', last_name: 'Eldred',
    address: '2741 Leolani Place', city: 'Makawao', state: 'HI',
    zipcode: '96768', phone: '8082803758', email: 'eldredspencer@gmail.com',
    function: 'group_admin', group_id: @maui_group.id)

  sleep(1)

  @red3 = User.create(
    email: 'red3@example.com', password: 'password',
    password_confirmation: 'password')

  @red3_profile = Profile.create(
    user_id: @red3.id, first_name: 'Joe-redeemer', last_name: 'Maui',
    address: "183 Pukulani St.", city: "Makawao", state: "HI",
    zipcode: "96768", phone: '8082803758', email: 'eldredspencer@gmail.com',
    function: 'redeemer', group_id: @maui_group.id)

  sleep(1)

  @rec3 = User.create(
    email: 'rec3@example.com', password: 'password',
    password_confirmation: 'password')

  @rec3_profile = Profile.create(
    user_id: @rec3.id, first_name: 'Joe-recycler', last_name: 'Maui',
    address: "2841 Iolani St.", city: "Makawao", state: "HI",
    zipcode: "96768", phone: '8082803758', email: 'eldredspencer@gmail.com',
    function: 'recycler', group_id: @maui_group.id)

  sleep(1)

  @maui_recyclable1 = Transaction.create(trans_type: "redeemable",
    plastic: 1, cans: 1, glass: 1, other: 1,
    address: "2841 Iolani St.", city: "Makawao", state: "HI",
    zipcode: "96768", recycler_user_id: @rec3.id, group_id: @maui_group.id)

  sleep(1)

  ####  Public  ####

  @public_group = Group.create(
    name: 'public_group', promo_code: 'public',
    description: 'public group', url: 'public.com'
    )

  @public_group_admin = User.create(
    email: 'public_group_admin@example.com', password: 'password',
    password_confirmation: 'password')

  @public_admin_profile = Profile.create(
    user_id: @public_group_admin.id, first_name: 'Spencer', last_name: 'Eldred',
    address: '2741 Leolani Place', city: 'Makawao', state: 'HI',
    zipcode: '96768', phone: '8082803758', email: 'eldredspencer@gmail.com',
    function: 'group_admin', group_id: @public_group.id)

  sleep(1)

  @red4 = User.create(
    email: 'red4@example.com', password: 'password',
    password_confirmation: 'password')

  @red4_profile = Profile.create(
    user_id: @red4.id, first_name: 'Joe-redeemer', last_name: 'Maui',
    address: "296 Liholani St.", city: "Makawao", state: "HI",
    zipcode: "96768", phone: '8082803758', email: 'eldredspencer@gmail.com',
    function: 'redeemer', group_id: @public_group.id)

  sleep(1)

  @rec4 = User.create(
    email: 'rec4@example.com', password: 'password',
    password_confirmation: 'password')

  @rec4_profile = Profile.create(
    user_id: @rec4.id, first_name: 'Joe-recycler', last_name: 'Maui',
    address: "2942 Aina Lani St.", city: "Makawao", state: "HI",
    zipcode: "96768", phone: '8082803758', email: 'eldredspencer@gmail.com',
    function: 'recycler', group_id: @public_group.id)

  sleep(1)

  @public_recyclable1 = Transaction.create(trans_type: "redeemable",
    plastic: 1, cans: 1, glass: 1, other: 1,
    address: "2942 Aina Lani St.", city: "Makawao", state: "HI",
    zipcode: "96768", recycler_user_id: @rec4.id, group_id: @public_group.id)

  sleep(1)

  ####  SF  ####

  @sf_group = Group.create(
    name: 'sf_group', promo_code: 'sf',
    description: 'first sf group', url: 'sf.com'
    )

  @sf_group_admin = User.create(
    email: 'sf_group_admin@example.com', password: 'password',
    password_confirmation: 'password')

  @sf_admin_profile = Profile.create(
    user_id: @sf_group_admin.id, first_name: 'Spencer', last_name: 'Eldred',
    address: '414 Brannan St.', city: 'San Francisco', state: 'CA',
    zipcode: '94107', phone: '8082803758', email: 'user@fakemail.com',
    function: 'group_admin', group_id: @sf_group.id)

  sleep(1)

  @red2 = User.create(
    email: 'red2@example.com', password: 'password',
    password_confirmation: 'password')

  @red2_profile = Profile.create(
    user_id: @red2.id, first_name: 'Joe-redeemer', last_name: 'SanFrancisco',
    address: '414 Brannan St.', city: 'San Francisco', state: 'CA',
    zipcode: '94107', phone: '8082803758', email: 'user@fakemail.com',
    function: 'redeemer', group_id: @sf_group.id)

  sleep(1)

  @rec2 = User.create(
    email: 'rec2@example.com', password: 'password',
    password_confirmation: 'password')

  @rec2_profile = Profile.create(
    user_id: @rec2.id, first_name: 'Joe-recycler', last_name: 'SanFrancisco',
    address: '268 St. Charles Ave.', city: 'San Francisco', state: 'CA',
    zipcode: '94132', phone: '8082803758', email: 'user@fakemail.com',
    function: 'recycler', group_id: @sf_group.id)

  sleep(1)

  @sf_recyclable1 = Transaction.create(trans_type: "redeemable",
    plastic: 3, cans: 3, glass: 3, other: 3,
    address: '268 St. Charles Ave.', city: 'San Francisco', state: 'CA',
    zipcode: '94132', recycler_user_id: @rec2.id, group_id: @sf_group.id)

  sleep(1)

  @sf_recyclable2 = Transaction.create(trans_type: "redeemable",
    plastic: 4, cans: 4, glass: 4, other: 4,
    address: "2200 O'Farrell", city: 'San Francisco', state: 'CA',
    zipcode: '94115', redeemer_user_id: @red2.id,
    selected: true, selection_date: (Time.now + (60*60*24)),
    recycler_user_id: @rec2.id, group_id: @sf_group.id)


  sleep(1)

  @sf_recyclable3 = Transaction.create(trans_type: "redeemable",
    plastic: 4, cans: 4, glass: 4, other: 4,
    address: '2001 37th Ave', city: 'San Francisco', state: 'CA',
    zipcode: '94116', redeemer_user_id: @red2.id,
    selected: true, selection_date: (Time.now + (60*60*24)),
    completed: true, completion_date: (Time.now + (2*60*60*24)),
    recycler_user_id: @rec2.id, group_id: @sf_group.id)

  sleep(1)

  ####  CO  ####

  @co_group = Group.create(
    name: 'co_group', promo_code: 'co',
    description: 'first co group', url: 'co.com'
    )

  @co_group_admin = User.create(
    email: 'co_group_admin@example.com', password: 'password',
    password_confirmation: 'password')

  @co_admin_profile = Profile.create(
    user_id: @co_group_admin.id, first_name: 'Spencer', last_name: 'Eldred',
    address: '460 Humboldt St.', city: 'Denver', state: 'CO',
    zipcode: '80209', phone: '8082803758', email: 'user@fakemail.com',
    function: 'group_admin', group_id: @co_group.id)

  sleep(1)

  @red1 = User.create(
    email: 'red1@example.com', password: 'password',
    password_confirmation: 'password')

  @red1_profile = Profile.create(
    user_id: @red1.id, first_name: 'Joe-redeemer', last_name: 'Colorado',
    address: '460 Humboldt St.', city: 'Denver', state: 'CO',
    zipcode: '80209', phone: '8082803758', email: 'user@fakemail.com',
    function: 'redeemer', group_id: @co_group.id)

  sleep(1)

  @rec1 = User.create(
    email: 'rec1@example.com', password: 'password',
    password_confirmation: 'password')

  @rec1_profile = Profile.create(
    user_id: @rec1.id, first_name: 'Joe-recycler', last_name: 'Colorado',
    address: '1062 Delaware St.', city: 'Denver', state: 'CO',
    zipcode: '80204', phone: '8082803758', email: 'user@fakemail.com',
    function: 'recycler', group_id: @co_group.id)

  sleep(1)

  @co_recyclable1 = Transaction.create(trans_type: "redeemable",
    plastic: 1, cans: 1, glass: 1, other: 1,
    address: '1062 Delaware St.', city: 'Denver', state: 'CO',
    zipcode: '80204', recycler_user_id: @rec1.id, group_id: @co_group.id)

  sleep(1)

  @co_recyclable2 = Transaction.create(trans_type: "redeemable",
    plastic: 2, cans: 2, glass: 2, other: 2,
    address: '258 Pearl St.', city: 'Denver', state: 'CO',
    zipcode: '80203', redeemer_user_id: @red1.id,
    selected: true, selection_date: (Time.now + (60*60*24)),
    recycler_user_id: @rec1.id, group_id: @co_group.id)

  sleep(1)

  @co_recyclable3 = Transaction.create(trans_type: "redeemable",
    plastic: 3, cans: 3, glass: 3, other: 3,
    address: '650 Clarkson St.', city: 'Denver', state: 'CO',
    zipcode: '80203', redeemer_user_id: @red1.id,
    selected: true, selection_date: (Time.now + (60*60*24)),
    completed: true, completion_date: (Time.now + (2*60*60*24)),
    recycler_user_id: @rec1.id, group_id: @co_group.id)










