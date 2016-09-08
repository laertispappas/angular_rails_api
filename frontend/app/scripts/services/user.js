'use strict';

/**
 * @ngdoc service
 * @name frontendApp.user
 * @description
 * # user
 * Service in the frontendApp.
 */
angular.module('frontendApp')
  .factory('userService', function ($http) {
    var self = this;

    self.register = function(payload) {
      return $http.post('api/registrations', {
        email: payload.email,
        password: payload.password,
        password_confirmation: payload.password_confirmation
      })
    }

    self.login = function(email, password) {
      return $http.post('api/sessions', {
        email: email,
        password: password
      })
    }

    return {
      login: self.login,
      register: self.register
    }
  });
