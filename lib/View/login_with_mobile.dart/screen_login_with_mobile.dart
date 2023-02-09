import 'package:flutter/material.dart';
import 'package:mock_test/Core/constants.dart';
import 'package:mock_test/View/default_auth_title.dart';
import 'package:mock_test/View/sign_up/screen_sign_up.dart';
import 'package:pinput/pinput.dart';

class ScreenLoginOTP extends StatelessWidget {
  const ScreenLoginOTP({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey mobileKey = GlobalKey<FormState>();
    final GlobalKey otpKey = GlobalKey<FormState>();
    final TextEditingController mobile = TextEditingController();
    final TextEditingController otp = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
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
                  title: "Log in with mobile",
                  subTitle:
                      "Please enter your mobile number and\nwe will send you an OTP to verify",
                ),
                SizedBox(
                  height: 50,
                ),
                MobileInput(mobileKey: mobileKey, mobile: mobile),
                kHeight10,
                ConfirmButton(formKey: mobile, mobile: mobile),
                kHeight10,
                const DefaultAuthtTitle(title: "Enter the OTP", subTitle: ""),
                OTPInput(formKey: otpKey, controller: otp),
                kHeight10,
                LogIn(formKey: otp),
                SizedBox(
                  height: 50,
                ),
                const SingUpWidget(),
              ],
            ),
          ),
        ),
        // const DefaultBackButton(),
      ]),
    );
  }
}

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({
    Key? key,
    required this.formKey,
    required this.mobile,
  }) : super(key: key);
  final formKey;
  final TextEditingController mobile;

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
              print('Validate');
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

class LogIn extends StatelessWidget {
  const LogIn({
    Key? key,
    required this.formKey,
  }) : super(key: key);
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
              print('Validate');
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

class OTPInput extends StatelessWidget {
  const OTPInput({
    Key? key,
    required this.formKey,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;
  final GlobalKey<State<StatefulWidget>> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Pinput(
        controller: controller,
        validator: (value) =>
            value == null || value.isEmpty || value.length != 6
                ? "Enter a valid OTP"
                : null,
        length: 6,
        defaultPinTheme: PinTheme(
          decoration: BoxDecoration(
              color: const Color.fromRGBO(222, 231, 240, .57),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: themeColor)),
          width: 56,
          height: 60,
          textStyle: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
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
                    color: Colors.teal,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class MobileInput extends StatelessWidget {
  const MobileInput({
    Key? key,
    required this.mobileKey,
    required this.mobile,
  }) : super(key: key);

  final GlobalKey<State<StatefulWidget>> mobileKey;
  final TextEditingController mobile;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: mobileKey,
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Mobile number cannot be empty";
          } else if (value.length != 12) {
            return "Enter a valid mobile number";
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.phone,
        // style: TextStyle(color: darkMode ? Colors.white : Colors.black),
        controller: mobile,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                // color: darkMode ? darkSubTitleColor : lightSubTitleColor,
                ),
          ),
          hintText: "Enter your Mobile number ",
          label: const Text("Mobile"),
          suffixIcon: const Icon(
            Icons.phone_android_rounded,
          ),
        ),
      ),
    );
  }
}
