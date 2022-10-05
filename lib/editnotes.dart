import 'package:flutter/material.dart';
import 'package:note/constants/constants.dart';
import 'package:note/homeScreen.dart';
import 'package:note/sqldb.dart';

class EditNotes extends StatefulWidget {
  final note;
  final title;
  final color;
  final id;
  const EditNotes({Key? key, this.note, this.title, this.id, this.color})
      : super(key: key);

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  @override
  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController note = TextEditingController();

  TextEditingController title = TextEditingController();

  TextEditingController color = TextEditingController();

  SqlDb sqlDb = SqlDb();

  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    color.text = widget.color;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Text('Edit  Notes'),
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
                          int response = await sqlDb.updateData('''
                            UPDATE notes SET
                            note = "${note.text}",
                            title = "${title.text}",
                            color = "${color.text}"
                            WHERE id = ${widget.id}
                              ''');

                          if (response > 0) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => homeScreen(),
                                ),
                                ((route) => false));
                          }
                        },
                        child: Text('Edit Notes'),
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
