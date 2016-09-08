'use strict';

/**
 * @ngdoc overview
 * @name frontendApp
 * @description
 * # frontendApp
 *
 * Main module of the application.
 */
angular
  .module('frontendApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch',
    'ui.bootstrap'
  ])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl',
        controllerAs: 'main'
      })
      .when('/about', {
        templateUrl: 'views/about.html',
        controller: 'AboutCtrl',
        controllerAs: 'about'
      })
      .when('/signup', {
        templateUrl: 'views/signup.html',
        controller: 'SignupCtrl'
      })
      .when('/login', {
        templateUrl: 'views/login.html',
        controller: 'LoginCtrl'
      })
      .when('/dashboard', {
        templateUrl: 'views/dashboard.html',
        controller: 'DashboardCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  });


;(function(){
function authInterceptor(API, auth) {
  return {
    // automatically attach Authorization header
    request: function(config) {
      var token = auth.getToken();
      if(token) {
        config.headers.Authorization = 'Bearer ' + token;
      }

      return config;
    },

    // If a token was sent back, save it
    response: function(res) {
      //if(res.config.url.indexOf("SOMEINDEXHERE" === 0) && res.data.token) {
      if(res.data.token) {
        auth.saveToken(res.data.token);
      }

      return res;
    },
  }
}

function authService($window) {
  var self = this;

  // Add JWT methods here
  self.parseJwt = function(token){
    var base64Url = token.split('.')[1];
    var base64 = base64Url.replace('-', '+').replace('_', '/');

    return JSON.parse($window.atob(base64));
  }

  self.saveToken = function(token){
    $window.localStorage['jwtToken'] = token;
  }

  self.getToken = function() {
    return $window.localStorage['jwtToken'];
  }

  self.isAuthenticated = function() {
    var token = self.getToken();
    if(token) {
      var params = self.parseJwt(token);
      return Math.round(new Date().getTime() / 1000) <= params.exp;
    } else {
      return false;
    }
  }

  self.logout = function() {
    $window.localStorage.removeItem('jwtToken');
  }
}

function userService($http, API, auth) {
  var self = this;
  self.getQuote = function() {
    return $http.get('/api/auth/echo')
  }

  // add authentication methods here
  self.register = function(email, password, passwordConfirmation) {
    return $http.post('api/registratoins', {
      email: email,
      password: password,
      password_confirmation: passwordConfirmation
    })
  }

  self.login = function(email, password) {
    return $http.post('api/sessions', {
      email: email,
      password: password
    })
  }

}

// We won't touch anything in here
function MainCtrl(user, auth) {
  var self = this;

  function handleRequest(res) {
    var token = res.data ? res.data.token : null;
    if(token) { console.log('JWT:', token); }
    self.message = res.data.message;
  }

  self.login = function() {
    user.login(self.email, self.password)
      .then(handleRequest, handleRequest)
  }
  self.register = function() {
    user.register(self.email, self.password)
      .then(handleRequest, handleRequest)
  }
  self.getQuote = function() {
    user.getQuote()
      .then(handleRequest, handleRequest)
  }
  self.logout = function() {
    auth.logout && auth.logout()
  }
  self.isAuthed = function() {
    return auth.isAuthed ? auth.isAuthed() : false
  }
}

angular.module('app', [])
.factory('authInterceptor', authInterceptor)
.service('user', userService)
.service('auth', authService)
.constant('API', 'http://test-routes.herokuapp.com')
.config(function($httpProvider) {
  $httpProvider.interceptors.push('authInterceptor');
})
.controller('Main', MainCtrl)
})();

