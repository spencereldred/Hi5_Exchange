(function(){
  var app = angular.module('headings', []);

  app.directive('availableRedeemable', function(){
    return {
      restrict: 'E',
      template: '<h1>Available Redeemable Transactions</h1>'
    }
  });

  app.directive('availableSamaritan', function(){
    return {
      restrict: 'E',
      template: '<h1>Available Good Samaritan Transactions</h1>'
    }
  });

  app.directive('selectedRedeemable', function(){
    return {
      restrict: 'E',
      template: '<h1>Selected Redeemable Transactions</h1>'
    }
  });

  app.directive('selectedSamaritan', function(){
    return {
      restrict: 'E',
      template: '<h1>Selected Good Samaritan Transactions</h1>'
    }
  });

  app.directive('enterRedeemable', function(){
    return {
      restrict: 'E',
      template: '<h1>Enter Redeemable Transaction:</h1>'
    }
  });

  app.directive('enterSamaritan', function(){
    return {
      restrict: 'E',
      template: '<h1>Enter Good Samaritan Transaction:</h1>'
    }
  });
  app.directive('openRedeemable', function(){
    return {
      restrict: 'E',
      template: '<h1>Open Redeemable Transactions</h1>'
    }
  });
  app.directive('openSamaritan', function(){
    return {
      restrict: 'E',
      template: '<h1>Open Good Samaritan Transactions</h1>'
    }
  });

})();