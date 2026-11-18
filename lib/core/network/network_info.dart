import 'dart:async';
import 'dart:io';
import 'api_endpoints.dart';

/// Network connectivity utility for checking actual internet and server reachability.
class NetworkInfo {
  NetworkInfo._();

  /// Checks if the device has an active internet or server connection.
  /// 
  /// 1. First tests DNS resolution against reliable public hosts (Google / Cloudflare).
  /// 2. If public DNS is unreachable (e.g. local offline Wi-Fi hotspot), tests reachability
  ///    to the configured backend server [ApiEndpoints.appBaseUrl].
  /// 3. Returns `false` if the device has no network connection (Airplane mode, disconnected Wi-Fi/Cellular).
  static Future<bool> isConnected() async {
    // 1. Check WAN Internet access
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 3));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } catch (_) {
      try {
        final fallback = await InternetAddress.lookup('cloudflare.com')
            .timeout(const Duration(seconds: 2));
        if (fallback.isNotEmpty && fallback[0].rawAddress.isNotEmpty) {
          return true;
        }
      } catch (_) {}
    }

    // 2. Fallback: check local backend server if configured
    try {
      final uri = Uri.parse(ApiEndpoints.appBaseUrl);
      if (uri.hasAuthority) {
        final socket = await Socket.connect(
          uri.host,
          uri.hasPort ? uri.port : (uri.scheme == 'https' ? 443 : 80),
          timeout: const Duration(seconds: 2),
        );
        socket.destroy();
        return true;
      }
    } catch (_) {}

    return false;
  }
}
