class UserAccount {
  final String name;
  final String email;
  final String phone;
  final Location? location;

  UserAccount({
    required this.name,
    required this.email,
    required this.phone,
    this.location,
  });

  UserAccount.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        phone = json['phone'],
        location = json['location'] != null
            ? Location(
                address: json['location']['address'],
                city: json['location']['city'],
                state: json['location']['state'],
                pincode: json['location']['pincode'],
              )
            : null;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'location': location != null
          ? {
              'address': location!.address,
              'city': location!.city,
              'state': location!.state,
              'pincode': location!.pincode,
            }
          : null,
    };
  }
}

class Location {
  final String address;
  final String city;
  final String state;
  final String pincode;

  Location({
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
  });
}
