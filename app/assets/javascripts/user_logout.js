// ################# Session #####################

app.factory('Session', ['$resource', function($resource){
  return $resource('/sessions/:id.json', {id: '@id'}, {update: {method: 'PUT'}});
}]);

app.controller('LogoutController', ['$scope', '$rootScope', '$resource', 'Session',
  function($scope, $rootScope, $resource, Session){

    $scope.logout = function () {
      var session = this.session;
      session.$remove();
    };

  }
]);