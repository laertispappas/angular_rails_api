'use strict';

/**
 * @ngdoc function
 * @name frontendApp.controller:ApplicationCtrl
 * @description
 * # ApplicationCtrl
 * Controller of the frontendApp
 */
angular.module('frontendApp')
  .controller('ApplicationCtrl', function () {
    self.isAuthed = function() {
      return auth.isAuthed ? auth.isAuthed() : false
    }
  });
