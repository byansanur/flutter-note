import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteModify extends StatelessWidget {

  final String noteID;
  bool get isEditing => noteID != null;

  NoteModify({this.noteID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit catatan' : 'Tambah catatan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'Isi judul catatan'
              ),
            ),
            Container(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Isi content catatan'
              ),
            ),
            Container(height: 16),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: RaisedButton(
                child: Text(
                  'Tambah',
                  style: TextStyle( 
                    color: Colors.white,
                    fontSize: 18
                  )
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ]
        ),
      )
    );
  }
}