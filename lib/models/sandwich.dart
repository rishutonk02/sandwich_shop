enum BreadType { white, wheat, wholemeal }

enum SandwichType {
  veggieDelight,
  chickenTeriyaki,
  tunaMelt,
  meatballMarinara,
}

class Sandwich {
  final SandwichType type;
  final bool isFootlong;
  final BreadType breadType;
  final bool isToasted;
  final String? id;
  final String? description;
  final bool available;

  Sandwich({
    required this.type,
    required this.isFootlong,
    required this.breadType,
    this.isToasted = false,
    this.id,
    this.description,
    this.available = true,
  });

  String get name {
    switch (type) {
      case SandwichType.veggieDelight:
        return 'Veggie Delight';
      case SandwichType.chickenTeriyaki:
        return 'Chicken Teriyaki';
      case SandwichType.tunaMelt:
        return 'Tuna Melt';
      case SandwichType.meatballMarinara:
        return 'Meatball Marinara';
    }
  }

  String get image {
    String typeString = type.name;
    String sizeString = isFootlong ? 'footlong' : 'six_inch';
    return 'assets/images/${typeString}_$sizeString.png';
  }

  factory Sandwich.fromJson(Map<String, dynamic> json,
      {bool isFootlong = true, BreadType breadType = BreadType.white}) {
    final String typeStr = (json['type'] as String? ?? 'veggieDelight');
    final SandwichType type = SandwichType.values.firstWhere(
      (e) => e.name == typeStr,
      orElse: () => SandwichType.veggieDelight,
    );

    return Sandwich(
      type: type,
      isFootlong: isFootlong,
      breadType: breadType,
      id: json['id'] as String?,
      description: json['description'] as String?,
      available: json['available'] as bool? ?? true,
    );
  }
}
