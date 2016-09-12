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
  .config(function($httpProvider) {
    $httpProvider.interceptors.push('authInterceptor');
  })
  .config(function ($routeProvider, USER_ROLES) {
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
      .when('/movies', {
        templateUrl: 'views/movies.html',
        controller: 'MoviesCtrl'
      })
      .when('/dashboard', {
        templateUrl: 'views/dashboard.html',
        controller: 'DashboardCtrl',
        data: {
          authorizedRoles: [USER_ROLES.admin, USER_ROLES.member]
        }
      })
      .otherwise({
        redirectTo: '/'
      });
  })
  .run(function($rootScope, AUTH_EVENTS, authService, userService){
    // get user profile on page refresh
    if(authService.isAuthenticated()) {
      userService.getProfile().then(function(response){
        $rootScope.currentUser = response.data;
      }, function(data){
        console.log("Error getting user profile");
      })
    }
    $rootScope.$on('$routeChangeStart', function (event, next, current) {
      if (next.data && next.data.authorizedRoles) {
        var authorizedRoles = next.data.authorizedRoles;
        if (!authService.isAuthorized(authorizedRoles)) {
          event.preventDefault();
          if (authService.isAuthenticated()) {
            $rootScope.$broadcast(AUTH_EVENTS.notAuthorized);
          } else {
            $rootScope.$broadcast(AUTH_EVENTS.notAuthenticated);
          }
        }
      }
    });
  });
