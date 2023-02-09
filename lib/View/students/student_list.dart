import 'package:flutter/material.dart';
import 'package:mock_test/Core/constants.dart';

class ScreenStudents extends StatelessWidget {
  const ScreenStudents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'All Students',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => StudentCard(),
                separatorBuilder: (context, index) => kHeight10,
                itemCount: 10,
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class StudentCard extends StatelessWidget {
  const StudentCard({
    super.key,
  });

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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      kHeight10,
                      Text(
                        'Name of the ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text('Qualification of the '),
                      kHeight10,
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_outline,
                      color: Colors.red,
                      size: 30,
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
