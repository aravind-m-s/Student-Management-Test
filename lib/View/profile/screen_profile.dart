import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_test/Controller/home/home_bloc.dart';
import 'package:mock_test/Core/constants.dart';
import 'package:mock_test/Model/student_model/student_model.dart';
import 'package:mock_test/View/login/screen_login.dart';
import 'package:mock_test/View/user_detials/screen_user_details.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background.png'), fit: BoxFit.fill),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 240,
                left: 32,
                right: 32,
              ),
              child: auth == null
                  ? const Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: ProfileButton(index: 4),
                    )
                  : ListView(
                      children: List.generate(
                          4, (index) => ProfileButton(index: index)),
                    ),
            ),
            const CurvedAppBar(),
            const ProfileImage(),
          ],
        ),
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    final List<String> titles = [
      "Edit Profile",
      "Terms and conditions",
      "Privacy Policy",
      "Logout",
      "Login"
    ];
    final List<IconData> icons = [
      Icons.person,
      Icons.edit_document,
      Icons.lock,
      Icons.logout,
      Icons.login,
    ];
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (index == 0) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ScreenUserDetails(),
              ));
              file = '';
            } else if (index == 3) {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ScreenLogin(),
              ));
            } else if (index == 4) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ScreenLogin(),
              ));
            }
          },
          child: Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: themeColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  icons[index],
                  color: themeColor,
                ),
                Text(
                  titles[index],
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: themeColor, fontSize: 20),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: themeColor,
                )
              ],
            ),
          ),
        ),
        kHeight10,
      ],
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    Key? key,
  }) : super(key: key);

  getImage(BuildContext context) async {
    final std = await FirebaseFirestore.instance.collection('users').get().then(
          (value) =>
              value.docs.map((e) => StudentModel.fromJson(e.data())).toList(),
        );
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final user = std.where((element) => element.id == uid).first;
    final response = await http.get(Uri.parse(user.file));
    final documentDirectory = await getApplicationDocumentsDirectory();
    final fle = File(join(documentDirectory.path, 'imagetest.png'));
    fle.writeAsBytesSync(response.bodyBytes);
    file = fle.path;
    BlocProvider.of<HomeBloc>(context).add(ChangeImage(file: file));
  }

  @override
  Widget build(BuildContext context) {
    getImage(context);
    return Positioned(
      top: 100,
      left: 0,
      right: 0,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (file == '') {
            return const CircleAvatar(
              backgroundColor: Colors.teal,
              radius: 75,
              backgroundImage: AssetImage('assets/noimage.png'),
            );
          }
          return CircleAvatar(
            backgroundColor: Colors.teal,
            radius: 75,
            backgroundImage: FileImage(File(file)),
          );
        },
      ),
    );
  }
}

class CurvedAppBar extends StatelessWidget {
  const CurvedAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomAppBar(),
      child: Container(
        height: 200,
        width: double.infinity,
        color: themeColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Icon(
                Icons.person,
                color: Colors.black,
                size: 50,
              ),
              Text(
                "Profile",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double xScaling = size.width / 360;
    final double yScaling = size.height / 141;
    path.lineTo(102.515 * xScaling, 120.478 * yScaling);
    path.cubicTo(
      223.94 * xScaling,
      66.9138 * yScaling,
      322.794 * xScaling,
      103.867 * yScaling,
      360.271 * xScaling,
      126.185 * yScaling,
    );
    path.cubicTo(
      360.271 * xScaling,
      126.185 * yScaling,
      360.271 * xScaling,
      0 * yScaling,
      360.271 * xScaling,
      0 * yScaling,
    );
    path.cubicTo(
      360.271 * xScaling,
      0 * yScaling,
      -0.0000305176 * xScaling,
      0 * yScaling,
      -0.0000305176 * xScaling,
      0 * yScaling,
    );
    path.cubicTo(
      -0.0000305176 * xScaling,
      0 * yScaling,
      0 * xScaling,
      138.819 * yScaling,
      0 * xScaling,
      138.819 * yScaling,
    );
    path.cubicTo(
      23.2431 * xScaling,
      143.967 * yScaling,
      56.3983 * xScaling,
      140.822 * yScaling,
      102.515 * xScaling,
      120.478 * yScaling,
    );
    path.cubicTo(
      102.515 * xScaling,
      120.478 * yScaling,
      102.515 * xScaling,
      120.478 * yScaling,
      102.515 * xScaling,
      120.478 * yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
