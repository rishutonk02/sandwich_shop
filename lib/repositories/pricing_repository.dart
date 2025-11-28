class PricingRepository {
  static const double sixInchPrice = 7.0;
  static const double footlongPrice = 11.0;
  double calculateTotalPrice({
    required int quantity,
    required bool isFootlong,
  }) {
    final double unitPrice = isFootlong ? footlongPrice : sixInchPrice;
    return quantity * unitPrice;
  }

  /// Instance convenience method with positional args for callers that expect
  /// a `calculatePrice(int, bool)` signature.
  double calculatePrice(int quantity, bool isFootlong) =>
      calculateTotalPrice(quantity: quantity, isFootlong: isFootlong);

  /// Static convenience method used by other models or helpers.
  static double staticCalculatePrice(int quantity, bool isFootlong) {
    final double unitPrice = isFootlong ? footlongPrice : sixInchPrice;
    return quantity * unitPrice;
  }
}
