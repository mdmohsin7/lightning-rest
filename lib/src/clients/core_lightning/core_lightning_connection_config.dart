import 'package:lightning_rest/src/clients/base_connection_config.dart';

class CoreLightningConfig implements ConnectionConfig {
  final String host;
  final int port;
  final String rune;

  CoreLightningConfig({
    required this.host,
    required this.port,
    required this.rune,
  });
}
