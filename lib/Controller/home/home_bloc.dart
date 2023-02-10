import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mock_test/Model/student_model/student_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetAllStudents>(
      (event, emit) async {
        emit(HomeState(
            students: state.students,
            isLoading: true,
            favStudents: state.students));
        final database = await openDatabase('favorite.db', version: 1,
            onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE favorite (id TEXT PRIMARY KEY)');
        });
        final datas = await database.rawQuery('SELECT * FROM favorite');
        final filter = datas
            .map(
              (e) => e['id'],
            )
            .toList();
        final std =
            await FirebaseFirestore.instance.collection('users').get().then(
                  (value) => value.docs
                      .map((e) => StudentModel.fromJson(e.data()))
                      .toList(),
                );
        final fav =
            std.where((element) => filter.contains(element.id)).toList();

        emit(HomeState(students: std, isLoading: false, favStudents: fav));
      },
    );
    on<ChangeImage>((event, emit) {
      emit(HomeState(
          students: state.students,
          favStudents: state.favStudents,
          file: event.file));
    });
    on<AddToFav>((event, emit) async {
      final database = await openDatabase('favorite.db', version: 1,
          onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE favorite (id TEXT PRIMARY KEY)');
      });
      final id =
          state.favStudents.where((element) => element.id == event.id).toList();
      final student =
          state.students.where((element) => element.id == event.id).toList();
      List<StudentModel> fav = state.favStudents;
      try {
        if (id.isEmpty) {
          await database
              .rawQuery('INSERT INTO favorite(id) values ("${event.id}")');
          fav.add(student[0]);
        } else {
          await database
              .rawQuery('DELETE FROM favorite WHERE id = "${event.id}"');
          fav.remove(student[0]);
        }
        emit(HomeState(
            students: state.students, favStudents: fav, isFav: event.id));
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
