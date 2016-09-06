'use strict';

/**
 * @ngdoc function
 * @name frontendApp.controller:SignupCtrl
 * @description
 * # SignupCtrl
 * Controller of the frontendApp
 */
angular.module('frontendApp')
  .controller('SignupCtrl', function ($scope, $http, $log) {
    $scope.signup = function() {
      var payload = {
        email: $scope.email,
        password: $scope.password,
        password_confirmation: $scope.password_confirmation
      };

      $http.post('/api/registrations', payload).success(function(data) {
        $log.debug(data);
      }).error(function(data) {
        $log.debug(data);
      });
    };
  });
