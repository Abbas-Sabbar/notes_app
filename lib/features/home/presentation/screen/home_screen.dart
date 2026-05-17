import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/util/constants/routes.dart';
import 'package:notes_app/core/util/cubit/home_cubit.dart';
import 'package:notes_app/core/util/cubit/home_states.dart';
import 'package:notes_app/core/util/extensions/context_extension.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current) {
        return current is FetchUserState ||
            current is DeleteUserState ||
            current is UpdateUserState ||
            current is ChangeBottomNavBarState;
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.cyan.shade200,
            title: Text(
              homeCubit.titles[homeCubit.currentIndex],
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),

          ),
          body: homeCubit.pages[homeCubit.currentIndex],
          floatingActionButton: SizedBox(
            height: 45,
            width: 45,
            child: FloatingActionButton(
              backgroundColor: Colors.cyan.shade200,
              child: const Icon(Icons.edit_note_outlined, color: Colors.black),
              onPressed: () {
                context.push(
                  Routes.addNoteWidget,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
