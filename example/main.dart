import 'package:lightning_rest/lightning_rest.dart';

Future main() async {
  var clnConfig = CoreLightningConfig(
      host: '181.154.222.81',
      port: 3010,
      rune: 'tfcfVjSgflv-EsA1LfwIKusmz_neL17uMX2sxRi2yW09MA==');
  var clnService = LightningNodeService(NodeType.CLN, clnConfig);
  var res = await clnService.newAddress();
  print(res);
}
