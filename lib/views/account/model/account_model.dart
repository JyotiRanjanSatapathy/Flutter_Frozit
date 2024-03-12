class UserAccount {
  final String uid;
  final String? email;
  final String? phone;
  Address? address;

  UserAccount({
    required this.uid,
    required this.email,
    required this.phone,
    this.address,
  });

  UserAccount.fromJson(Map<String, dynamic> json)
      : uid = json['uid'] ?? json['userUid'],
        email = json['email'],
        phone = json['phone'],
        address = json['location'] != null
            ? Address(
                name: json['location']['name'],
                area: json['location']['address'],
                city: json['location']['city'],
                state: json['location']['state'],
                pincode: json['location']['pincode'],
              )
            : null;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'location': address != null
          ? {
              'name': address!.name,
              'address': address!.area,
              'city': address!.city,
              'state': address!.state,
              'pincode': address!.pincode,
            }
          : null,
    };
  }
}

class Address {
  final String name;
  final String area;
  final String city;
  final String state;
  final String pincode;

  Address({
    required this.name,
    required this.area,
    required this.city,
    required this.state,
    required this.pincode,
  });
}
