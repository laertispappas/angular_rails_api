'use strict';

/**
 * @ngdoc function
 * @name frontendApp.controller:MenuCtrl
 * @description
 * # MenuCtrl
 * Controller of the frontendApp
 */
angular.module('frontendApp')
  .controller('MenuCtrl', function ($scope, $http, authService, $location, $log) {
    $scope.logout = function() {
      authService.logout()
      $scope.setCurrentUser(null);
    }
  });
