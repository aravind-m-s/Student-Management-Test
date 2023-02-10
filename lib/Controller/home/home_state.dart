part of 'home_bloc.dart';

class HomeState {
  List<StudentModel> students;
  List<StudentModel> favStudents;
  bool isLoading;
  String file;
  String isFav;
  HomeState({
    required this.students,
    this.isLoading = false,
    required this.favStudents,
    this.file = '',
    this.isFav = '',
  });
}

class HomeInitial extends HomeState {
  HomeInitial() : super(students: [], isLoading: false, favStudents: []);
}
