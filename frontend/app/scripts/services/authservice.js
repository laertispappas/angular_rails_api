'use strict';

/**
 * @ngdoc service
 * @name frontendApp.authService
 * @description
 * # authService
 * Service in the frontendApp.
 */
angular.module('frontendApp')
  .service('authService', function ($window, $log) {
    var self = this;

    self.parseJwt = function(token){
      var base64Url = token.split('.')[1];
      var base64 = base64Url.replace('-', '+').replace('_', '/');

      return JSON.parse($window.atob(base64));
    }

    self.saveToken = function(token){
      $log.debug("Saving token: " + token);
      $window.localStorage['jwtToken'] = token;
    }

    self.getToken = function() {
      $log.debug("Getting token: " + $window.localStorage['jwtToken'])
      return $window.localStorage['jwtToken'];
    }

    self.isAuthenticated = function() {
      var token = self.getToken();
      $log.debug("IsAuthenticated token: " + token);
      if(token) {
        var params = self.parseJwt(token);
        return Math.round(new Date().getTime() / 1000) <= params.exp;
      } else {
        return false;
      }
    }

    self.logout = function() {
      $log.debug("Removing token: " + $window.localStorage['jwtToken']);
      $window.localStorage.removeItem('jwtToken');
    }

    self.isAuthorized = function(authorizedRoles) {
      if (!angular.isArray(authorizedRoles)) {
        authorizedRoles = [authorizedRoles];
      }

      return (authService.isAuthenticated() &&
            authorizedRoles.indexOf(Session.userRole) !== -1);
    }
  });
