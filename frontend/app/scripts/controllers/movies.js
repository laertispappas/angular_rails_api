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
    $scope.updateRating = function(movie) {
      var data = {
        id: movie.id,
        score: movie.current_user_score
      }
      Movie.rate(data).then(function(response){
        console.log(response.data);
      }, function(err){
        console.log(err.data);
      });
    };

    Movie.index().then(function(response){
      $scope.movies = response.data
    }, function(err){
      $log.warning("Error loading movies");
      $log.warning(err);
    });
  });
