part of 'bottom_navigation_bloc.dart';

class BottomNavigationState {
  final int index;
  BottomNavigationState({required this.index});
}

class BottomNavigationInitial extends BottomNavigationState {
  BottomNavigationInitial() : super(index: 0);
}
