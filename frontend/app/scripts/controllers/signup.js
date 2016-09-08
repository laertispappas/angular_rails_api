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
    function handleRequest(res) {
      $log.debug(res);
      var token = res.data ? res.data.auth_token : null;
      if(token) {
        console.log('JWT:', token);
        $location.path('/dashboard');
      }
    }

    $scope.signup = function() {
      var payload = {
        email: $scope.email,
        password: $scope.password,
        password_confirmation: $scope.password_confirmation
      };
      userService.register(payload).then(handleRequest, function(data){
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
        if(status === 500) {
          alertService.add('danger', 'Internal server error!');
        }
      });
    } // End signup

  });
