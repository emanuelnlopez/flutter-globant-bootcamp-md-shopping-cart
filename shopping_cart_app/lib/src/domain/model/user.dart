class User {
  final int id;
  final String email;
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String city;
  final String street;
  final int streetNumber;
  final String zipcode;
  final String latitude;
  final String longitude;
  final String phoneNumber;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.city,
    required this.street,
    required this.streetNumber,
    required this.zipcode,
    required this.latitude,
    required this.longitude,
    required this.phoneNumber,
  });

  String get fullName => '$firstName $lastName';
  String get initials => '${firstName[0].toUpperCase()}${lastName[0].toUpperCase()}';

  factory User.fromDynamic(dynamic map) => User(
    id: map['id'],
    email: map['email'],
    username: map['username'],
    password: map['password'],
    firstName: map['name']['firstname'],
    lastName: map['name']['lastname'],
    city: map['address']['city'],
    street: map['address']['street'],
    streetNumber: map['address']['number'],
    zipcode: map['address']['zipcode'],
    latitude: map['address']['geolocation']['lat'],
    longitude: map['address']['geolocation']['long'],
    phoneNumber: map['phone'],
  );

  static List<User> fromDynamicList(dynamic list) {
    final result = <User>[];

    if (list != null) {
      for (dynamic map in list) {
        result.add(User.fromDynamic(map));
      }
    }

    return result;
  }
}