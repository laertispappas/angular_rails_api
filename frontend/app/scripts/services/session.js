'use strict';

/**
 * @ngdoc service
 * @name frontendApp.Session
 * @description
 * # Session
 * Service in the frontendApp.
 */
angular.module('frontendApp')
  .service('Session', function () {
    this.create = function(userEmail) {
      this.id = userEmail;
      this.email = userEmail;
    };

    this.destroy = function(){
      this.id = null;
      this.email = null;
    }
  });
