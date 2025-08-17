class Car {
  final String make;
  final String model;
  final int year;
  final String color;
  final String licensePlate;

  Car({
    required this.make,
    required this.model,
    required this.year,
    required this.color,
    required this.licensePlate,
  });

  Map<String, dynamic> toJson() => {
    'make': make,
    'model': model,
    'year': year,
    'color': color,
    'licensePlate': licensePlate,
  };
}
