import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/util/constants/constants.dart';
import 'package:notes_app/core/util/cubit/home_states.dart';
import 'package:notes_app/features/data/model/notes_model.dart';
import 'package:notes_app/features/home/presentation/widgets/add_note_widget.dart';
import 'package:notes_app/features/home/presentation/widgets/edit_note_widget.dart';
import 'package:notes_app/features/home/presentation/widgets/home_widget.dart';
import 'package:notes_app/main.dart';
import 'package:sqflite/sqflite.dart';

HomeCubit homeCubit = HomeCubit.get(navigatorKey.currentContext!);

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  Database? database;
  final TextEditingController titleController = TextEditingController();

  List<Widget> pages = [
    const HomeWidget(),
    const AddNoteWidget(),
    const EditNoteWidget(),

  ];
  List<String> titles = [
    'ملاحظاتي',
    'تعديل ملاحظات',
    'My Cart',

  ];
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  void openDatabaseForTheFirstTime() async {
    openDatabase(
      'notes.db',
      version: 1,
      onCreate: (db, version) {
        debugPrint('Database created');
        debugPrint('Database $version');
        database = db;
      },
      onOpen: (db) {
        debugPrint('Database opened');
        database = db;
        createTable();
        fetchDataFromUsers();
        //emit(OpenDatabaseState());
      },
    );
  }

  void createTable() async {
    if (database != null) {
      await database!.execute(
        'CREATE TABLE IF NOT EXISTS $notesTable (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)',
      );
      debugPrint('Table created');
    } else {
      debugPrint('Database is not initialized');
    }
  }

  void insertDatabase() async {
    emit(DatabaseLoadingState());
    if (database != null) {
      NotesModel note = NotesModel(
        title: titleController.text,
        createdAt: DateTime.now(),
      );
      int result = await database!.insert(notesTable, note.toMap());
      debugPrint('New  record inserted with ID $result');
      emit(InsertUserState());
      fetchDataFromUsers();
    } else {
      debugPrint('Database is not initialized');
    }
  }

  //

  List<NotesModel> notes = [];

  void fetchDataFromUsers() async {
    emit(DatabaseLoadingState());
    if (database != null) {
      notes.clear();
      List<Map<String, dynamic>> rawUsers = await database!.query(notesTable);
      for (var notesLo in rawUsers) {
        NotesModel note = NotesModel.fromMap(notesLo);
        notes.add(note);
      }
      notes = notes.reversed.toList();
      emit(FetchUserState());
    } else {
      debugPrint('Database is not initialized');
    }
  }

  void deleteUser(int id) async {
    emit(DatabaseLoadingState());
    if (database != null) {
      database!.delete(notesTable, where: 'id = ?', whereArgs: [id]);
      fetchDataFromUsers();
      emit(DeleteUserState());
      debugPrint('User with ID $id deleted');
    } else {
      debugPrint('Database is not initialized');
    }
  }

  void updateDatabase({
    required int id,
    required String title,
  }) async {
    if (titleController.text.trim().isEmpty) return;
    notes.clear();
    if (database != null) {
      notes.clear();
      await database!.update(
        notesTable,
        {
          'title': title,
        },
        where: 'id = ?',
        whereArgs: [id],
      );

      emit(UpdateUserState());
      fetchDataFromUsers();
    }
  }



}
