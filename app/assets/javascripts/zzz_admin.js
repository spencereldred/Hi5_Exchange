// ######################################################
// ################# AdminController #################
// ######################################################

// ################# Directives #################
app.directive("openJobs", [function() {
  return {
    restrict: "E",
    template: "<h1>Open Redeemable Jobs</h1>"
  }
}]);
app.directive("selectedJobs", [function() {
  return {
    restrict: "E",
    template: "<h1>Selected Redeemable Jobs</h1>"
  }
}]);
app.directive("completedJobs", [function() {
  return {
    restrict: "E",
    template: "<h1>Completed Redeemable Jobs</h1>"
  }
}]);

// ################# User #####################

app.factory('User', ['$resource', function($resource){
  return $resource('/profiles/:id.json', {id: '@id'}, {update: {method: 'PUT'}});
}]);

app.controller('UserController', ['$scope', '$rootScope', '$resource', 'User',
  function($scope, $rootScope, $resource, User){

    $rootScope.current_user_function = $('#current_user_function').val();
    $rootScope.current_user_group_id = $('#current_user_group_id').val();
    var update_users = function (data) {
      $scope.users = data;
    };
    User.query(update_users);

    if ($rootScope.current_user_function === "group_admin" ||
        $rootScope.current_user_function === "super_admin") {
      $rootScope.isAdmin = true;
    }

  }
]);

// ################# Transaction #####################

app.factory('Transaction', ['$resource', function($resource){
  return $resource('/transactions/:id.json', {id: '@id'}, {update: {method: 'PUT'}});
}]);

app.controller('TransactionController', ['$scope', '$rootScope', '$resource', 'Transaction',
  function($scope, $rootScope, $resource, Transaction){

    var update_trans = function (data) {
      $scope.transactions = data;
      var i, date,
          length = $scope.transactions.length;
      for (i = 0; i < length; i++) {
        trans = $scope.transactions[i];
        if (trans.created_at) {
          trans.created_at = $rootScope.formatDate(trans.created_at);
        }
        if (trans.selection_date) {
          trans.selection_date = $rootScope.formatDate(trans.selection_date);
        }
        if (trans.completion_date) {
          trans.completion_date = $rootScope.formatDate(trans.completion_date);
        }
      }
    };
    Transaction.query(update_trans);

  }
]);

// ################# Group #####################

app.factory('Group', ['$resource', function($resource){
  return $resource('/groups/:id.json', {id: '@id'}, {update: {method: 'PUT'}});
}]);

app.controller('GroupController', ['$scope', '$rootScope', '$resource', 'Group',
  function($scope, $rootScope, $resource, Group){

    if ($rootScope.current_user_function === "admin" ||
        $rootScope.current_user_function === "super_admin") {
      $rootScope.isAdmin = true;
    }

    $rootScope.showFlashMessage = function (type, message) {
      $rootScope.flash = {
        "type": type,
        "message": message
      };
      $rootScope.showFlash = true;
    }

    $rootScope.formatDate = function (date) {
      var dateArray = date.split("T")[0].split("-"),
          timeArray = date.split("T")[1].split(":"),
          dateString = dateArray[1] + "/" + dateArray[2] + "/" + dateArray[0].slice(2,4);
      dateString += " " + timeArray[0]%12 + ":" + timeArray[1];
      dateString += timeArray[0]/12 > 1 ? " PM" : " AM";
      return dateString;
    };

    var update_groups = function (data) {
      var i, group, length = data.length;
      $scope.groups = [];

      if ($rootScope.isAdmin === "admin") {
        for( i = 0; i < length; i++) {
          group = data[i];
          if (group.id === parseInt($rootScope.current_user_group_id)) {
            $scope.groups.push(group);
          }
        }
      } else { // "super_admin"
        $scope.groups = data;
      }

    };

    Group.query(update_groups);

  }
]);
