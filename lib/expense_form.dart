import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:intl/intl.dart';
import 'package:sye/expense_users_form.dart';
import 'db.dart';
import 'expense_form_model.dart';

class ExpenseForm extends StatelessWidget {
  final String _groupId;
  final ExpenseFormModel _model;
  const ExpenseForm({required String groupId, required ExpenseFormModel model, Key? key}) : _groupId = groupId, _model = model, super(key: key);

  @override
  Widget build(BuildContext context) {
    final form = _model.form;
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Padding(
                  padding: const EdgeInsets.only(top: 11),
                  child: SizedBox(
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
          ]),
        );
      },
    );
  }
}
