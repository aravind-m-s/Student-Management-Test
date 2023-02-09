import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_test/Controller/BottomNavigation/bottom_navigation_bloc.dart';
import 'package:mock_test/View/bottom_navigation/bottom_navigation.dart';
import 'package:mock_test/View/home/screen_home.dart';
import 'package:mock_test/View/login/screen_login.dart';
import 'package:mock_test/View/sign_up/screen_sign_up.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomNavigationBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: BottomNavigation(),
      ),
    );
  }
}
