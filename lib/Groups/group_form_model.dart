import 'package:reactive_forms/reactive_forms.dart';
import 'package:sye/Classes/category.dart';

class GroupFormModel{
  /// decimalRegExp is a regular expression (regex) that defines a decimal number
  /// with '.' as divider between integer and decimal part.
  /// Ex. 35.7 | 7 | 0.954


  final FormGroup form = fb.group({
    'name': FormControl<String>(value: '', validators: [Validators.required]),
    'description' : FormControl<String>(value: ''),
    'currency':  FormControl<String>(value: 'USD', validators: [Validators.required]),
    'category' : FormControl<String>(value: '', validators: [Validators.required]),
    'email' : FormControl<String>(value: '', validators: [Validators.email]),
    'users': FormArray<String>([FormControl(validators: [Validators.maxLength(50), Validators.minLength(1)])]),
  });
}