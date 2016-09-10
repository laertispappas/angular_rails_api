'use strict';

/**
 * @ngdoc function
 * @name frontendApp.controller:LoginCtrl
 * @description
 * # LoginCtrl
 * Controller of the frontendApp
 */
angular.module('frontendApp')
  .controller('LoginCtrl', function ($scope, userService, $rootScope, AUTH_EVENTS, $location, $log, $http, alertService) {
    function handleRequest(res) {
      var token = res.data ? res.data.auth_token : null;
      if(token) {
        $rootScope.$broadcast(AUTH_EVENTS.loginSuccess);
        $scope.setCurrentUser(res.data);
        console.log('JWT:', token);
        $location.path('/dashboard');
      }
      //self.message = res.data.message;
    }

     $scope.login = function() {
      userService.login(this.email, this.password).then(handleRequest, function(data){
          $log.debug(data);
          status = data.status;
          $rootScope.$broadcast(AUTH_EVENTS.loginFailed);
          if(status === 400) {
            angular.forEach(data, function(value, key) {
              if(key === 'email' || key === 'password') {
                alertService.add('danger', key + ' : ' + value);
              } else {
                alertService.add('danger', value.message);
              }
            });
          } else if(status === 401) {
            alertService.add('danger', 'Invalid login or password!');
          } else if(status === 500) {
            alertService.add('danger', 'Internal server error!');
          } else {
            alertService.add('danger', data);
          }
        });
      }
  });
