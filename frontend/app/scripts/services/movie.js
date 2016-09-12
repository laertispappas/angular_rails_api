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

    self.rate = function(data) {
      var payload = {
        score: data.score
      };
      return $http.post('api/v1/movies/:id/ratings'.replace(':id', data.id), payload)
    }

    return {
      index: self.index,
      rate: self.rate
    };
  });
