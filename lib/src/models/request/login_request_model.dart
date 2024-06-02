class LoginRequestModel {
  LoginRequestModel({
    required String phoneNumber,
    required String password,
    String? countryCode,
  })  : _phoneNumber = phoneNumber,
        _password = password,
        _countryCode = countryCode ?? '62';

  final String _phoneNumber;
  final String _password;
  final String _countryCode;

  Map<String, dynamic> toJson() => {
        'phone_number': _phoneNumber,
        'password': _password,
        'country_code': _countryCode,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
