'use strict';

/**
 * @ngdoc function
 * @name frontendApp.controller:ApplicationCtrl
 * @description
 * # ApplicationCtrl
 * Controller of the frontendApp
 */
angular.module('frontendApp')
  .controller('ApplicationCtrl', function ($scope, $rootScope,$http, authService, USER_ROLES) {

    $scope.userRoles = USER_ROLES;
    $scope.isAuthorized = authService.isAuthorized;
    $scope.isLoginPage = false;

    $scope.isAuthed = function() {
      return authService.isAuthenticated();
    }

    // Holds the user response payload email ...
    $scope.setCurrentUser = function (user) {
      console.log(user);
      $scope.currentUser = user;
    };

    $scope.echo = function() {
      $http.get('api/v1/echo').then(function(data){
        console.log(data);
      });
    }
  });
