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

enum MerchantCapabilities {
  ThreeDS,
  Credit,
  Debit,
  EMV,
}

enum SdkMode {
  production,
  sandbox,
}

enum ApplePayButtonType {
  appleLogoOnly, // = 'plain',
  buyWithApplePay, // = 'buy',
  setupApplePay, // = 'setup',
  payWithApplePay, // = 'pay',
  donateWithApplePay, // = 'donate',
  checkoutWithApplePay, // = 'checkout',
  bookWithApplePay, // = 'book',
  subscribeWithApplePay, // = 'subscribe',
}

enum ApplePayButtonStyle {
  black,
  white,
  whiteoutline,
  auto,
}
