'use strict';

/**
 * @ngdoc function
 * @name frontendApp.controller:AlertsCtrl
 * @description
 * # AlertsCtrl
 * Controller of the frontendApp
 */
angular.module('frontendApp')
  .controller('AlertsCtrl', function ($scope, alertService) {
    $scope.alerts = alertService.get();
  });
