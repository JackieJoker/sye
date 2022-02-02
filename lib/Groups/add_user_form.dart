import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddUserForm extends StatefulWidget {
  final FormGroup _form;

  const AddUserForm({required form, Key? key}) : _form = form, super(key: key);

  @override
  _AddUserFormState createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  List<String> usersList = [];
  String? tempUser;
  final TextEditingController eCtrl = TextEditingController();
  final TextEditingController eCtrl1 = TextEditingController();
  FormArray get uList => widget._form.control('users') as FormArray;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
      ReactiveFormBuilder(
        form: () => widget._form,
        builder: (BuildContext context, FormGroup form, child) {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  child: Text(
                    'Who Participates? ('+ usersList.length.toString() + '/50)',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
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
                              onSubmitted: (text) {
                                if (text.isNotEmpty){
                                  usersList[index] = text;
                                  uList.removeAt(index);
                                  uList.insert(index, FormControl<String>(value: text));
                                  eCtrl.clear();
                                  setState(() {});
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
                                        uList.removeAt(index);
                                        setState(() {});
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
                        onChanged: (text) {
                          tempUser = text;
                        },
                        controller: eCtrl,
                        onSubmitted: (text) {
                          if (text.isNotEmpty){
                            usersList.add(text);
                            eCtrl.clear();
                            uList.add(FormControl<String>(value: text));
                            setState(() {});
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
                            uList.add(FormControl<String>(value: tempUser));
                            tempUser = null;
                            setState(() {});
                          }
                        },
                        child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 80,
                            maxHeight: 35,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.blueAccent,
                            shape: BoxShape.rectangle,
                          ),
                          child: const Center(
                            child: Text("Add"),
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
    );
  }
}




