'use strict';

/**
 * @ngdoc function
 * @name frontendApp.controller:MoviesctrlCtrl
 * @description
 * # MoviesctrlCtrl
 * Controller of the frontendApp
 */
angular.module('frontendApp')
  .controller('MoviesCtrl', function ($scope, Movie, $log) {
    Movie.index().then(function(response){
      $scope.movies = response.data
    }, function(err){
      $log.warning("Error loading movies");
      $log.warning(err);
    });
  });
