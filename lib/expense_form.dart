import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:intl/intl.dart';
import 'package:sye/expense_users_form.dart';
import 'db.dart';

class ExpenseForm extends StatelessWidget {
  final String _groupId;
  ExpenseForm({required String groupId, Key? key}) : _groupId = groupId, super(key: key);

  /// decimalRegExp is a regular expression (regex) that defines a decimal number
  /// with '.' as divider between integer and decimal part.
  /// Ex. 35.7 | 7 | 0.954
  static const decimalRegExp = r'^\d+(\.\d+)?$';

  final FormGroup form = fb.group({
        'title': ['', Validators.required],
        'amount': FormControl<String>(validators: [Validators.required, Validators.pattern(decimalRegExp)]),
        'currency': 'eur',
        'date': [DateTime.now()],
        'payer': ['', Validators.required], //key of the user
        'users': FormArray<bool>([]),
      });

  @override
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
      form: () => form,
      builder: (context, form, child) {
        return SingleChildScrollView(
          child: Column(
              children: <Widget>[
            ReactiveTextField(
              formControlName: 'title',
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  flex: 5,
                  child: ReactiveTextField(
                    formControlName: 'amount',
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: false, decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                    ),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: ReactiveDropdownField<String>(
                    isExpanded: true,
                    formControlName: 'currency',
                    items: const [
                      DropdownMenuItem(
                        value: 'eur',
                        child: Text('EUR'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ReactiveDatePicker(
              formControlName: 'date',
              builder: (BuildContext context, ReactiveDatePickerDelegate<dynamic> picker, Widget? child) {
                return ReactiveTextField(
                  readOnly: true,
                  onTap: picker.showPicker,
                  formControlName: 'date',
                  valueAccessor: DateTimeValueAccessor(
                    dateTimeFormat: DateFormat('dd/MM/yyyy'),
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                );
              },
              firstDate: DateTime(2010),
              lastDate: DateTime(2030),
            ),
            FirebaseDatabaseQueryBuilder(
              query: DB.getUsersList(_groupId),
              builder: (BuildContext context,
                  FirebaseQueryBuilderSnapshot snapshot, Widget? child) {
                if (snapshot.isFetching) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return ReactiveDropdownField<String>(
                    isExpanded: true,
                    formControlName: 'payer',
                    decoration: const InputDecoration(
                      labelText: 'Payed by',
                    ),
                    items: snapshot.docs
                        .map((element) => DropdownMenuItem<String>(
                              child: Text(element.value.toString()),
                              value: element.key.toString(),
                            ))
                        .toList());
              },
            ),
            const Text(
              "For who",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            ExpenseUsersForm(form: form, groupId: _groupId,),
            ReactiveFormConsumer(
              builder: (BuildContext context, FormGroup formGroup, Widget? child) {
                return ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: form.valid ? _onSubmit : null,
                );
              },
            ),
          ]),
        );
      },
    );
  }
  void _onSubmit() {
    List<bool?> usersBool = form.findControl('users')!.value as List<bool?>;
    Map<String, String> selectedUsers = {};
    for(int i = 0; i < usersBool.length; i++){
      if (usersBool[i]!) selectedUsers[DB.userKeys[i]] = DB.users[i];
    }
    Map? edited = Map.of(form.value);
    edited.update('users', (value) => selectedUsers) as Map?;
    edited.update('date', (value) => value.toString());
    edited.update('amount', (value) => double.parse(value));
    DB.addExpense(_groupId, edited);
    //form.reset();
  }
}
