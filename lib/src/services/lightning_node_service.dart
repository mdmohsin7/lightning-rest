import 'package:dio/dio.dart';
import 'package:lightning_rest/src/clients/base_client.dart';
import 'package:lightning_rest/src/clients/base_connection_config.dart';
import 'package:lightning_rest/src/clients/core_lightning/core_lightning_client.dart';
import 'package:lightning_rest/src/clients/lnd/lnd_client.dart';
import 'package:lightning_rest/src/factories/lightning_node_adapter_factory.dart';
import 'package:lightning_rest/src/utils/enums.dart';

class LightningNodeService {
  final NodeType nodeType;
  final ConnectionConfig connectionConfig;
  late LightningNodeClient _node;
  late Dio _dioClient;

  LightningNodeService(this.nodeType, this.connectionConfig) {
    _dioClient = Dio();
    _node = LightningNodeAdapterFactory.createNodeAdapter(
        nodeType, connectionConfig, _dioClient);
  }

  /// getInfo returns general information concerning the lightning node
  /// This method is supported by both Core Lightning Node and LND Node
  /// - For Core Lightning Node, the method is getinfo
  /// - For LND Node, the method is getinfo
  ///
  /// Returns a [Future] containing a [Map] of type [String, dynamic]
  Future<Map<String, dynamic>> getInfo() async {
    return await _node.getInfo();
  }

  /// newAddress generates a new address for the lightning node
  /// This method is supported by both Core Lightning Node and LND Node
  /// - For Core Lightning Node, the method is newaddr \
  ///   Parameters:
  ///    * [addressType] - address type specifies the type of address wanted.
  ///       - Default: bech32
  ///       - Supported: bech32, p2pkh, all (The special value all generates all known address types for the same underlying key.)
  /// - For LND Node, the method is newaddress \
  ///   Parameters:
  ///    * [type] - address type specifies the type of address wanted.
  ///       - Default: bech32
  ///       - Supported: p2wkh, np2wkh, p2tr
  ///    * [account] - The name of the account to generate a new address for. If empty, the default wallet account is used.
  ///
  /// Returns a [Future] containing a [Map] of type [String, dynamic]
  Future<Map<String, dynamic>> newAddress(
      {String? addressType, String? type, String? account}) async {
    if (_node is CoreLightningClient) {
      return await (_node as CoreLightningClient)
          .newAddress(addressType: addressType);
    } else if (_node is LNDClient) {
      return await (_node as LNDClient)
          .newAddress(type: type, account: account);
    } else {
      throw Exception(
          'This operation is not supported for the current node type.');
    }
  }

  /// listRunes returns a list of runes for the lightning node
  /// This method is supported by Core Lightning Node
  /// - For Core Lightning Node, the method is listrunes
  ///
  /// Returns a [Future] containing a [Map] of type [String, dynamic]
  /// Throws an exception if the method is called on an node type other than Core Lightning
  Future<Map<String, dynamic>> listRunes({String? rune}) async {
    if (_node is! CoreLightningClient) {
      throw Exception(
          'This operation is not supported for the current node type.');
    }
    return await (_node as CoreLightningClient).listRunes();
  }

  Future<Map<String, dynamic>> createInvoice(
      {required String amount,
      required String label,
      required String description}) async {
    if (_node is CoreLightningClient) {
      return await (_node as CoreLightningClient).createInvoice(
        amount: amount,
        label: label,
        description: description,
      );
    } else {
      throw Exception(
        'This operation is not supported for the current node type.',
      );
    }
  }

  Future<Map<String, dynamic>> addInvoice({
    required String valueMsat,
    String? memo,
    String? rPreImage,
    String? rHash,
  }) async {
    if (_node is LNDClient) {
      return await (_node as LNDClient).addInvoice(
        valueMsat: valueMsat,
        memo: memo,
        rPreImage: rPreImage,
        rHash: rHash,
      );
    } else {
      throw Exception(
        'This operation is not supported for the current node type.',
      );
    }
  }

  Future<Map<String, dynamic>> listChannels(
      {String? shortChannelId,
      String? source,
      String? destination,
      bool? activeOnly,
      bool? inactiveOnly,
      bool? publicOnly,
      bool? privateOnly}) async {
    if (_node is CoreLightningClient) {
      return await (_node as CoreLightningClient).listChannels(
        shortChannelId: shortChannelId,
        source: source,
        destination: destination,
      );
    } else if (_node is LNDClient) {
      return await (_node as LNDClient).listChannels(
        activeOnly: activeOnly,
        inactiveOnly: inactiveOnly,
        publicOnly: publicOnly,
        privateOnly: privateOnly,
      );
    } else {
      throw Exception(
        'This operation is not supported for the current node type.',
      );
    }
  }

  // Cleanup method to close the HTTP client when the service is disposed
  void dispose() {
    _dioClient.close();
  }
}
