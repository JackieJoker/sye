import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/*class AddUserForm extends StatefulWidget {
  final FormGroup form;

  const AddUserForm({required f,Key? key}) : form = f, super(key: key);

  @override
  AddUserFormState createState() => AddUserFormState();
}

class AddUserFormState extends State<AddUserForm> {
  FormArray get usersList => widget.form.control('users') as FormArray;

  @override
  void initState() {

  }

  void addUser(String us) {
    usersList.add();
  }

}*/

class AddUserForm extends StatelessWidget {

  const AddUserForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child:
        Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  child: const Text(
                    'Who Participates? (0/50)',
                    style: TextStyle(
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
              /*Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListView(),
              ),*/
              /*FutureBuilder(
                future: ,
                builder: (context, snapshot) {
                  return ListView.builder(itemBuilder: null),
                },
              ),*/
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(
                      fit: FlexFit.tight,
                      flex: 4,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Participant\'s name',
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: GestureDetector(
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
          ),
        ),
    );
  }
}

