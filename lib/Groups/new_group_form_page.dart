import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../Db/db.dart';

class NewGroupFormPage extends StatelessWidget {

  final _formKey = GlobalKey<FormBuilderState>();

  NewGroupFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var usersList = [];
    final TextEditingController eCtrl = TextEditingController();
    final TextEditingController eCtrl1 = TextEditingController();
    String? tempUser;
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              const Text("New Group"),
              TextButton(
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    _onSubmit(context);
                  })
            ]),
      ),
      body: FormBuilder(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child:
                FormBuilderTextField(
                  name: 'name',
                  validator: FormBuilderValidators.required(context),
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child:
                FormBuilderTextField(
                  name: 'description',
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 4),
                child: FormBuilderTextField(
                  name: 'currency',
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Currency",
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
                        _formKey.currentState?.fields['currency']?.didChange(currency.code);
                      },
                      favorite: ['USD','EUR'],
                    );
                  },
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
                    //const CategoryWidget(),
                    FormBuilderChoiceChip(
                        name: 'category',
                        validator: FormBuilderValidators.required(context),
                        padding: const EdgeInsets.all(5.0),
                        spacing: 18.0,
                        options: const [
                          FormBuilderFieldOption(
                            value: 'travel',
                            child: Text('🌍 Travel'),
                          ),
                          FormBuilderFieldOption(
                            value: 'sharedHouse',
                            child: Text('🏠 Shared house'),
                          ),
                          FormBuilderFieldOption(
                            value: 'couple',
                            child: Text('😍 Couple'),
                          ),
                          FormBuilderFieldOption(
                            value: 'event',
                            child: Text('🎤 Event'),
                          ),
                          FormBuilderFieldOption(
                            value: 'project',
                            child: Text('🛠 Project'),
                          ),
                          FormBuilderFieldOption(
                            value: 'others',
                            child: Text('👉 Others'),
                          ),
                        ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  child: const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Your Informations',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
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
                FormBuilderTextField(
                  name: 'email',
                  validator: FormBuilderValidators.email(context),
                  decoration: const InputDecoration(
                    labelText: 'Email(optional)',
                  ),
                ),
              ),
              FormBuilderField(
                name: "participants",
                builder: (FormFieldState<dynamic> field) {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Who Participates? ('+ usersList.length.toString() + '/50)',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70
                              ),
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                          height: 60,
                          color: Colors.blueGrey,
                          padding: const EdgeInsets.only(left:3),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: usersList.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          //return Text(usersList[index]);
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
                            child: Container(
                              decoration: const BoxDecoration(shape: BoxShape.rectangle),
                              constraints: const BoxConstraints(maxWidth: 500, maxHeight: 40),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      key: const Key('02'),
                                      onSubmitted: (text) {
                                        if (text.isNotEmpty){
                                          usersList[index] = text;
                                          _formKey.currentState?.fields['participants']?.didChange(usersList);
                                        }
                                      },
                                      controller: eCtrl1,
                                      decoration: InputDecoration(
                                          hintText: usersList[index],
                                          border: InputBorder.none,
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              if (index != 0) {
                                                usersList.removeAt(index);
                                                _formKey.currentState?.fields['participants']?.didChange(usersList);
                                              }
                                            },
                                            child: const Icon(Icons.clear),
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              fit: FlexFit.tight,
                              flex: 4,
                              child: TextField(
                                key: const Key('01'),
                                onChanged: (text) {
                                  tempUser = text;
                                },
                                controller: eCtrl,
                                onSubmitted: (text) {
                                  if (text.isNotEmpty){
                                    usersList.add(text);
                                    eCtrl.clear();
                                    _formKey.currentState?.fields['participants']?.didChange(usersList);
                                  }
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Participant\'s name',
                                ),
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  if (tempUser!.isNotEmpty) {
                                    usersList.add(tempUser!);
                                    _formKey.currentState?.fields['participants']?.didChange(usersList);
                                    eCtrl.clear();
                                    tempUser = null;
                                  }
                                },
                                child: Container(
                                  constraints: const BoxConstraints(
                                    maxWidth: 80,
                                    maxHeight: 35,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.indigo,
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: const Center(
                                    child: Text("Add",
                                    style: TextStyle(color: Colors.white),),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
              //AddUserForm(form: form),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),

        ),
      ),
    );
  }
  void _onSubmit(BuildContext context) {

    var valid = _formKey.currentState!.validate();
    if (valid) {
      _formKey.currentState!.save();
      Map<String, String> mapUsers = getUserList(_formKey.currentState?.fields['participants']?.value);

      var keys = _formKey.currentState!.fields.keys;
      Map<String,dynamic> edited = {};

      for (var element in keys) {
        edited[element] = "";
      }
      edited.update('name', (value) => _formKey.currentState!.fields['name']!.value);
      edited.update('currency', (value) => _formKey.currentState?.fields['currency']?.value);
      edited.update('category', (value) => _formKey.currentState?.fields['category']?.value);
      edited.update('participants', (value) => mapUsers);
      if (_formKey.currentState?.fields['email']?.value != null) {
        edited.update('email', (value) => _formKey.currentState?.fields['email']?.value);
      } else {
        edited.remove('email');
      }
      if (_formKey.currentState?.fields['description']?.value != null) {
        edited.update('description', (value) => _formKey.currentState?.fields['description']?.value);
      } else {
        edited.remove('description');
      }

      log(edited.toString());
      DB.addGroups(edited);
      Navigator.pop(context);
    } else {
      _formKey.currentState!.invalidateField(name: 'name');
      _formKey.currentState!.invalidateField(name: 'currency');
      _formKey.currentState!.invalidateField(name: 'category', errorText: 'Choose a given category');
      _formKey.currentState!.invalidateField(name: 'participants');
      log('Not validated');
    }//log(_formKey.currentState!.fields['title']!.value);
  }

  Map<String,String> getUserList(List<dynamic> uList) {
    List<dynamic> users = uList;
    Map<String, String> mapUsers = {};
    for (int i = 0; i < users.length; i++) {
      if (users[i]!.isNotEmpty) mapUsers['u'+i.toString()] = users[i]!.toString();
    }
    return mapUsers;
  }
}

  /*Future<String?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final value = await prefs.getString('deviceId');
    return value;
  }*/
