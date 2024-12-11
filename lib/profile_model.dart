class ProfileModel {
  final String title;
  final String first;
  final String last;
  final String gender;
  final String email;
  final String phone;
  final String large;
  ProfileModel({
    required this.title,
    required this.first,
    required this.last,
    required this.gender,
    required this.email,
    required this.phone,
    required this.large,
  });

  //factory constructor
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      title: json['name']['title'] as String? ?? '',
      first: json['name']['first'] as String? ?? '',
      last: json['name']['last'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      large: json['picture']['large'] as String? ?? '',
    );
  }

  //method to convert ProfileModel to JSON
  Map<String, dynamic> toJson() => {
        'name': {'first': first, 'last': last, 'title': title},
        'gender': gender,
        'email': email,
        'phone': phone,
        'picture': {'large': large}
      };
}
