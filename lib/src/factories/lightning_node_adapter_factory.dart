import 'package:dio/dio.dart';
import 'package:lightning_rest/src/clients/base_client.dart';
import 'package:lightning_rest/src/clients/base_connection_config.dart';
import 'package:lightning_rest/src/clients/core_lightning/core_lightning_client.dart';
import 'package:lightning_rest/src/clients/core_lightning/core_lightning_connection_config.dart';
import 'package:lightning_rest/src/clients/lnd/lnd_client.dart';
import 'package:lightning_rest/src/clients/lnd/lnd_connection_config.dart';
import 'package:lightning_rest/src/utils/enums.dart';

// Factory class to create the appropriate adapter based on node type
class LightningNodeAdapterFactory {
  static LightningNodeClient createNodeAdapter(
      NodeType nodeType, ConnectionConfig connectionConfig, Dio httpClient) {
    switch (nodeType) {
      case NodeType.CLN:
        return CoreLightningClient(
            httpClient, connectionConfig as CoreLightningConfig);
      case NodeType.LND:
        return LNDClient(httpClient, connectionConfig as LNDConfig);
      default:
        throw Exception('Invalid node type');
    }
  }
}
