import 'package:flutter/material.dart';

class NoteDelete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Perhatian'),
      content: Text('Benar ingin menghapus catatan ini?'),
      actions: <Widget>[
        FlatButton(
          child: Text('Ya', style: TextStyle(color: Colors.red[300])),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        FlatButton(
          child: Text('Tidak', style: TextStyle(color: Colors.green[300])),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        )
      ],
    );
  }
}