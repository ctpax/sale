var omgneedApp = angular.module('omgneed-app', ['ngResource', 'mm.foundation']).config(
    ['$httpProvider', function($httpProvider) {
    var authToken = angular.element("meta[name=\"csrf-token\"]").attr("content");
    var defaults = $httpProvider.defaults.headers;

    defaults.common["X-CSRF-TOKEN"] = authToken;
    defaults.patch = defaults.patch || {};
    defaults.patch['Content-Type'] = 'application/json';
    defaults.common['Accept'] = 'application/json';
}]);

omgneedApp.factory('User', ['$resource', function($resource) {
  return $resource('/users/:id',
     {id: '@id'},
     {update: { method: 'PATCH'}});
}]);

omgneedApp.factory('Product', ['$resource', function($resource) {
  return $resource('/products/:id',
     {id: '@id'},
     {update: { method: 'PATCH'}});
}]);

omgneedApp.factory('List', ['$resource', function($resource) {
  return $resource('/lists/:id',
     {id: '@id'},
     {update: { method: 'PATCH'}});
}]);

omgneedApp.controller('ListsCtrl', ['$scope', 'User', 'Product', 'List', function($scope, User, Product, List) {

  $scope.users = [];
  $scope.products = [];
  $scope.lists = [];

  $scope.newList = new List();
  $scope.newProduct = new Product();

User.get(function(users) {
      $scope.users = users;
   });

List.query(function(lists) {
      $scope.lists = lists;
   });

Product.query(function(products){
  $scope.products = products;

});

    $scope.saveList = function() {
      $scope.newList.$save(function(list) {
        console.log(list);
        $scope.lists.push(list);
        $scope.newList = new List();
      });
    };

    $scope.deleteList = function (list) {
      list.$delete(function() {
        position = $scope.lists.indexOf(list);
        $scope.lists.splice(position, 1);
      }, function(errors) {
        $scope.errors = errors.data;
      });
    };

    $scope.saveProduct = function (product, list) {
      console.log(list);
      // var price = parseFloat(product.priceLabel);
      // var salePrice = parseFloat(product.salePriceLabel);
      $scope.newProduct = new Product({
        name: product.name,
        price: product.priceLabel,
        sale_price: product.salePriceLabel,
        brand: product.brand.name,
        url: product.clickUrl,
        image_url: product.image.sizes.IPhone.url,
        list_id: list.id
      });
      console.log($scope.newProduct);
      
      $scope.newProduct.$save(function(product) {
        $scope.products.push(product);
        $scope.newProduct = new Product();
      });
    };

}]);
