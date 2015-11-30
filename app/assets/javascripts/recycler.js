//#########################################################
//################# RecyclerController #################
//#########################################################

// ################# Directives #################
app.directive("new", [function() {
  return {
    restrict: "E",
    template: "Enter Redeemable Transaction:"
  }
}]);
app.directive("sam", [function() {
  return {
    restrict: "E",
    template: "Enter Good Samaritan Transaction:"
  }
}]);
app.directive("outred", [function() {
  return {
    restrict: "E",
    template: "Open Redeemable Transactions"
  }
}]);
app.directive("outsam", [function() {
  return {
    restrict: "E",
    template: "Open Good Samaritan Transactions"
  }
}]);

//################# Routes #####################
app.factory('Transaction', ['$resource', function($resource){
  return $resource('/transactions/:id.json', {id: '@id'}, {update: {method: 'PUT'}});
}]);

app.controller('RecyclerController', ['$scope', '$rootScope', '$resource', 'Transaction',
  function($scope, $rootScope, $resource, Transaction){

    var current_user_function = $('#current_user_function').val();

    if (current_user_function === "admin" ||
        current_user_function === "super_admin") {
      $rootScope.isAdmin = true;
    }

    var message = {
      "post":   "Congratulations, you have posted a recycling job. " +
                "You will be notified via email when a redeemer has selected your job. " +
                "Thank You for helping Hawaii recycle."
    };

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

    $scope.update_trans = function (data) {
      $scope.transactions = data;
      var i, trans, length = $scope.transactions.length;
      for (i = 0; i < length; i++) {
        trans = $scope.transactions[i];
        if (trans.selection_date) {
          trans.selection_date = $rootScope.formatDate(trans.selection_date);
        }
      }

      return;
    };

    // Grab the transactions from the rails database asychronously
    $rootScope.showFlash = false;
    Transaction.query($scope.update_trans);

    $scope.bag_options = [
      {name: "none", value: "0" },
      {name: "1 bag", value: "1" },
      {name: "2 bags", value: "2" },
      {name: "3 bags", value: "3" },
      {name: "4 bags", value: "4" },
      {name: "5 bags", value: "5" },
      {name: "6 bags", value: "6" },
      {name: "7 bags", value: "7" }
    ];

    // # Recycler creates a redeemable transaction and saves it to the database.
    // # The transaction is added to the view.
    $scope.new_recycle_item = function () {
      if (this.transaction) {
        var transaction = this.transaction;
        // grab values from the user model stashed in the DOM
        transaction.address = $('#user_address').val();
        transaction.city = $('#user_city').val();
        transaction.state = $('#user_state').val();
        transaction.zipcode = $('#user_zipcode').val();
        transaction.recycler_user_id = $('#user_id').val();
        transaction.group_id = $('#group_id').val();
        transaction.completion_date = "nil";
        transaction.selected = false;
        transaction.completed = false;
        transaction.trans_type = "redeemable";
        // no samaritan items in a redeemable transaction
        transaction.cardboard = false;
        transaction.non_hi5_plastic = false;
        transaction.non_hi5_glass = false;
        transaction.non_hi5_cans = false;
        transaction.magazines = false;
        transaction.newspaper = false;
        transaction.paper = false;
        // Update the scoped 'transactions' array for the view
        $scope.transactions.push(transaction);
        console.log(transaction);
        // Update the database via the rails controller 'create' method
        Transaction.save(transaction);
        $rootScope.showFlashMessage("success", message.post);
      }
    };

    $scope.new_samaritan_item  = function () {
      event.preventDefault();
      if (this.transaction) {
        var transaction = this.transaction;
        // grab values from the user model stashed in the DOM
        transaction.address = $('#user_address').val();
        transaction.city = $('#user_city').val();
        transaction.state = $('#user_state').val();
        transaction.zipcode = $('#user_zipcode').val();
        transaction.recycler_user_id = $('#user_id').val();
        transaction.completion_date = "nil";
        transaction.selected = false;
        transaction.completed = false;
        transaction.trans_type = "samaritan";
        // no redeemable items in a samaritan transaction
        transaction.other = 0;
        transaction.plastic = 0;
        transaction.glass = 0;
        transaction.cans = 0;
        // Update the scoped 'transactions' array for the view
        $scope.transactions.push(transaction);
        console.log(transaction);
        // ## Update the database via the rails controller 'create' method
        Transaction.save(transaction);
      }
    };

    // # Recycler marks the transaction as completed.
    // # Sets { completed: true, completion_date: new Date() }
    // # The transaction is removed from the view by a filter.
    // # The view only shows transactions where "filter: { completed: false}"."
    $scope.remove = function () {
      var transaction = this.transaction;
      transaction.delete();
    };

  }
]);
