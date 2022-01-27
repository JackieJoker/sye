import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';

import 'Db/firebase_options.dart';

class JoinUtenti_Gruppi extends StatelessWidget {
  const JoinUtenti_Gruppi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FirebaseDatabaseListView(
          query: FirebaseDatabase.instance.ref("users_groups/u1"),
          itemBuilder: (context, userSnapshot) {
            String groupId = userSnapshot.key!;
            return FirebaseDatabaseQueryBuilder(
              query: FirebaseDatabase.instance.ref('groups/' + groupId),
              builder: (BuildContext context,
                  FirebaseQueryBuilderSnapshot userSnapshot, Widget? child) {
                if (userSnapshot.isFetching) {
                  return const CircularProgressIndicator();
                }
                if (userSnapshot.hasError) {
                  return Text('Error: ${userSnapshot.error}');
                }
                List<DataSnapshot> data = userSnapshot.docs;
                Map<String, dynamic> result = {};
                for (int i = 0; i < data.length; i++) {
                  result.addAll({data[i].key!: data[i].value});
                }
                print(result.toString());
                return ListTile(
                  title: Text(result['name']),
                  subtitle: Text(result['description']),
                );
              },
            );
          },
        ));
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    home: JoinUtenti_Gruppi(),
  ));
}
