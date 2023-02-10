import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_test/Controller/home/home_bloc.dart';
import 'package:mock_test/Core/constants.dart';
import 'package:mock_test/Model/student_model/student_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => BlocProvider.of<HomeBloc>(context).add(GetAllStudents()));
    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background.png'), fit: BoxFit.fill),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Welcome(),
              kHeight10,
              kHeight10,
              const Text(
                'Your Favorite Students',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              kHeight10,
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
                    } else if (state.favStudents.isEmpty) {
                      return const Center(
                        child: Text(
                          'No Fav Students found',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: themeColor),
                        ),
                      );
                    }
                    return ListView.separated(
                      itemBuilder: (context, index) =>
                          StudentCard(favStudent: state.favStudents[index]),
                      separatorBuilder: (context, index) => kHeight10,
                      itemCount: state.favStudents.length,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class StudentCard extends StatelessWidget {
  const StudentCard({
    super.key,
    required this.favStudent,
  });
  final StudentModel favStudent;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(
          color: themeColor,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      favStudent.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<HomeBloc>(context)
                            .add(AddToFav(favStudent.id));
                      },
                      icon: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          return Icon(
                            state.favStudents.contains(favStudent)
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
                Text(favStudent.qualification)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Welcome extends StatelessWidget {
  const Welcome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Welcome Back',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text(
          'Aravind',
          style: TextStyle(
              color: themeColor, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
