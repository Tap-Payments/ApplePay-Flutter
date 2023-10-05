import 'enums/enums.dart';

class ApplePayConfig {
  TapCurrencyCode transactionCurrency;
  List<AllowedCardNetworks> allowedCardNetworks;
  String applePayMerchantId;
  double amount;
  List<MerchantCapabilities> merchantCapabilities;

  ApplePayConfig({
    required this.transactionCurrency,
    required this.allowedCardNetworks,
    required this.applePayMerchantId,
    required this.amount,
    required this.merchantCapabilities,
  });
}
