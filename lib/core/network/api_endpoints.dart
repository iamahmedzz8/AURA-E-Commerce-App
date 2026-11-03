/// API Endpoints for AURA Maison E-Commerce App
/// Generated from OpenAPI specification: eshop.API | v1
class ApiEndpoints {
  ApiEndpoints._();

  /// Base Server URL
  static const String baseUrl = 'https://accessories-eshop.runasp.net';

  /// Connect & Receive Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // ── Authentication Endpoints ─────────────────────────────────
  static const String login = '/api/auth/login';
  static const String register = '/api/auth/register';
  static const String refreshToken = '/api/auth/refresh-token';
  static const String verifyEmail = '/api/auth/verify-email';
  static const String forgotPassword = '/api/auth/forgot-password';
  static const String validateOtp = '/api/auth/validate-otp';
  static const String resendOtp = '/api/auth/resend-otp';
  static const String resetPassword = '/api/auth/reset-password';
  static const String changePassword = '/api/auth/change-password';
  static const String logout = '/api/auth/logout';
  static const String me = '/api/auth/me';
  static const String adminUsers = '/api/auth/admin';

  // Google OAuth
  static const String googleLogin = '/api/auth/google/login';
  static const String googleCallback = '/api/auth/google/callback';
  static const String googleMobile = '/api/auth/google/mobile';

  // ── Products Endpoints ───────────────────────────────────────
  static const String products = '/api/products';
  static String productById(dynamic id) => '/api/products/$id';

  // ── Categories Endpoints ─────────────────────────────────────
  static const String categories = '/api/categories';
  static String categoryById(dynamic id) => '/api/categories/$id';

  // ── Cart Endpoints ───────────────────────────────────────────
  static const String cart = '/api/cart';
  static const String cartItems = '/api/cart/items';
  static String cartItemById(dynamic id) => '/api/cart/items/$id';
  static const String cartDecrement = '/api/cart/items/decrement';
  static const String applyCoupon = '/api/cart/apply-coupon';

  // ── Orders Endpoints ─────────────────────────────────────────
  static const String orders = '/api/orders';
  static const String checkout = '/api/orders/checkout';
  static String orderHistory(dynamic orderId) => '/api/orders/history/$orderId';
  static const String adminOrders = '/api/orders/admin';
  static const String adminOrderStatus = '/api/orders/admin/order-status';

  // ── Addresses Endpoints ──────────────────────────────────────
  static const String addresses = '/api/addresses';
  static String addressById(dynamic id) => '/api/addresses/$id';

  // ── Reviews Endpoints ────────────────────────────────────────
  static String reviewsByProductId(dynamic productId) =>
      '/api/reviews/$productId';

  // ── Coupons & Offers Endpoints ───────────────────────────────
  static const String coupons = '/api/coupons';
  static const String offers = '/api/offers';

  // ── Notifications Endpoints ──────────────────────────────────
  static const String notifications = '/api/notifications';
  static String readNotification(dynamic notificationId) =>
      '/api/notifications/$notificationId/read';
  static const String bulkReadNotifications = '/api/notifications/bulk-read';
  static const String allNotifications = '/api/notifications/all';

  // ── Files & Media Endpoints ──────────────────────────────────
  static const String fileImage = '/api/files/image';

  // ── Webhooks Endpoints ───────────────────────────────────────
  static const String paymobWebhook = '/api/webhooks/paymob';
}
