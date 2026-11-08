class Endpoints {
  static const String baseUrl = 'https://accessories-eshop.runasp.net';
  static const String productDetails = '/api/products';
  static const String reviews = '/api/reviews';
  static const String orders = '/api/orders';
  static const String checkout = '/api/orders/checkout';
  static String orderHistory(dynamic orderId) => '/api/orders/history/$orderId';
}
