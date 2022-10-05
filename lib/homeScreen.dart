import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:note/addNote.dart';
import 'package:note/constants/constants.dart';
import 'package:note/sqldb.dart';

import 'editnotes.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  SqlDb sqlDb = SqlDb();
  bool isloading = true;

  List notes = [];

  Future redData() async {
    List<Map> response = await sqlDb.readData('SELECT * FROM notes');
    notes.addAll(response);
    if (this.mounted) {
      isloading = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    redData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: kBackgroundColor,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: ((context) => add())));
          },
          child: Icon(Icons.edit),
        ),
        backgroundColor: Color(0xfff3f4f7),
        appBar: AppBar(
          backgroundColor: Color(0xfff3f4f7),
          title: Text(
            'SQL',
            style: TextStyle(color: kBackgroundColor),
          ),
          leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.lock,
                color: kBackgroundColor,
              )),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: isloading == true
            ? Center(child: Text('Loading....'))
            : Container(
                child: ListView(children: [
                ListView.builder(
                    itemCount: notes.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return Card(
                          child: ListTile(
                              title: Text(
                                "${notes[i]['title']}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("${notes[i]['note']}"),
                              // trailing: Text("${snaphot.data![i]['color']}"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    EditNotes(
                                                      note: notes[i]['note'],
                                                      title: notes[i]['title'],
                                                      color: notes[i]['color'],
                                                      id: notes[i]['id'],
                                                    ))));
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: kBackgroundColor,
                                      )),
                                  IconButton(
                                      onPressed: () async {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      homeScreen(),
                                                ),
                                                ((route) => false));
                                        int response = await sqlDb.deleteData(
                                            'DELETE FROM notes WHERE id = ${notes[i]['id']}');
                                        if (response > 0) {
                                          notes.removeWhere((element) =>
                                              element['id'] ==
                                              {notes[i]['id']});
                                          setState(() {});
                                        }
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                ],
                              )));
                    })
              ])));
  }

  // Container(
  //   child: Column(
  //     children: [
  //       Center(
  //         child: MaterialButton(
  //           onPressed: () async {
  //             int response = await sqlDb.insertData(
  //                 "INSERT INTO 'notes' ('note') VALUES ('note one')");
  //             print('$response');
  //           },
  //           child: Text(
  //             'insert Data',
  //             style: TextStyle(color: Colors.white),
  //           ),
  //           color: Colors.red,
  //         ),
  //       ),
  //       Center(
  //         child: MaterialButton(
  //           onPressed: () async {
  //             List<Map> response =
  //                 await sqlDb.readData("SELECT * FROM 'notes'");
  //             print('$response');
  //           },
  //           child: Text(
  //             'read Data',
  //             style: TextStyle(color: Colors.white),
  //           ),
  //           color: Colors.red,
  //         ),
  //       ),
  //       Center(
  //         child: MaterialButton(
  //           onPressed: () async {
  //             int response = await sqlDb.updateData(
  //                 "UPDATE 'notes' SET 'note' = 'note six' WHERE id = 1");
  //             print('$response');
  //           },
  //           child: Text(
  //             'Ubdate Data',
  //             style: TextStyle(color: Colors.white),
  //           ),
  //           color: Colors.red,
  //         ),
  //       ),
  //       Center(
  //         child: MaterialButton(
  //           onPressed: () async {
  //             int response = await sqlDb
  //                 .deleteData("DELETE  FROM 'notes' WHERE id = 8 ");
  //             print('$response');
  //           },
  //           color: Colors.red,
  //           child: Text(
  //             'Delete Data',
  //             style: TextStyle(color: Colors.white),
  //           ),
  //         ),
  //       ),
  //       Center(
  //         child: MaterialButton(
  //           onPressed: () async {
  //             sqlDb.mydeleteDatabase();
  //           },
  //           child: Text(
  //             'delete Database',
  //             style: TextStyle(color: Colors.white),
  //           ),
  //           color: Colors.red,
  //         ),
  //       ),

}
