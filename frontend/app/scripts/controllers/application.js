'use strict';

/**
 * @ngdoc function
 * @name frontendApp.controller:ApplicationCtrl
 * @description
 * # ApplicationCtrl
 * Controller of the frontendApp
 */
angular.module('frontendApp')
  .controller('ApplicationCtrl', function ($scope, $http, authService) {

    $scope.isAuthed = function() {
      return authService.isAuthenticated()
    }

    $scope.echo = function() {
      $http.get('api/v1/echo').then(function(data){
        console.log(data);
      });
    }
  });
