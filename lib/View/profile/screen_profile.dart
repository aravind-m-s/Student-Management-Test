import 'package:flutter/material.dart';
import 'package:mock_test/Core/constants.dart';
import 'package:mock_test/View/user_detials/screen_user_details.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
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
              child: ListView(
                children:
                    List.generate(4, (index) => ProfileButton(index: index)),
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
      "Logout"
    ];
    final List<IconData> icons = [
      Icons.person,
      Icons.edit_document,
      Icons.lock,
      Icons.logout,
    ];
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ScreenUserDetails(),
            ));
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

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      top: 100,
      left: 0,
      right: 0,
      child: CircleAvatar(
        backgroundColor: Colors.red,
        radius: 75,
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
            children: [
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
