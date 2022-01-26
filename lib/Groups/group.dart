class Group {
  final String _id;
  final String _name;
  final String _description;
  final String? _creator;
  final String _currency;
  final String? _category;
  final Map? _expenses;
  final Map? _users;

  const Group({
    required id,
    required name,
    required description,
    creator,
    required currency,
    category,
    expenses,
    users,}) :
      _id = id,
      _name = name,
      _description = description,
      _creator = creator,
      _currency = currency,
      _category = category,
      _expenses = expenses,
      _users = users;


  String getDescription() {
    return _description;
  }
  String? getCreator() {
    return _creator;
  }
  String getCurrency() {
    return _currency;
  }
  String? getCategory() {
    return _category;
  }
  Map? getExpenses() {
    return _expenses;
  }
  Map? getUsers() {
    return _users;
  }
  String getName() {
    return _name;
  }
  String getId() {
    return _id;
  }
  Map<String, dynamic> toMap() {
    return {
      'name' : _name,
      'description' : _description,
      'creator' : _creator,
      'currency' : _currency,
      'category' : _category,
      'expenses' : _expenses,
      'users' : _users,
    };
  }

}