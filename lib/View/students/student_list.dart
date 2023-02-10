import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_test/Controller/home/home_bloc.dart';
import 'package:mock_test/Core/constants.dart';
import 'package:mock_test/Model/student_model/student_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ScreenStudents extends StatelessWidget {
  const ScreenStudents({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => BlocProvider.of<HomeBloc>(context).add(GetAllStudents()));
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'All Students',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Expanded(
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: themeColor,
                          strokeWidth: 2,
                        ),
                      );
                    } else if (state.students.isEmpty) {
                      return const Center(
                        child: Text(
                          'No Students found',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: themeColor,
                          ),
                        ),
                      );
                    }
                    return ListView.separated(
                      itemBuilder: (context, index) => StudentCard(
                        key: Key(state.students[index].name),
                        student: state.students[index],
                        favStudent: state.favStudents,
                      ),
                      separatorBuilder: (context, index) => kHeight10,
                      itemCount: state.students.length,
                    );
                  },
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class StudentCard extends StatelessWidget {
  const StudentCard({
    super.key,
    required this.student,
    required this.favStudent,
  });
  final StudentModel student;
  final List<StudentModel> favStudent;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: themeColor,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            kWidth10,
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/noimage.png',
                    ),
                  )),
            ),
            kWidth10,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      kHeight10,
                      Text(
                        student.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(student.qualification),
                      kHeight10,
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<HomeBloc>(context)
                          .add(AddToFav(student.id));
                    },
                    icon: BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        return Icon(
                          favStudent.contains(student)
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: Colors.red,
                          size: 30,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
