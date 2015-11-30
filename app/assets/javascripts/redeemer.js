// ######################################################
// ################# RedeemerController #################
// ######################################################

// ################# Directives #################
app.directive("redeemable", [function() {
  return {
    restrict: "E",
    template: "<h1>Available Redeemable Transactions</h1>"
  }
}]);
app.directive("samaritan", [function() {
  return {
    restrict: "E",
    template: "<h1>Available Good Samaritan Transactions</h1>"
  }
}]);
app.directive("redeemableselected", [function() {
  return {
    restrict: "E",
    template: "<h1>Redeemable Transactions Selected</h1>"
  }
}]);
app.directive("samaritanselected", [function() {
  return {
    restrict: "E",
    template: "<h1>Good Samaritan Transactions Selected</h1>"
  }
}]);


// ################# Routes #####################
app.factory('Redeemer', ['$resource', function($resource){
  return $resource('/redeemers/:id.json', {id: '@id'}, {update: {method: 'PUT'}});
}]);

app.controller('RedeemerController', ['$scope', '$rootScope', '$resource', 'Redeemer', '$timeout', '$interval',
  function($scope, $rootScope, $resource, Redeemer, $timeout, $interval){

    var center_latitude = $('#center_latitude').val(),
        center_longitude = $('#center_longitude').val(),
        user_radius = $('#current_user_radius').val() * 1609.34,
        current_user_id = parseInt($('#current_user_id').val()),
        current_user_function = $('#current_user_function').val(),
        addresses = [],  markers = [],
        map, geocoder;
        $scope.transactions = [],
        message = {
          "selected":   "Congratulations. You have selected a recycling job.",
          "completed":  "Thank You for helping Hawaii recycle."
        },
        updateInterval = 5 * 60 * 1000; // 5 minutes;

    if (current_user_function === "admin" ||
        current_user_function === "super_admin") {
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

    var updateTransaction = function (transaction) { // start updateTransaction
      console.log("updateTransaction called - transaction: %O", transaction);
      debugger
      transaction.$update().then(function () {
        Redeemer.query($scope.update_trans);
      });
    }; // end updateTransaction

    $scope.update_trans = function (data) { // start update_trans
      var address, i, trans, transaction, length = data.length;
      $scope.transactions = [];
      for (i = 0; i < length; i++) {
        trans = data[i];
        if (!trans.completed) {
          if (trans.created_at) {
            trans.created_at = $rootScope.formatDate(trans.created_at);
          }
          if (trans.selection_date) {
            trans.selection_date = $rootScope.formatDate(trans.selection_date);
          }
          $scope.transactions.push(trans);
        }
      }
      addMarker(address,"delete",transaction);
      console.log("update_trans- $scope.transactions: %O", $scope.transactions);
      for (i = 0, length = $scope.transactions.length; i < length; i++) {
        transaction = $scope.transactions[i];
        if ((transaction.selected && !transaction.completed && transaction.redeemer_user_id === current_user_id) || !transaction.selected) {
          address = transaction["address"] + ", " + transaction["city"] + " " + transaction["state"];
          addMarker(address, "no-op", transaction);
        }
      }
    };// end update_trans

    $rootScope.showFlash = false;
    Redeemer.query($scope.update_trans);

    $interval(function () {
      Redeemer.query($scope.update_trans);
      $rootScope.showFlash = false;
    }, updateInterval); //

    $scope.select = function () { // start select
      var transaction, address;
      transaction = this.transaction;
      transaction.selected = true;
      transaction.selection_date = new Date();
      $rootScope.showFlashMessage("success", message.selected);
      transaction.redeemer_user_id = current_user_id;

      updateTransaction(transaction);
    }; // end select

    $scope.unselect = function () { // start unselect
      var transaction, address,i, length;
      transaction = this.transaction;
      transaction.selection_date = $('#unselection_date').val();
      transaction.redeemer_user_id = "nil";
      transaction.selected = false;
      updateTransaction(transaction);
    };// end unselect

    $scope.completed = function () { // start completed
      console.log("redeemerController - completed()");
      var transaction, address, indexToRemove, i, length;
      transaction = this.transaction;
      transaction.completion_date = new Date();
      transaction.completed = true;
      // $rootScope.showFlashMessage("success", message.completed);
      updateTransaction(transaction);
    }; // end completed

    function drawUserCircleOnMap(map,latlng,user_radius) { // start drawUserCircleOnMap
        var userCircle = new google.maps.Circle({
          strokeColor: '#FF0000',
          strokeOpacity: 0.8,
          strokeWeight: 2,
          fillColor: '#FF0000',
          fillOpacity: 0.015,
          map: map,
          center: latlng,
          radius: user_radius
        });
      };// end drawUserCircleOnMap

    function initialize() {// start initialize
      var latlng = new google.maps.LatLng(center_latitude, center_longitude);
      var mapOptions = {
        zoom: 12,
        center: latlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
      map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
      drawUserCircleOnMap(map, latlng, user_radius);
    };// end initialize
    initialize();

    function addMarker(address,todo,transaction) { // start addMarker
      var i, length, markerLatLng, marker, centerLatLng,
          infoString, infoWindow, selectStatus, iconColor;
      centerLatLng = null;
      if (todo =="delete") { // remove all the markers
        for (i = 0, length = markers.length; i < length; i++) {
          markers[i].setMap(null);
        }
        markers = [];
      } else {
        selectStatus = transaction.selected ? "Selected" : "Available";
        if (transaction.selected) {
          selectStatus = "Selected";
          iconColor = 'http://maps.google.com/mapfiles/ms/icons/green-dot.png';
        } else {
          selectStatus = "Available";
          iconColor = 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png';
        }
        if (!centerLatLng) {
          centerLatLng = new google.maps.LatLng(center_latitude, center_longitude);
          map.setCenter(centerLatLng);
          drawUserCircleOnMap(map, centerLatLng, user_radius);
        }
        markerLatLng = new google.maps.LatLng(transaction.latitude, transaction.longitude);
        marker = new google.maps.Marker({
            map: map,
            icon: iconColor,
            title: selectStatus,
            draggable:true, // animate
            animation: google.maps.Animation.DROP,  // animate
            position: markerLatLng
        });
        infoString = createInfoBoxString(address,transaction);
        infoWindow = new google.maps.InfoWindow({
          content: infoString
        });
        marker.addListener('click', function () {
          infoWindow.open(map,marker);
        });
        if (markers.indexOf(marker) === -1) {
          markers.push(marker);
        }
      }; // end addMarker

      function toggleBounce() { // start toggleBounce
        if (marker.getAnimation() != null) {
          marker.setAnimation(null);
        } else {
          marker.setAnimation(google.maps.Animation.BOUNCE);
        }
      }; // end toggleBounce

      function drawUserCircleOnMap(map,latlng,user_radius) { // start drawUserCircleOnMap
        var userCircle = new google.maps.Circle({
          strokeColor: '#FF0000',
          strokeOpacity: 0.8,
          strokeWeight: 2,
          fillColor: '#FF0000',
          fillOpacity: 0.015,
          map: map,
          center: latlng,
          radius: user_radius
        });
      };// end drawUserCircleOnMap

      function createInfoBoxString (address, transaction) { // start createInfoBoxString
        var infoBoxString = "";
        if (transaction.selected) {
          infoBoxString += "<p>Hi5Exchange Transaction Selected.<p>";
        } else {
          infoBoxString += "<p>Hi5Exchange Transaction Available.<p>";
        }
        infoBoxString += "<p>" + address + "<p>";
        infoBoxString += "<p>Plastic: " + transaction.plastic + ", Cans: " + transaction.cans;
        infoBoxString += ", Glass: " + transaction.glass + ", Mixed Hi5: " + transaction.other + "<p>";
        infoBoxString += "<p>Miles from home: " + (transaction.distance * 1).toFixed(2) + "<p>";
        return infoBoxString;
      }; // end createInfoBoxString

    }

  }
]);
