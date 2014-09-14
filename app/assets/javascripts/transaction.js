var app = angular.module("Hi5Exchange", ["ngResource", 'redeemer-headings']);

app.factory('Redeemer', ['$resource', function($resource){
  return $resource('/redeemers/:id.json', {id: "@id"}, {update: {method: "PUT"}});
}]);

app.controller('RedeemerController', ['$scope','$resource', 'Redeemer', function($scope, $resource, Redeemer){
  center_latitude = $('#center_latitude').val();
  center_longitude = $('#center_longitude').val();
  current_user_id = parseInt($('#current_user_id').val());
  $scope.addresses = [];
  $scope.data = [];

  $scope.update_trans = function(data){
    transactions = data;
    for(var i = 0; i < transactions.length; i++) {
      if(transactions[i].selected == true && transactions[i].completed == false && transactions[i].selected_redeemer_id == current_user_id){
        console.log(transactions[i].redeemer_user_id + " " + current_user_id)
        address = transactions[i]["address"] + ", " + transactions[i]["city"] + " " + transactions[i]["state"]+ " " + transactions[i]["zipcode"];
        $scope.add_marker(address, 'add');
      }
    }
  };

  $scope.transactions = Redeemer.query($scope.update_trans);

  $scope.add_marker = function(address, action) {
    codeAddress(address, action);
    if(action == 'add'){
      $scope.addresses.push(address);
    }
    $scope.addresses = _.uniq($scope.addresses);
  };

  $scope.select = function(transaction){
    transaction.selected_date = Date.now();
    transaction.selected = true;
    transaction.selected_redeemer_id = current_user_id;
    address = transaction["address"] + ", " + transaction["city"] + " " + transaction["state"] + " " + transaction["zipcode"];
    $scope.add_marker(address, 'add');
    transaction.$update();
  };

  $scope.completed = function(transaction){
    transaction.completed_date = Date.now();
    transaction.completed = true;
    console.log("the addresses array is: " + $scope.addresses)
    address = transaction["address"] + ", " + transaction["city"] + " " + transaction["state"] + " " + transaction["zipcode"];
    console.log("the address to be removed is: " + address)
    $scope.addresses = _.reject($scope.addresses, function(addr){
      return address === addr;
    });
    console.log("the addresses array less address is now: " + $scope.addresses)
    $scope.add_marker(address, 'delete');
    for(var i = 0; i < $scope.addresses.length; i++) {
      $scope.add_marker($scope.addresses[i],"add");
    }
    transaction.$update();
  };

}]);