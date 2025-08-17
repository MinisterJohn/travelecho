import "car_model.dart";

class ServiceProvider {
  final Car car;
  final String? phoneNumber;
  final String? serviceDescription;

  ServiceProvider({
    required this.car,
    this.phoneNumber,
    this.serviceDescription,
  });

  Map<String, dynamic> toJson() => {
    'car': car.toJson(),
    if (phoneNumber != null) 'phoneNumber': phoneNumber,
    if (serviceDescription != null) 'serviceDescription': serviceDescription,
  };
}
