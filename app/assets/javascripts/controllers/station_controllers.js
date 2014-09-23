var stationControllers = angular.module('stationControllers', ['autocomplete']);

stationControllers.controller('StationCtrl', function($scope, StationRetriever){
  $scope.stations = [];

  $scope.updateStations = function(typed){
    $scope.newstations = StationRetriever.getstations(typed);
    $scope.newstations.then(function(data){
      $scope.stations = data;
    });
  }
});