import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sye/Currency/currency_row.dart';
import 'package:sye/Expenses/expense_form_users.dart';
import 'package:sye/Groups/group.dart';
import '../Db/db.dart';
import 'expense_form_model.dart';
import 'package:currency_picker/currency_picker.dart';

class ExpenseForm extends StatelessWidget {
  final Group _group;
  final ExpenseFormModel _model;

  const ExpenseForm(
      {required Group group, required ExpenseFormModel model, Key? key})
      : _group = group,
        _model = model,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final _currency = ValueNotifier('');
    final form = _model.form;
    return ReactiveFormBuilder(
      form: () => form,
      builder: (context, form, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: <Widget>[
              ReactiveTextField(
                formControlName: 'title',
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validationMessages: (control) => {
                  ValidationMessage.required: 'The title cannot be empty',
                },
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
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                      ],
                      validationMessages: (control) => {
                        ValidationMessage.required:
                            'The amount cannot be empty',
                        ValidationMessage.pattern: 'The amount must be a decimal number'
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 11),
                    child: SizedBox(
                      width: 100,
                      child: ReactiveTextField(
                        formControlName: 'currency',
                        readOnly: true,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black54,
                          ),
                        ),
                        onTap: () {
                          showCurrencyPicker(
                            context: context,
                            showFlag: true,
                            showCurrencyName: true,
                            showCurrencyCode: true,
                            onSelect: (Currency currency) {
                              form.control('currency').value = currency.code;
                              _currency.value = currency.code;
                            },
                            favorite: [_group.getCurrency()],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              ValueListenableBuilder<String>(
                valueListenable: _currency,
                builder: (context, currency, child) {
                  return ReactiveValueListenableBuilder<String>(
                    formControlName: 'amount',
                    builder: (context, amount, child) {
                      return CurrencyRow(
                        currency: currency,
                        amount: amount,
                        form: form,
                        groupCurrency: _group.getCurrency(),
                      );
                    },
                  );
                },
              ),
              ReactiveDatePicker(
                formControlName: 'date',
                builder: (BuildContext context,
                    ReactiveDatePickerDelegate<dynamic> picker, Widget? child) {
                  return ReactiveTextField(
                    readOnly: true,
                    onTap: picker.showPicker,
                    formControlName: 'date',
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                  );
                },
                firstDate: DateTime(2010),
                lastDate: DateTime(2030),
              ),
              DB.getUsersList(_group.getId()) == null
                  ? const SizedBox.shrink()
                  : FirebaseDatabaseQueryBuilder(
                      query: DB.getUsersList(_group.getId())!,
                      builder: (BuildContext context,
                          FirebaseQueryBuilderSnapshot snapshot,
                          Widget? child) {
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
                              .toList(),
                          validationMessages: (control) => {
                            ValidationMessage.required:
                                'The payer cannot be empty',
                          },
                        );
                      },
                    ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "For who",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              ExpenseUsersForm(form: form, group: _group),
            ]),
          ),
        );
      },
    );
  }
}
