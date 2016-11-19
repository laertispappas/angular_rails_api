'use strict';

/**
 * @ngdoc service
 * @name frontendApp.AUTHEVENTS
 * @description
 * # AUTHEVENTS
 * Constant in the frontendApp.
 */
angular.module('frontendApp')
  .constant('AUTH_EVENTS', {
    loginSuccess: 'auth-login-success',
    loginFailed: 'auth-login-failed',
    logoutSuccess: 'auth-logout-success',
    sessionTimeout: 'auth-session-timeout',
    notAuthenticated: 'auth-not-authenticated',
    notAuthorized: 'auth-not-authorized'
  })
