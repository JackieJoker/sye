import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:intl/intl.dart';
import 'package:sye/Expenses/expense_users_form.dart';
import 'package:sye/Groups/add_user_form.dart';
import '../Db/db.dart';
import 'category_widget.dart';
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
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child:
                    ReactiveTextField(
                      formControlName: 'name',
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                    ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child:
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 4),
                  child: SizedBox(
                    width: 500,
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
                            },
                          favorite: ['USD','EUR'],
                        );
                      },
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Specify the currency that will be used to calculate the Group\'s balance. Expenses could be done in other currencies.'),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 10, left: 8, right:8),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                            child: const Text(
                                "Category",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                        const CategoryWidget(),
                      ],
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                          child: const Text(
                            'Your Informations',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                    alignment: Alignment.centerLeft,
                    height: 60,
                    color: Colors.blueGrey,
                    padding: const EdgeInsets.only(left: 3),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child:
                    ReactiveTextField(
                      formControlName: 'email',
                      decoration: const InputDecoration(
                        labelText: 'Email(optional)',
                      ),
                    ),
                ),
                const AddUserForm(),
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