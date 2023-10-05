import 'enums/enums.dart';

class ApplePayConfig {
  String sandboxKey;
  String productionKey;
  SdkMode environmentMode;
  TapCurrencyCode transactionCurrency;
  List<AllowedCardNetworks> allowedCardNetworks;
  String merchantId;
  double amount;
  List<MerchantCapabilities> merchantCapabilities;

  ApplePayConfig({
    required this.sandboxKey,
    required this.productionKey,
    required this.transactionCurrency,
    required this.allowedCardNetworks,
    required this.environmentMode,
    required this.merchantId,
    required this.amount,
    required this.merchantCapabilities,
  });
}
