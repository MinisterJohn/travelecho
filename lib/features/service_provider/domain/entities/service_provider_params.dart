class ServiceProviderParams {
  final String make;
  final String model;
  final int year;
  final String color;
  final String licensePlate;
  final String? phoneNumber;
  final String? serviceDescription;

  ServiceProviderParams({
    required this.make,
    required this.model,
    required this.year,
    required this.color,
    required this.licensePlate,
    this.phoneNumber,
    this.serviceDescription,
  });

  Map<String, dynamic> toJson() => {
    'car': {
      'make': make,
      'model': model,
      'year': year,
      'color': color,
      'licensePlate': licensePlate,
    },
    if (phoneNumber != null) 'phoneNumber': phoneNumber,
    if (serviceDescription != null) 'serviceDescription': serviceDescription,
  };
}
