abstract class CoreLightningSpecific {
  Future<Map<String, dynamic>> newAddress({String? addressType});
  Future<Map<String, dynamic>> listRunes();
  Future<Map<String, dynamic>> createRune();
  Future<Map<String, dynamic>> createInvoice({
    required String amount,
    required String label,
    required String description,
    int? expiry,
    List<String>? fallbacks,
    String? preImage,
  });
  Future<Map<String, dynamic>> listChannels(
      {String? shortChannelId, String? source, String? destination});
}
