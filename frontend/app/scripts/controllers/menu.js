'use strict';

/**
 * @ngdoc function
 * @name frontendApp.controller:MenuCtrl
 * @description
 * # MenuCtrl
 * Controller of the frontendApp
 */
angular.module('frontendApp')
  .controller('MenuCtrl', function ($scope, $http, userService, $location, $log) {

    $log.debug(userService);
    $scope.user = userService;

    $scope.logout = function() {
      $http.get('/app/logout').success(function(data){
        $location.path('/login')
      });
    }
  });
