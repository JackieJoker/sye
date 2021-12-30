import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:intl/intl.dart';
import 'package:sye/expense_users_form.dart';
import 'db.dart';
import 'group_form_model.dart';

class GroupForm extends StatelessWidget {
  //final String _userId;
  final GroupFormModel _model;
  const GroupForm({required GroupFormModel model, Key? key}) : _model = model, super(key: key);

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
                  formControlName: 'name',
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SizedBox(
                    width: 500,
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
                const Text('Specify the currency that will be used to calculate the Group\'s balance. Expenses could be done in other currencies.'),
                Padding(
                    padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Container(
                            child: Text(
                                "Category",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                        Row(
                          children: const [
                            Text('🌍 Travel'),
                            Text('🏠 Shared house'),
                            Text('😍 Couple'),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                        Row(
                          children: const [
                            Text('🎤 Event'),
                            Text('🛠 Project'),
                            Text('👉 Others'),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                      ],
                    ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                    child: Container(
                      child: Text(
                        'Your Informations',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                      height: 60,
                      color: Colors.blueGrey,
                    ),
                ),
                ReactiveTextField(
                  formControlName: 'email',
                  decoration: const InputDecoration(
                    labelText: 'Email(optional)',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                  child: Container(
                    child: Text(
                      'Who Partecipates? (0/50)',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    height: 60,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
                  mainAxisAlignment: MainAxisAlignment.start,
          ),
        );
      },
    );
  }
}

/*Row(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Flexible(
flex: 5,
child: ReactiveTextField(
formControlName: 'description',
keyboardType: const TextInputType.numberWithOptions(
signed: false, decimal: true),
decoration: const InputDecoration(
labelText: 'Description',
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
),*/