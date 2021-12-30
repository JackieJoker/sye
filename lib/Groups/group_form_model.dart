import 'package:reactive_forms/reactive_forms.dart';
import 'package:sye/Classes/category.dart';

class GroupFormModel{
  /// decimalRegExp is a regular expression (regex) that defines a decimal number
  /// with '.' as divider between integer and decimal part.
  /// Ex. 35.7 | 7 | 0.954


  final FormGroup form = fb.group({
    'name': ['', Validators.required],
    'currency': 'eur',
    'category' : Category,
    'email' : ['', Validators.email],
    'users': FormArray<bool>([]),
  });
}