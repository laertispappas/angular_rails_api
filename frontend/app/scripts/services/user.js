'use strict';

/**
 * @ngdoc service
 * @name frontendApp.user
 * @description
 * # user
 * Service in the frontendApp.
 */
angular.module('frontendApp')
  .factory('userService', function () {
    var username = '';

    return {
      username: username
    };
  });
