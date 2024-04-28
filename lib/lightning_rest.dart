library lightning_rest;

export 'src/clients/base_client.dart';
export 'src/clients/base_connection_config.dart';
export 'src/clients/core_lightning/core_lightning_client.dart';
export 'src/clients/core_lightning/core_lightning_connection_config.dart';
export 'src/factories/lightning_node_adapter_factory.dart';
export 'src/services/lightning_node_service.dart';
export 'src/utils/enums.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}
