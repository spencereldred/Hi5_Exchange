app = angular.module("Hi5Exchange", ["ngResource"])

#########################################################
################# TransactionController #################
########should have named it RecyclerController##########

################# Directives #################
app.directive "new", () ->
  restrict: "E",
  template: "Enter Redeemable Transaction:"

app.directive "sam", () ->
  restrict: "E",
  template: "Enter Good Samaritan Transaction:"

app.directive "outred", () ->
  restrict: "E",
  template: "Open Redeemable Transactions"

app.directive "outsam", () ->
  restrict: "E",
  template: "Open Good Samaritan Transactions"

################# Routes #####################
app.factory "Transaction", ($resource) ->
  $resource("/transactions/:id.json", {id: "@id"}, {update: {method: "PUT"}})

@TransactionController = ($scope, Transaction) ->
  console.log "Made it to the TransactionController"

  $scope.update_trans = (data)=>
    $scope.transactions = data
    return

  ## Grab the transactions from the rails database asychronously
  Transaction.query $scope.update_trans

  $scope.bag_options = [
    {name: "none", value: "0" },
    {name: "1 bag", value: "1" },
    {name: "2 bags", value: "2" },
    {name: "3 bags", value: "3" },
    {name: "4 bags", value: "4" },
    {name: "5 bags", value: "5" },
    {name: "6 bags", value: "6" },
    {name: "7 bags", value: "7" }
  ]

  $scope.hi = () ->
    console.log "hii"

  # Recycler creates a redeemable transaction and saves it to the database.
  # The transaction is added to the view.
  $scope.new_recycle_item = ->
    console.log "add recycle item button was clicked"
    if @transaction
      transaction = @transaction
      #################
      # grab values from the user model stashed in the DOM
      transaction.address = $('#user_address').val()
      transaction.city = $('#user_city').val()
      transaction.state = $('#user_state').val()
      transaction.zipcode = $('#user_zipcode').val()
      transaction.recycler_user_id = $('#user_id').val()
      transaction.completion_date = "nil"
      transaction.selected = false
      transaction.completed = false
      transaction.trans_type = "redeemable"
      # no samaritan items in a redeemable transaction
      transaction.cardboard = false
      transaction.non_hi5_plastic = false
      transaction.non_hi5_glass = false
      transaction.non_hi5_cans = false
      transaction.magazines = false
      transaction.newspaper = false
      transaction.paper = false

      ## Update the scoped 'transactions' array for the view
      $scope.transactions.push(transaction)
      console.log transaction

      ## Update the database via the rails controller 'create' method
      Transaction.save(transaction)
      return

  # Recycler creates a Good Samaritan transaction and saves it to the database.
  $scope.new_samaritan_item  =  ->
    event.preventDefault()
    console.log "add samaritan item button was clicked"
    if @transaction
      transaction = @transaction
      #################
      # grab values from the user model stashed in the DOM
      transaction.address = $('#user_address').val()
      transaction.city = $('#user_city').val()
      transaction.state = $('#user_state').val()
      transaction.zipcode = $('#user_zipcode').val()
      transaction.recycler_user_id = $('#user_id').val()
      transaction.completion_date = "nil"
      transaction.selected = false
      transaction.completed = false
      transaction.trans_type = "samaritan"
      # no redeemable items in a samaritan transaction
      transaction.other = 0
      transaction.plastic = 0
      transaction.glass = 0
      transaction.cans = 0

      ## Update the scoped 'transactions' array for the view
      $scope.transactions.push(transaction)
      console.log transaction

      ## Update the database via the rails controller 'create' method
      Transaction.save(transaction)
      # return


  # Recycler marks the transaction as completed.
  # Sets { completed: true, completion_date: new Date() }
  # The transaction is removed from the view by a filter.
  # The view only shows transactions where "filter: { completed: false}"."
  $scope.remove = ->
    console.log "remove action clicked"
    transaction = @transaction
    transaction.delete

######################################################
################# RedeemerController #################
######################################################

################# Directives #################
app.directive "redeemable", () ->
  restrict: "E",
  template: "<h1>Available Redeemable Transactions</h1>"

app.directive "samaritan", () ->
  restrict: "E",
  template: "<h1>Available Good Samaritan Transactions</h1>"

app.directive "redeemableselected", () ->
  restrict: "E",
  template: "<h1>Selected Redeemable Transactions</h1>"

app.directive "samaritanselected", () ->
  restrict: "E",
  template: "<h1>Selected Good Samaritan Transactions</h1>"

################# Routes #####################
app.factory "Redeemer", ($resource) ->
  $resource("/redeemers/:id.json", {id: "@id"}, {update: {method: "PUT"}})

@RedeemerController = ($scope, Redeemer) ->
  console.log "Made it to the RedeemerController"
  center_latitude = $('#center_latitude').val()
  center_longitude = $('#center_longitude').val()
  current_user_id = parseInt $('#current_user_id').val()
  console.log "lat: " + center_latitude + ", long: " + center_longitude + " id: " + current_user_id
  addresses = []

  # The callback function loads the page with transactions from the database.
  # Adds markers on the map for the transactions already selected.
  $scope.update_trans = (data)=>
    $scope.transactions = data
    for transaction in $scope.transactions when transaction.selected == true && transaction.completed == false && transaction.redeemer_user_id == current_user_id
      console.log transaction.redeemer_user_id, current_user_id
      address = transaction["address"] + ", " + transaction["city"] + " " + transaction["state"]
      console.log address
      $scope.add_marker(address)
  # Asynchronously calls the RedeemerController to retrieve the
  # transactions within a 20 mile radius of the Redeemer.
  Redeemer.query $scope.update_trans

  # Adds a marker to the map.
  # Calls the google map routine with the address passed in.
  $scope.add_marker = (address,action) ->
    codeAddress(address,action)
    addresses.push(address) unless action == "delete"
    addresses = _.uniq(addresses)


  # The Redeemer selects an item to recycle.
  # Sets { selected: true, selection_date: new Date() }
  # Places a pin on the map at the location for recycle pickup by
  # calling add_marker(address) with the address of the Recycler.
  # TODO - Fire off an email to the "recycler" that the item has been selected.
  $scope.select = ->
    transaction = @transaction
    transaction.selected_date = new Date()
    transaction.selected = true
    transaction.selected_redeemer_id = current_user_id
    console.log transaction.selected_redeemer_id
    address = transaction["address"] + ", " + transaction["city"] + " " + transaction["state"]
    console.log address
    # $scope.add_marker(address)
    transaction.$update()

  # The Redeemer unselects an item to recycle
  # sets { selected: false, selection_date: "nil" }
  # TODO - Fire off a email to the "recycler" that the job has been unselected?
  $scope.unselect = ->
    transaction = @transaction
    transaction.selection_date = $('#unselection_date').val()
    transaction.redeemer_user_id = "nil"
    console.log transaction.redeemer_user_id
    address = transaction["address"] + ", " + transaction["city"] + " " + transaction["state"]
    addresses = _.reject(addresses, (addr) ->
      address == addr
    )
    $scope.add_marker(address,"delete")
    for address in addresses
      $scope.add_marker(address)
    transaction.$update()


  # Redeemer indicates that the job is complete by checking the "completed"
  # checkbox. Removes the map marker for this item from the map.
  # TODO - fire off an action mail to recycler indicating "redeemer" says the job is done
  $scope.completed = ->
    transaction = @transaction
    transaction.completion_date = new Date()
    transaction.completed = true
    address = transaction["address"] + ", " + transaction["city"] + " " + transaction["state"]
    addresses = _.reject(addresses, (addr) ->
      address == addr
    )
    $scope.add_marker(address,"delete")
    for address in addresses
      $scope.add_marker(address)
    transaction.$update()



