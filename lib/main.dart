import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/util/constants/bloc_observer.dart';
import 'package:notes_app/core/util/constants/routes.dart';
import 'package:notes_app/core/util/cubit/home_cubit.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          HomeCubit()..openDatabaseForTheFirstTime(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Notes App',
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.homeScreen,
        routes: Routes.routes,
      ),
    );
  }
}
