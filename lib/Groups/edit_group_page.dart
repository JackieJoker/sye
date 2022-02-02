import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sye/home_page.dart';

import 'group.dart';
import '../Db/db.dart';

class EditGroupPage extends StatelessWidget {
  final Group _group;
  EditGroupPage({Key? key, required Group group}) : _group = group, super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    Map<dynamic,dynamic> usersMap = _group.getUsers()!;
    List<dynamic> usersList = castMapUsersToList(usersMap);
    String? tempUser;
    final TextEditingController eCtrl = TextEditingController();
    final TextEditingController eCtrl1 = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 14
                ),
              ),
              onTap: () => Navigator.pop(context),
            ),
            const Text('Edit the Group',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                _onSubmit(usersList);
                Navigator.pop(context);
              },
              child: const Text(
                'Save',
                style: TextStyle(
                    fontSize: 14
                ),
              ),
            )
          ],
        ),
      ),
      body: FormBuilder(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 6),
                child: Text('Name',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child:
                FormBuilderTextField(
                  name: 'name',
                  decoration: InputDecoration(
                    hintText: _group.getName(),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 6),
                child: Text('Description',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child:
                FormBuilderTextField(
                  name: 'description',
                  decoration: InputDecoration(
                    hintText: _group.getDescription(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 20),
                child: Text('Currency: ' + _group.getCurrency(),
                  style: const TextStyle(
                      fontSize: 20
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
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Who Participates? ('+ usersList.length.toString() + '/50)',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70,
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
                                    log(usersList.toString());
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
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  child: GestureDetector(
                    onTap: () {
                      DB.deleteGroup(_group.getId());
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const HomePage()));
                    },
                    child: const Text(
                      'Delete this Group',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(450, 204, 0, 0)
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  height: 60,
                  color: Colors.blueGrey,
                  padding: const EdgeInsets.only(left:3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmit(List<dynamic> l) {
    var valid = _formKey.currentState!.validate();
    if (valid) {
      _formKey.currentState!.save();
      Map<String, String> mapUsers = getUserList(l);

      var keys = _formKey.currentState!.fields.keys;
      Map<String,dynamic> edited = {};

      for (var element in keys) {
        edited[element] = "";
      }
      if (_formKey.currentState!.fields['name']!.value != null) {
        edited.update('name', (value) => _formKey.currentState!.fields['name']!.value);
      } else {
        edited.remove('name');
      }
      edited.update('participants', (value) => mapUsers);
      if (_formKey.currentState?.fields['description']?.value != null) {
        edited.update('description', (value) => _formKey.currentState?.fields['description']?.value);
      } else {
        edited.remove('description');
      }
      DB.editGroup(_group.getId(), edited);
    } else {
      _formKey.currentState!.invalidateField(name: 'name');
      _formKey.currentState!.invalidateField(name: 'currency');
      _formKey.currentState!.invalidateField(name: 'category', errorText: 'Choose a given category');
      _formKey.currentState!.invalidateField(name: 'participants');
    }

    //TODO: updating also the balances of new users


    //log(_formKey.currentState!.fields['title']!.value);
  }
}

List<dynamic> castMapUsersToList (Map<dynamic,dynamic> m) {
  int i = 0;
  List<dynamic> l = [];
  while (m.containsKey('u' + i.toString())) {
    l.add(m['u' + i.toString()]);
    i += 1;
  }
  return l;
}

Map<String,String> getUserList(List<dynamic> uList) {
  List<dynamic> users = uList;
  Map<String, String> mapUsers = {};
  for (int i = 0; i < users.length; i++) {
    if (users[i]!.isNotEmpty) mapUsers['u'+i.toString()] = users[i]!.toString();
  }
  return mapUsers;
}