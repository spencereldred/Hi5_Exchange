var app = angular.module("Hi5Exchange", ["ngResource"]);

app.factory('Redeemer', function($resource){
  $resource('/redeemers/:id.json', {id: "@id"}, {update: {method: "PUT"}})
});

app.directive('redeemable', function(){
  return {
    restrict: 'E',
    template: '<h1>Available Redeemable Transactions</h1>'
  }
});

app.directive('samaritan', function(){
  return {
    restrict: 'E',
    template: '<h1>Available Good Samaritan Transactions</h1>'
  }
});

app.directive('redeemableselected', function(){
  return {
    restrict: 'E',
    template: '<h1>Selected Redeemable Transactions</h1>'
  }
});

app.directive('samaritanselected', function(){
  return {
    restrict: 'E',
    template: '<h1>Selected Good Samaritan Transactions</h1>'
  }
});

app.controller('RedeemerController', function($scope){
  console.log("made it to the new RedeemerController written in js.");
  center_latitude = $('#center_latitude').val();
  center_longitude = $('#center_longitude').val();
  current_user_id = parseInt($('#current_user_id').val());
  console.log(typeof(current_user_id));
  console.log ("lat: " + center_latitude + ", long: " + center_longitude + " id: " + current_user_id);
  addresses = [];

  $scope.update_trans = function(data){
    $scope.transactions = data;

  };


});