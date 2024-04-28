abstract class LNDSpecific {
  Future<Map<String, dynamic>> newAddress({String? type, String? account});
  Future<Map<String, dynamic>> addInvoice({
    required String valueMsat,
    String? memo,
    String? rPreImage,
    String? rHash,
  });
  Future<Map<String, dynamic>> listChannels(
      {bool? activeOnly,
      bool? inactiveOnly,
      bool? publicOnly,
      bool? privateOnly});
}
