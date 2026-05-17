import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/util/cubit/home_cubit.dart';
import 'package:notes_app/core/util/cubit/home_states.dart';
import 'package:notes_app/core/util/extensions/context_extension.dart';
import 'package:notes_app/features/data/model/notes_model.dart';

class EditNoteWidget extends StatefulWidget {
  const EditNoteWidget({
    super.key,
  });

  @override
  State<EditNoteWidget> createState() => _EditNoteWidgetState();
}

class _EditNoteWidgetState extends State<EditNoteWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final note = ModalRoute.of(context)!.settings.arguments as NotesModel;
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current) => current is UpdateUserState,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.cyan.shade200,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              'تعديل ملاحظات',
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              maxLines: null,
              expands: true,
              initialValue: note.title,
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
              onPressed: () {
                homeCubit.updateDatabase(
                  id: note.id!,
                  title: homeCubit.titleController.text,
                );
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
      },
    );
  }
}
