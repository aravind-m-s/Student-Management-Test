part of 'bottom_navigation_bloc.dart';

@immutable
abstract class BottomNavigationEvent {}

class ChangeIndex extends BottomNavigationEvent {
  final int index;
  ChangeIndex(this.index);
}
