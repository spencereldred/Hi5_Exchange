var app = angular.module("Hi5Exchange", ["ngResource", 'redeemer-headings']);

// app.factory('Redeemer', function($resource){
//   $resource('/redeemers/:id.json', {id: "@id"}, {update: {method: "PUT"}});
// });

app.controller('RedeemerController', function($scope, $resource){
  Redeemer = $resource('/redeemers/:id.json', {id: "@id"}, {update: {method: "PUT"}});
  $scope.transactions = Redeemer.query();
  console.log("made it to the new RedeemerController written in js.");
  console.log($scope.transactions);
  center_latitude = $('#center_latitude').val();
  center_longitude = $('#center_longitude').val();
  current_user_id = parseInt($('#current_user_id').val());
  console.log(typeof(current_user_id));
  console.log("lat: " + center_latitude + ", long: " + center_longitude + " id: " + current_user_id);
  $scope.addresses = [];

  $scope.update_trans = function(data){
    console.log("inside update_trans, here is the data: " + data)
    transactions = data;
    for(var i = 0; i < transactions.length; i++) {
      if(transaction.selected == true && transaction.completed == false && transaction.selected_redeemer_id == current_user_id){
        console.log(transaction.redeemer_user_id + " " + current_user_id)
        address = transaction["address"] + ", " + transaction["city"] + " " + transaction["state"]+ " " + transaction["zipcode"];
        $scope.add_marker(address, 'add');
      }
    }
  };

  // $scope.transactions = Redeemer.query($scope.update_trans);

  $scope.update_trans($scope.transactions)




  // // Redeemer.query($scope.update_trans);

  $scope.add_marker = function(address, action) {
    console.log("Inside new add_marker.");
    codeAddress(address, action);
    if(action == 'add'){
      $scope.addresses.push(address);
    }
    $scope.addresses = _.uniq($scope.addresses);
  };

  $scope.select = function(transaction){
    // transaction = $scope.transaction;
    transaction.selected_date = Date.now();
    transaction.selected = true;
    transaction.selected_redeemer_id = current_user_id;
    console.log(transaction.selected_redeemer_id);
    address = transaction["address"] + ", " + transaction["city"] + " " + transaction["state"] + " " + transaction["zipcode"];
    console.log("The address is: " + address);
    trans =   "Plastic: "     + transaction["plastic"] +
              ", Glass: "     + transaction["glass"] +
              ", Cans: "      + transaction["cans"] +
              ", Mixed Hi5: " + transaction["other"];
    console.log(trans);
    $scope.add_marker(address, 'add');
    transaction.$update();
  };

  $scope.completed = function(transaction){
    // transaction = $scope.transaction;
    transaction.completed_date = Date.now();
    transaction.completed = true;
    console.log(transaction);
    address = transaction["address"] + ", " + transaction["city"] + " " + transaction["state"] + " " + transaction["zipcode"];
    $scope.addresses = _.reject($scope.addresses, function(addr){
      address == addr;
    });
    $scope.add_marker(address, 'delete');
    for(var i = 0; i < $scope.addresses.length; i++) {
      $scope.add_marker(address);
    }
    transaction.$update();
  };

});