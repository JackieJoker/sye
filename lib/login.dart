import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
              ),
              const Flexible(
                fit: FlexFit.tight,
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text('Login'),
                ),
              )
            ],
          ),
        ),
        body: Column(
          children: [

            Container(

            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          shape: BoxShape.rectangle,
                          border: Border.all(),
                          boxShadow: []
                        ),
                        width: 300,
                        height: 50,
                        child: Center(child: Text('Login with Apple')),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            shape: BoxShape.rectangle,
                            border: Border.all(),
                            boxShadow: []
                        ),
                        width: 300,
                        height: 50,
                        child: Center(child: Text('Login with Facebook')),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            shape: BoxShape.rectangle,
                            border: Border.all(),
                            boxShadow: []
                        ),
                        width: 300,
                        height: 50,
                        child: Center(child: Text('Login with Google')),
                      ),
                    ),
                  ),
                  FormBuilder(
                      key: _formKey,
                      child: Column(
                        children: [
                          FormBuilderTextField(name: 'name'),
                          FormBuilderTextField(name: 'email')
                        ],      
                      )
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
