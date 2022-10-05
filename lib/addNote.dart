import 'package:flutter/material.dart';
import 'package:note/constants/constants.dart';
import 'package:note/homeScreen.dart';
import 'package:note/sqldb.dart';

class add extends StatefulWidget {
  @override
  State<add> createState() => _addState();
}

class _addState extends State<add> {
  Widget build(BuildContext context) {
    GlobalKey<FormState> formstate = GlobalKey();

    TextEditingController note = TextEditingController();

    TextEditingController title = TextEditingController();

    TextEditingController color = TextEditingController();
    // SqlDb sqlDb = SqlDb();
    SqlDb sqlDb = SqlDb();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Text('Add Notes'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Form(
                  key: formstate,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: note,
                        decoration: InputDecoration(hintText: 'note'),
                      ),
                      TextFormField(
                        controller: title,
                        decoration: InputDecoration(hintText: 'title'),
                      ),
                      // TextFormField(
                      //   controller: color,
                      //   decoration: InputDecoration(hintText: 'color'),
                      // ),
                      Container(
                        height: 20,
                      ),
                      MaterialButton(
                        textColor: Colors.white,
                        color: kBackgroundColor,
                        onPressed: () async {
                          int response = await sqlDb.insertData('''
                              INSERT INTO notes (note, title , color) 
                              VALUES ( "${note.text}" , "${title.text}" , "${color.text}" )
                              ''');
                          print('respose====================');
                          print(response);
                          if (response > 0) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => homeScreen(),
                                ),
                                ((route) => false));
                          }
                        },
                        child: Text('Add note'),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
