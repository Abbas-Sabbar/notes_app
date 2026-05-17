import 'package:flutter/material.dart';
import 'package:notes_app/core/util/cubit/home_cubit.dart';
import 'package:notes_app/core/util/extensions/context_extension.dart';
import 'package:notes_app/features/data/model/notes_model.dart';

class AddNoteWidget extends StatefulWidget {
  final NotesModel? note;

  const AddNoteWidget({
    super.key,
    this.note,
  });

  @override
  State<AddNoteWidget> createState() => _AddNoteWidgetState();
}

class _AddNoteWidgetState extends State<AddNoteWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.cyan.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextFormField(
          maxLines: null,
          expands: true,
          initialValue: homeCubit.titleController.text,
          onChanged: (value) {
            homeCubit.titleController.text = value;
          },
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 45,
        width: 45,
        child: FloatingActionButton(
          onPressed: () async {
            homeCubit.openDatabaseForTheFirstTime();

            if (homeCubit.titleController.text.trim().isNotEmpty) {
              homeCubit.insertDatabase();
            }
            homeCubit.titleController.clear();

            context.pop();
          },
          backgroundColor: Colors.cyan.shade200,
          elevation: 3,
          heroTag: 'done_note',
          child: const Icon(Icons.check, color: Colors.black, size: 24),
        ),
      ),
    );
  }
}
