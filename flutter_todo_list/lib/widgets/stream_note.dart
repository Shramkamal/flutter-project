// stream_note.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_list/widgets/task_widgets.dart';
import '../data/firestor.dart';

class Stream_note extends StatelessWidget {
  final bool done;
  Stream_note(this.done, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore_Datasource().stream(done),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final noteslist = Firestore_Datasource().getNotes(snapshot);

        return ListView.builder(
          shrinkWrap: true,
          itemCount: noteslist.length,
          itemBuilder: (context, index) {
            final note = noteslist[index];
            DateTime noteDate = note.timestamp;
            DateTime now = DateTime.now();
            bool isOlderThan24Hours = now.difference(noteDate).inHours >= 24;

            return Dismissible(
              key: UniqueKey(),
              background: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20),
                color: Colors.red,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 36,
                ),
              ),
              secondaryBackground: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                color: Colors.red,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 36,
                ),
              ),
              onDismissed: (direction) {
                Firestore_Datasource().delet_note(note.id);
              },
              child: Task_Widget(
                note,
                isOld: isOlderThan24Hours, 
              ),
            );
          },
        );
      },
    );
  }
}
