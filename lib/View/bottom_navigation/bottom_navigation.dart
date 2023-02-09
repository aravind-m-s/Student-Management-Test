import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_test/Controller/BottomNavigation/bottom_navigation_bloc.dart';
import 'package:mock_test/Core/constants.dart';
import 'package:mock_test/View/home/screen_home.dart';
import 'package:mock_test/View/profile/screen_profile.dart';
import 'package:mock_test/View/students/student_list.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const ScreenHome(),
      const ScreenStudents(),
      const ScreenProfile(),
    ];
    return Scaffold(
        body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        return pages[state.index];
      },
    ), bottomNavigationBar:
            BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          showUnselectedLabels: false,
          onTap: (value) => BlocProvider.of<BottomNavigationBloc>(context)
              .add(ChangeIndex(value)),
          currentIndex: state.index,
          elevation: 0,
          backgroundColor: themeColor.withOpacity(0.15),
          selectedItemColor: themeColor,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Students'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        );
      },
    ));
  }
}
