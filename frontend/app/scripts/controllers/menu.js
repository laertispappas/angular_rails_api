'use strict';

/**
 * @ngdoc function
 * @name frontendApp.controller:MenuCtrl
 * @description
 * # MenuCtrl
 * Controller of the frontendApp
 */
angular.module('frontendApp')
  .controller('MenuCtrl', function ($scope, $http, userService, $location) {
    $scope.user = userService;

    $scope.logout = function() {
      $http.get('/app/logout').success(function(data){
        userService.username = '';
        $location.path('/login')
      });

      // TODO Remove this add Authentication
      $scope.$watch('user.username', function(newVal) {
        if (newVal === '') {
          $scope.isLoggedIn = false;
        } else {
          $scope.userName = newVal;
          $scope.isLoggedIn = true;
        }
      });
    }
  });
