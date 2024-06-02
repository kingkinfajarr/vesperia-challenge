class UpdateProfileRequestModel {
  UpdateProfileRequestModel({
    required String name,
    required String email,
    required String gender,
    required String dob,
    required int height,
    required int weight,
    String? countryCode,
  })  : _name = name,
        _email = email,
        _gender = gender,
        _dob = dob,
        _height = height,
        _weight = weight;

  final String _name;
  final String _email;
  final String _gender;
  final String _dob;
  final int _height;
  final int _weight;

  Map<String, dynamic> toJson() => {
        'name': _name,
        'email': _email,
        'gender': _gender,
        'date_of_birth': _dob,
        'height': _height,
        'weight': _weight,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
