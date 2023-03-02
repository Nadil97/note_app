import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Note App',
      home: NoteList(),
    );
  }
}

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  final List<String> _notes = [];
  final _textController = TextEditingController();

  void _addNote() {
    setState(() {
      _notes.add(_textController.text);
      _textController.clear();
    });
  }

  void _deleteNote(int index) {
    setState(() {
      _notes.removeAt(index);
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 200,
            title: const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Note',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/app.png'),
              )),
            ),
            backgroundColor: const Color(0xff1ABC9C),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              // bottomRight: Radius.circular(40),
              // bottomRight: Radius.elliptical(100, 10),
              bottomLeft: Radius.circular(50),
            ))),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _notes.length,
                itemBuilder: (BuildContext context, int index) {
                  final note = _notes[index];
                  return ListTile(
                    title: Text(
                      note,
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Color(0xff1ABC9C),
                      ),
                      onPressed: () => _deleteNote(index),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        height: 50,
                        child: TextField(
                          controller: _textController,
                          decoration: const InputDecoration(
                            labelText: 'Add Note',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                          onSubmitted: (_) => _addNote(),
                        )),
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: _addNote,
                    child: Text('Add',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff1ABC9C),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        // floatingActionButton: Align(
        //   alignment: Alignment.centerRight,
        //   child: FloatingActionButton(
        //     onPressed: () {
        //       showDialog(
        //         context: context,
        //         builder: (context) => AlertDialog(
        //           title: Text('Delete All Notes?'),
        //           content: Text('Are you sure you want to delete all notes?'),
        //           actions: [
        //             TextButton(
        //               onPressed: () => Navigator.pop(context),
        //               child: Text('Cancel'),
        //             ),
        //             TextButton(
        //               onPressed: () {
        //                 setState(() {
        //                   _notes.clear();
        //                 });
        //                 Navigator.pop(context);
        //               },
        //               child: Text('Delete'),
        //             ),
        //           ],
        //         ),
        //       );
        //     },
        //     tooltip: 'Delete All Notes',
        //     child: Icon(Icons.delete),
        //   ),
        // ),
      ),
    );
  }
}
