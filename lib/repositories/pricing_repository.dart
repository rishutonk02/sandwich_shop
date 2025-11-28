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
}
