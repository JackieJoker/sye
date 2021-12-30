import 'package:reactive_forms/reactive_forms.dart';

class ExpenseFormModel{
  final FormGroup form;

  /// decimalRegExp is a regular expression (regex) that defines a decimal number
  /// with '.' as divider between integer and decimal part.
  /// Ex. 35.7 | 7 | 0.954
  static const decimalRegExp = r'^\d{1,8}(\.\d{1,2})?$';

  ExpenseFormModel({required String groupCurrency}):
    form = fb.group({
      'title': ['', Validators.required],
      'amount': FormControl<String>(
          validators: [Validators.required, Validators.pattern(decimalRegExp)]),
      'currency': groupCurrency,
      'date': [DateTime.now()],
      'payer': ['', Validators.required], //key of the user
      'users': FormArray<bool>([]),
      'converted_amount': FormControl<double>(),
    });
  }



