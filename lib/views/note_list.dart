import 'package:flutter/material.dart';
import 'package:todonotes/models/note_for_listing.dart';
import 'package:todonotes/views/note_delete.dart';
import 'package:todonotes/views/note_modify.dart';

final notes = [
  new NoteForListing(
      noteID: "1",
      createDateTime: DateTime.now(),
      latestEditDateTime: DateTime.now(),
      noteTitle: "Note 1"
    ),
    new NoteForListing(
      noteID: "2",
      createDateTime: DateTime.now(),
      latestEditDateTime: DateTime.now(),
      noteTitle: "Note 2"
    ),
    new NoteForListing(
      noteID: "3",
      createDateTime: DateTime.now(),
      latestEditDateTime: DateTime.now(),
      noteTitle: "Note 3"
    ),
];

String formatDateTime(DateTime dateTime) {
  return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
}

class NoteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List CatatanKu")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // push like intent
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => NoteModify()
            )
          );
        },
        child: Icon(Icons.add),
      ),
      body: ListView.separated(
        separatorBuilder: (_, __) => Divider(height: 1, color: Colors.green),
        itemBuilder: (_, index) {
          return Dismissible( // swipe right for delete on list
            key: ValueKey(notes[index].noteID),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {},
            confirmDismiss: (direction) async {
              final result = await showDialog(
                context: context,
                builder: (_) => NoteDelete()
              );
              print(result);
              return result;
            }, 
            background: Container( // background delete
              color: Colors.red,
              padding: EdgeInsets.only(right: 16),
              child: Align(child: Icon(Icons.delete, color: Colors.white), alignment: Alignment.centerRight,)
            ),
            child: ListTile(
              title: Text(
                notes[index].noteTitle,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              subtitle: Text('Last edited on ${formatDateTime(notes[index].latestEditDateTime)}'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => NoteModify(noteID: notes[index].noteID))
                );
              },
            ),
          );
        },
        itemCount: notes.length,
      )
    );
  }
}