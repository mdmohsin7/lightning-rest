import 'package:dio/dio.dart';
import 'package:lightning_rest/src/clients/base_client.dart';
import 'package:lightning_rest/src/clients/core_lightning/core_lightning_connection_config.dart';
import 'package:lightning_rest/src/clients/core_lightning/core_lightning_specific.dart';

class CoreLightningClient
    implements LightningNodeClient, CoreLightningSpecific {
  final Dio _dio;
  final CoreLightningConfig config;
  CoreLightningClient(this._dio, this.config);

  @override
  Future<Map<String, dynamic>> getInfo() async {
    var res = await _dio.post(
      'http://${config.host}:${config.port}/v1/getinfo',
      options: Options(
        headers: {
          'Rune': config.rune,
          'content-type': 'application/json',
        },
      ),
    );
    return res.data;
  }

  @override
  Future<Map<String, dynamic>> newAddress({String? addressType}) async {
    var res = await _dio.post(
      'http://${config.host}:${config.port}/v1/newaddr',
      options: Options(
        headers: {
          'Rune': config.rune,
          'content-type': 'application/json',
        },
      ),
    );
    return res.data;
  }

  @override
  Future<Map<String, dynamic>> createInvoice({
    required String amount,
    required String label,
    required String description,
    int? expiry,
    List<String>? fallbacks,
    String? preImage,
  }) async {
    var res = await _dio.post('http://${config.host}:${config.port}/v1/invoice',
        options: Options(
          headers: {
            'Rune': config.rune,
            'content-type': 'application/json',
          },
        ),
        data: {
          'amount_msat': amount,
          'label': label,
          'description': description,
          'expiry': expiry,
          'fallbacks': fallbacks,
          'preimage': preImage,
        });
    return res.data;
  }

  @override
  Future<Map<String, dynamic>> createRune() {
    // TODO: implement createRune
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> listRunes({String? rune}) async {
    var res = await _dio
        .post('http://${config.host}:${config.port}/v1/commando-listrunes',
            options: Options(
              headers: {
                'Rune': config.rune,
                'content-type': 'application/json',
              },
            ),
            data: {
          'rune': rune,
        });
    return res.data;
  }

  @override
  Future<Map<String, dynamic>> listChannels({
    String? shortChannelId,
    String? source,
    String? destination,
  }) async {
    if (shortChannelId != null && source != null) {
      throw Exception(
          'Only one of short_channel_id, source or destination can be supplied or none can be supplied.');
    }
    if (shortChannelId != null && destination != null) {
      throw Exception(
          'Only one of short_channel_id, source or destination can be supplied or none can be supplied.');
    }
    if (source != null && destination != null) {
      throw Exception(
          'Only one of short_channel_id, source or destination can be supplied or none can be supplied.');
    }
    var res = await _dio.post(
      'http://${config.host}:${config.port}/v1/listchannels',
      options: Options(
        headers: {
          'Rune': config.rune,
          'content-type': 'application/json',
        },
      ),
      data: {
        'short_channel_id': shortChannelId,
        'source': source,
        'destination': destination,
      },
    );
    return res.data;
  }
}
