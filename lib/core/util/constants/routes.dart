import 'package:flutter/material.dart';
import 'package:notes_app/features/home/presentation/widgets/add_note_widget.dart';
import 'package:notes_app/features/home/presentation/widgets/edit_note_widget.dart';
import 'package:notes_app/features/home/presentation/screen/home_screen.dart';

class Routes {
  static const String homeScreen = '/homeScreen';
  static const String addNoteWidget = '/addNoteWidget';
  static const String editNoteWidget = '/editNoteWidget';

  static Map<String, WidgetBuilder> get routes => {
        homeScreen: (context) => const HomeScreen(),
        addNoteWidget: (context) => const AddNoteWidget(),
        editNoteWidget: (context) => const EditNoteWidget(),
      };
}
