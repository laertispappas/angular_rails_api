'use strict';

/**
 * @ngdoc service
 * @name frontendApp.authInterceptor
 * @description
 * # authInterceptor
 * Factory in the frontendApp.
 */
angular.module('frontendApp')
  .factory('authInterceptor', function (authService) {
    return {
      // automatically attach Authorization header
      request: function(config) {
        var token = authService.getToken();
        if(token) {
          config.headers.Authorization = 'Bearer ' + token;
        }

        return config;
      },

      // If a token was sent back, save it
      response: function(res) {
        //if(res.config.url.indexOf("SOMEINDEXHERE" === 0) && res.data.token) {
        if(res.data.auth_token) {
          authService.saveToken(res.data.auth_token);
        }

        return res;
      },
    }
  });
