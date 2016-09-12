'use strict';

/**
 * @ngdoc service
 * @name frontendApp.movie
 * @description
 * # movie
 * Factory in the frontendApp.
 */
angular.module('frontendApp')
  .factory('Movie', function ($http) {
    var self = this;

    self.index = function(){
      return $http.get('api/v1/movies')
    }

    return {
      index: self.index
    };
  });
