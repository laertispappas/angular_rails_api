'use strict';

/**
 * @ngdoc directive
 * @name frontendApp.directive:loginDialog
 * @description
 * # loginDialog
 */
angular.module('frontendApp')
  .directive('loginDialog', function (AUTH_EVENTS, $uibModal) {
    return {
      restrict: 'A',
      //templateUrl: 'views/directives/login-form.html',
      //template: '<div ng-if="visible" ng-include="\'views/directives/login-form.html\'">',
      link: function (scope) {
        var showLoginDialog = function(){
          scope.isLoginDialogVisible = true;

          scope.modalInstance = $uibModal.open({
            animation: false,
            ariaLabelledBy: 'modal-title',
            ariaDescribedBy: 'modal-body',
            templateUrl: 'views/directives/login-modal.html',
            controller: 'LoginCtrl',
            controllerAs: '$ctrl',
            scope: scope,
            size: null,
          });

        };

        scope.closeLoginDialog = function (){
          if(scope.isLoginDialogVisible == true) {
            scope.modalInstance.close();
          }
        }

        scope.isLoginDialogVisible = false;
        scope.$on(AUTH_EVENTS.notAuthenticated, showLoginDialog);
        scope.$on(AUTH_EVENTS.sessionTimeout, showLoginDialog)
        scope.$on(AUTH_EVENTS.loginSuccess, scope.closeLoginDialog)
      }
    };
  });
