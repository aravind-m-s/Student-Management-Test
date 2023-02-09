import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mock_test/Core/constants.dart';
import 'package:mock_test/View/default_auth_title.dart';
import 'package:mock_test/View/login_with_mobile.dart/screen_login_with_mobile.dart';
import 'package:mock_test/View/sign_up/screen_sign_up.dart';

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background.png'), fit: BoxFit.fill),
            ),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const DefaultAuthtTitle(
                      title: "Welcome Back",
                      subTitle:
                          "Sing in with your email and password or continue\nwith your Google account or Mobile"),
                  const SizedBox(
                    height: 50,
                  ),
                  InputForm(
                    email: email,
                    password: password,
                    formKey: formKey,
                  ),
                  kHeight10,
                  kHeight10,
                  LoginButtonWidget(
                    formKey: formKey,
                    email: email,
                    password: password,
                  ),
                  kHeight10,
                  const OtherSingInMethods(),
                  kHeight10,
                  const SingUpWidget(),
                ],
              ),
            ),
          ),
          // const DefaultBackButton(
          //   isBack: true,
          // )
        ],
      ),
    );
  }
}

class InputForm extends StatelessWidget {
  const InputForm({
    Key? key,
    required this.email,
    required this.password,
    required this.formKey,
  }) : super(key: key);

  final TextEditingController email;
  final TextEditingController password;
  final GlobalKey formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          inputField(email, "Email"),
          kHeight10,
          inputField(password, "Password")
        ],
      ),
    );
  }

  TextFormField inputField(TextEditingController controller, String label) {
    return TextFormField(
      validator: (value) {
        return validate(value, label);
      },
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: themeColor,
          ),
        ),
        hintText: "Enter your $label",
        label: Text(label),
        suffixIcon:
            label == "Email" ? const Icon(Icons.mail) : const Icon(Icons.lock),
      ),
      keyboardType: label == "Email" ? TextInputType.emailAddress : null,
      obscureText: label == "Email" ? false : true,
    );
  }
}

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({
    Key? key,
    required this.formKey,
    required this.email,
    required this.password,
  }) : super(key: key);
  final TextEditingController email;
  final TextEditingController password;
  final formKey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: themeColor),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              singIn(email, password, context);
            }
          },
          child: Text(
            'Continue',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

Future singIn(TextEditingController email, TextEditingController password,
    context) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        )
        .then(
          (value) => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ScreenLogin(),
            ),
          ),
        );
  } catch (e) {
    print(e);
  }
}

class OtherSingInMethods extends StatelessWidget {
  const OtherSingInMethods({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(
          width: 10,
        ),
        const CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage('assets/google.png'),
        ),
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.transparent,
          child: Image.asset('assets/facebook.png'),
        ),
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
          child: Image.asset('assets/mobile.png'),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}

class SingUpWidget extends StatelessWidget {
  const SingUpWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const ScreenSignUp(),
          ),
        );
      },
      child: Text.rich(
        TextSpan(
          text: "Don't have an account ? ",
          style: Theme.of(context).textTheme.bodySmall,
          children: [
            TextSpan(
              text: "SignUp",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: themeColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

String? validate(String? value, String label) {
  if (value == null || value.isEmpty) {
    return "$label cannot be empty";
  } else if (value.length < 6 && label == "Password") {
    return "Password should be more than 6 letters";
  } else if (label == "Email" &&
      !RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(value)) {
    return "Enter a valid email";
  }
  return null;
}
