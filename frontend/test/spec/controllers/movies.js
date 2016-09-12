'use strict';

describe('Controller: MoviesctrlCtrl', function () {

  // load the controller's module
  beforeEach(module('frontendApp'));

  var MoviesctrlCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    MoviesctrlCtrl = $controller('MoviesctrlCtrl', {
      $scope: scope
      // place here mocked dependencies
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(MoviesctrlCtrl.awesomeThings.length).toBe(3);
  });
});
