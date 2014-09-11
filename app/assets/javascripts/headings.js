(function(){
  var app = angular.module('redeemer-headings', []);

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

})();