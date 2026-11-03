import 'dart:io';

/// Contract for checking internet connectivity.
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// Standard implementation checking DNS reachability.
class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    } catch (_) {
      return false;
    }
  }
}
