'use strict';

/**
 * @ngdoc function
 * @name frontendApp.controller:SignupCtrl
 * @description
 * # SignupCtrl
 * Controller of the frontendApp
 */
angular.module('frontendApp')
  .controller('SignupCtrl', function ($scope, $http, $log, alertService, $location, userService) {
    $scope.signup = function() {
      var payload = {
        email: $scope.email,
        password: $scope.password,
        password_confirmation: $scope.password_confirmation
      };

      $http.post('/api/registrations', payload).success(function(data) {
        $log.debug(data);
        if(data.hasOwnProperty('success')) {

          userService.username = $scope.email;
          $location.path('/dashboard');
        }
      }).error(function(data, status) {
        $log.debug(data);
        if(status === 422) {
          angular.forEach(data, function(value, key) {
            if(key === 'email' || key === 'password' || key === 'password_confirmation') {
              alertService.add('danger', key + ' : ' + value);
            } else {
              alertService.add('danger', value.message);
            }
          });
        }
        if(status == 500) {
          alertService.add('danger', 'Internal server error!');
        }
      });
    };
  });
