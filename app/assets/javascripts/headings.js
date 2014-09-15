(function(){
  var app = angular.module('headings', []);

  app.directive('availableredeemable', function(){
    return {
      restrict: 'E',
      template: '<h1>Available Redeemable Transactions</h1>'
    }
  });

  app.directive('availablesamaritan', function(){
    return {
      restrict: 'E',
      template: '<h1>Available Good Samaritan Transactions</h1>'
    }
  });

  app.directive('selectedredeemable', function(){
    return {
      restrict: 'E',
      template: '<h1>Selected Redeemable Transactions</h1>'
    }
  });

  app.directive('selectedsamaritan', function(){
    return {
      restrict: 'E',
      template: '<h1>Selected Good Samaritan Transactions</h1>'
    }
  });

  app.directive('enterredeemable', function(){
    return {
      restrict: 'E',
      template: '<h1>Enter Redeemable Transaction:</h1>'
    }
  });

  app.directive('entersamaritan', function(){
    return {
      restrict: 'E',
      template: '<h1>Enter Good Samaritan Transaction:</h1>'
    }
  });
  app.directive('openredeemable', function(){
    return {
      restrict: 'E',
      template: '<h1>Open Redeemable Transactions</h1>'
    }
  });
  app.directive('opensamaritan', function(){
    return {
      restrict: 'E',
      template: '<h1>Open Good Samaritan Transactions</h1>'
    }
  });

})();