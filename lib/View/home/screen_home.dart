import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mock_test/Core/constants.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: ListView.separated(
                  itemBuilder: (context, index) => const StudentCard(),
                  separatorBuilder: (context, index) => kHeight10,
                  itemCount: 10,
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
  });

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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Name of the Student',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_outline,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                Text('Qualification of the Student')
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
