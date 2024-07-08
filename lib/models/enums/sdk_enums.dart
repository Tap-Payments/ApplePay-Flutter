/// ALL Allowed Card Networks
enum AllowedCardNetworks {
  AMEX,
  CARTESBANCAIRES,
  DISCOVER,
  EFTPOS,
  ELECTRON,
  IDCREDIT,
  INTERAC,
  JCB,
  MAESTRO,
  MASTERCARD,
  PRIVATELABEL,
  QUICPAY,
  SUICA,
  VISA,
  VPAY,
  MADA,
}

/// ALL Merchant Capabilities
enum MerchantCapabilities {
  ThreeDS,
  Credit,
  Debit,
  EMV,
}

/// SDK modes
/// Sandbox for testing environment
/// Production for release environment

enum SdkMode {
  production,
  sandbox,
}

/// Apple pay button pre-defined types
/// We can select any one
enum ApplePayButtonType {
  appleLogoOnly,
  buyWithApplePay,
  setupApplePay,
  payWithApplePay,
  donateWithApplePay,
  checkoutWithApplePay,
  bookWithApplePay,
  subscribeWithApplePay,
}

/// Apple pay button pre-defined styles
/// We can select any one

enum ApplePayButtonStyle {
  black,
  white,
  whiteoutline,
  auto,
}
