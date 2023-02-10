part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetAllStudents extends HomeEvent {}

class ChangeImage extends HomeEvent {
  String file;
  ChangeImage({required this.file});
}

class AddToFav extends HomeEvent {
  String id;
  AddToFav(this.id);
}
