class Category {
  final String _name;
  final String _icon;

  const Category({required name, icon}):
      _name = name,
      _icon = icon;

  String getName() {
    return _name;
  }
  String getIcon() {
    return _icon;
  }
  Map<String, dynamic> toMap() {
    return {
      'name' : _name,
      'icon' : _icon,
    };
  }
}