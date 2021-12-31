class User{
  final String _id;
  final String _name;
  final String _surname;
  final String _email;
  final String _iban;

  const User({required id, required name, surname, email, iban,}):
      _id = id,
      _name = name,
      _surname = surname,
        _email = email,
      _iban = iban;

  String getId() {
    return _id;
  }
  String getName() {
    return _name;
  }
  String getSurname() {
    return _surname;
  }
  String getEmail() {
    return _email;
  }
  String getIban() {
    return _iban;
  }
  Map<String, dynamic> toMap() {
    return {
      'name' : _name,
      'surname' : _surname,
      'email' : _email,
      'iban' : _iban,
    };
  }
}