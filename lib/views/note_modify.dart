import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todonotes/models/note.dart';
import 'package:todonotes/models/note_insert.dart';
import 'package:todonotes/services/note_services.dart';


class NoteModify extends StatefulWidget {
 
  final String noteID;
  NoteModify({this.noteID});

  @override
  _NoteModifyState createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  bool get isEditing => widget.noteID != null;

  NotesService get notesService => GetIt.I<NotesService>();

  String errorMessage;
  Note note;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      notesService.getNote(widget.noteID)
        .then((response) {
          setState(() {
            _isLoading = false;
          });

          if (response.error) {
            errorMessage = response.errorMessage ?? 'Kesalahan Server';
          }
          note = response.data;
          _titleController.text = note.noteTitle;
          _contentController.text = note.noteContent;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Catatan' : 'Tamba Catatan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading ? Center(child: CircularProgressIndicator()) : Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Isi judul catatan'
              ),
            ),
            Container(height: 8),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                hintText: 'isi content anda'
              ),
            ),
            Container(height: 16),
            SizedBox(
              width: double.infinity,
              height: 35,
              child: RaisedButton(
                child: Text('Tambah', style: TextStyle(color: Colors.white)),
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  if (isEditing) {
                    // update data
                    setState(() {
                      _isLoading = true;
                    });
                    final note = NoteManipulation(
                      noteTitle: _titleController.text, 
                      noteContent: _contentController.text
                    );
                    final result = await notesService.updateNote(widget.noteID, note);
                    setState(() {
                      _isLoading = false;
                    });
                    final title = 'Selesai';
                    final text = result.error ? (result.errorMessage ?? 'Kesalahan server') : 'Berhasil memperbaharui catatan anda';
                    showDialog(
                      context: null,
                      builder: (_) => AlertDialog(
                        title: Text(title),
                        content: Text(text),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Ok')
                          )
                        ],
                      )
                    )
                    .then((data) {
                      if (result.data) {
                        Navigator.of(context).pop();
                      }
                    });
                  } else {
                    // tambah data
                    setState(() {
                      _isLoading = true;
                    });
                    final note = NoteManipulation(
                      noteTitle: _titleController.text, 
                      noteContent: _contentController.text
                    );
                    final result = await notesService.createNote(note);
                    setState(() {
                      _isLoading = false;
                    });
                    final title = 'Selesai';
                    final text = result.error ? (result.errorMessage ?? 'Kesalahan jaringan') : 'Catatan ditambahkan';
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(title),
                        content: Text(text),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            }, 
                            child: Text('Ok'),
                          )
                        ],
                      )
                    )
                    .then((data) {
                      if(result.data) {
                        Navigator.of(context).pop();
                      }
                    });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
