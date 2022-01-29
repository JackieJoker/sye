import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sye/Db/db.dart';
import 'package:sye/Groups/select_user_page.dart';

final _form = FormGroup({
  'code': FormControl<String>(
    validators: [Validators.required], // traditional required
    asyncValidators: [_existingCode], // custom asynchronous validator
  ),
});

class ImportGroupPage extends StatelessWidget {
  const ImportGroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Import a group'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MediaQuery.of(context).orientation == Orientation.portrait ?
              const Padding(
                padding: EdgeInsets.only(top: 200),
                child: Text(
                  "Group code",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              )
              : const Padding(
                padding: EdgeInsets.only(top: 0),
                child: Text(
                  "Group code",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 26.0),
                child: ReactiveForm(
                  formGroup: _form,
                  child: ReactiveTextField(
                    formControlName: 'code',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Copy and paste here the Group code',
                    ),
                    onEditingComplete: () {
                      String code = _form.findControl('code')!.value.toString();
                      if (_form.valid) {
                        Navigator.of(context)
                            .push(slideRoute(SelectUserPage(code)));
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Route slideRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

/// Async validator that contact the DB to check if the code (groupID) is present
Future<Map<String, dynamic>?> _existingCode(
    AbstractControl<dynamic> control) async {
  final error = {'Please enter a valid code': false};

  String code = _form.findControl('code')!.value.toString();
  final bool groupPresent = await DB.isGroupPresent(code);

  if (!groupPresent) {
    control.markAsTouched();
    return error;
  }

  return null;
}