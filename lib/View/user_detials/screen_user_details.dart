import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mock_test/Core/constants.dart';

class ScreenUserDetails extends StatelessWidget {
  const ScreenUserDetails({super.key, this.isEdit = true});
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    final TextEditingController name = TextEditingController();
    final TextEditingController email = TextEditingController();
    final TextEditingController phone = TextEditingController();
    final GlobalKey formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: themeColor,
                  ),
                  kHeight10,
                  DetailsInput(name: name, email: email, phone: phone),
                  kHeight10,
                  SubmitButton(
                    formKey: formKey,
                    name: name,
                    email: email,
                    mobile: phone,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsInput extends StatelessWidget {
  const DetailsInput({
    Key? key,
    required this.name,
    required this.email,
    required this.phone,
  }) : super(key: key);

  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController phone;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          InputFieldWidget(
            controller: name,
            label: "Name",
          ),
          kHeight10,
          InputFieldWidget(
            controller: email,
            label: "Email",
          ),
          kHeight10,
          InputFieldWidget(
            controller: phone,
            label: "Mobile",
          ),
          kHeight10,
        ],
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.formKey,
    required this.name,
    required this.email,
    required this.mobile,
  }) : super(key: key);
  final formKey;
  final TextEditingController email;
  final TextEditingController name;
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
          onPressed: () async {
            // await editDetails(name, email, mobile);
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

// Future editDetails(
//   TextEditingController name,
//   TextEditingController email,
//   TextEditingController mobile,
// ) async {
//   final instance = FirebaseAuth.instance.currentUser!;
//   instance.updateDisplayName(name.text.trim());
//   instance.updateEmail(email.text.trim());
//   final users =
//       FirebaseFirestore.instance.collection('users').doc(instance.uid);
//   final data = UserModel(
//     name: name.text.trim(),
//     email: email.text.trim(),
//     id: instance.uid,
//   ).toJson();
//   users.set(data);
// }

class InputFieldWidget extends StatelessWidget {
  const InputFieldWidget({
    Key? key,
    required this.controller,
    required this.label,
    this.password,
  }) : super(key: key);

  final TextEditingController controller;
  final TextEditingController? password;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: themeColor,
          ),
        ),
        hintText: "Enter your $label",
        hintStyle: Theme.of(context).textTheme.bodySmall,
        label: Text(label),
        suffixIcon: label == "Email"
            ? const Icon(Icons.mail)
            : label == "Mobile"
                ? const Icon(Icons.phone_android_rounded)
                : const Icon(Icons.person),
      ),
      keyboardType: label == "Email"
          ? TextInputType.emailAddress
          : label == "Mobile"
              ? TextInputType.number
              : null,
    );
  }
}
