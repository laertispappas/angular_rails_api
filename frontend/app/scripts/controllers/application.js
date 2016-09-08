'use strict';

/**
 * @ngdoc function
 * @name frontendApp.controller:ApplicationCtrl
 * @description
 * # ApplicationCtrl
 * Controller of the frontendApp
 */
angular.module('frontendApp')
  .controller('ApplicationCtrl', function ($scope, $http) {
    self.isAuthed = function() {
      return auth.isAuthed ? auth.isAuthed() : false
    }

    $scope.echo = function() {
      $http.get('api/v1/echo').then(function(data){
        console.log(data);
      });
    }
  });
