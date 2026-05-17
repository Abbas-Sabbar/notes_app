// import 'package:flutter/material.dart';
// import 'package:notes_app/features/data/model/notes_model.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DatabaseHelper {
//   static Database? database;
//
//   static void getDatabase() async {
//     openDatabase(
//       'notes.db',
//       version: 1,
//       onCreate: (db, version) {
//         debugPrint('Database created');
//         debugPrint('Database $version');
//         database = db;
//       },
//       onOpen: (db) {
//         debugPrint('database opened');
//          database = db;
//         createTable();
//         fatchaDatabase();
//       },
//     );
//   }
//
//   static void createTable() async {
//     if (database != null) {
//       await database!.execute(
//         'CREATE TABLE IF NOT EXISTS notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)',
//       );
//       debugPrint('Table created');
//     } else {
//       debugPrint('Database is not initialized');
//     }
//   }
//
//   static TextEditingController titleController = TextEditingController();
//
//   static void insertDatabase() async {
//     if (database != null) {
//       NotesModel note = NotesModel(
//         title: titleController.text,
//         createdAt: DateTime.now(),
//       );
//       int result = await database!.insert('notes', note.toMap());
//       debugPrint('New  record inserted with ID $result');
//       fatchaDatabase();
//     } else {
//       debugPrint('Database not initialized');
//     }
//   }
//
//   static List<NotesModel> notes = [];
//
//   static void fatchaDatabase() async {
//     if (database != null) {
//       notes.clear();
//       List<Map<String, dynamic>> rawUsers = await database!.query('notes');
//       for (var notesMap in rawUsers) {
//         NotesModel note = NotesModel.fromMap(notesMap);
//         notes.add(note);
//       }
//
//       notes = notes.reversed.toList();
//       debugPrint('Fetched ${rawUsers.length} users from the database');
//       debugPrint('Fetched ${notes.length} users from the database');
//       debugPrint(rawUsers.toString());
//     } else {
//       debugPrint('Database not initialized');
//     }
//   }
//
//  }
//
//
