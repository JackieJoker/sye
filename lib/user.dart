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
}