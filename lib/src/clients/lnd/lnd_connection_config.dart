import 'package:lightning_rest/src/clients/base_connection_config.dart';

class LNDConfig implements ConnectionConfig {
  final String host;
  final int port;
  final String macaroon;
  bool isSelfSigned = false;

  LNDConfig(
    this.isSelfSigned, {
    required this.host,
    required this.port,
    required this.macaroon,
  });
}
