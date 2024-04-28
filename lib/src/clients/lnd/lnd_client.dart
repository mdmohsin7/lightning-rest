import 'package:dio/dio.dart';
import 'package:lightning_rest/src/clients/base_client.dart';
import 'package:lightning_rest/src/clients/lnd/lnd_connection_config.dart';
import 'package:lightning_rest/src/clients/lnd/lnd_specific.dart';

class LNDClient implements LightningNodeClient, LNDSpecific {
  final Dio _dio;
  final LNDConfig config;
  LNDClient(this._dio, this.config);

  @override
  Future<Map<String, dynamic>> getInfo() {
    // TODO: implement getInfo
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> newAddress({String? type, String? account}) {
    // TODO: implement newAddress
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> addInvoice(
      {required String valueMsat,
      String? memo,
      String? rPreImage,
      String? rHash}) {
    // TODO: implement addInvoice
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> listChannels(
      {bool? activeOnly,
      bool? inactiveOnly,
      bool? publicOnly,
      bool? privateOnly}) {
    // TODO: implement listChannels
    throw UnimplementedError();
  }
}
