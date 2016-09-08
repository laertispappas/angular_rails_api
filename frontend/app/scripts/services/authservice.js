'use strict';

/**
 * @ngdoc service
 * @name frontendApp.authService
 * @description
 * # authService
 * Service in the frontendApp.
 */
angular.module('frontendApp')
  .service('authService', function () {
    var self = this;
    self.parseJwt = function(token){
      var base64Url = token.split('.')[1];
      var base64 = base64Url.replace('-', '+').replace('_', '/');

      return JSON.parse($window.atob(base64));
    }

    self.saveToken = function(token){
      $window.localStorage['jwtToken'] = token;
    }

    self.getToken = function() {
      return $window.localStorage['jwtToken'];
    }

    self.isAuthenticated = function() {
      var token = self.getToken();
      if(token) {
        var params = self.parseJwt(token);
        return Math.round(new Date().getTime() / 1000) <= params.exp;
      } else {
        return false;
      }
    }

    self.logout = function() {
      $window.localStorage.removeItem('jwtToken');
    }
  });
