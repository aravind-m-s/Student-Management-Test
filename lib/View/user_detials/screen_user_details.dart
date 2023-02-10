import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mock_test/Controller/home/home_bloc.dart';
import 'package:mock_test/Core/constants.dart';
import 'package:mock_test/Model/student_model/student_model.dart';
import 'package:mock_test/View/bottom_navigation/bottom_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

String file = '';

class ScreenUserDetails extends StatelessWidget {
  const ScreenUserDetails({super.key, this.isEdit = true});
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    final TextEditingController name = TextEditingController();
    final TextEditingController email = TextEditingController();
    final TextEditingController phone = TextEditingController();
    final TextEditingController qualification = TextEditingController();
    final TextEditingController gender = TextEditingController();
    final GlobalKey formKey = GlobalKey<FormState>();
    if (isEdit) {
      getStudentData(name, email, phone, qualification, gender, context);
    }
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
              child: ListView(
                children: [
                  const ImageSection(),
                  kHeight10,
                  DetailsInput(
                      name: name,
                      email: email,
                      phone: phone,
                      gender: gender,
                      qualification: qualification,
                      formKey: formKey),
                  kHeight10,
                  SubmitButton(
                    gender: gender,
                    qualification: qualification,
                    formKey: formKey,
                    name: name,
                    email: email,
                    mobile: phone,
                    isEdit: isEdit,
                  )
                ],
              ),
            ),
          ),
          Positioned(
              top: 25,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ))
        ],
      ),
    );
  }

  getStudentData(
      TextEditingController name,
      TextEditingController email,
      TextEditingController phone,
      TextEditingController qualification,
      TextEditingController gender,
      BuildContext ctx) async {
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
    BlocProvider.of<HomeBloc>(ctx).add(ChangeImage(file: file));

    name.text = user.name;
    email.text = user.email;
    phone.text = user.mobile;
    qualification.text = user.qualification;
    gender.text = user.gender;
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await ImagePicker()
            .pickImage(source: ImageSource.gallery)
            .then((value) {
          file = value == null ? '' : value.path;
          BlocProvider.of<HomeBloc>(context).add(ChangeImage(file: file));
        });
      },
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
            radius: 60,
            backgroundColor: themeColor,
            backgroundImage: FileImage(File(file)),
          );
        },
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
    required this.formKey,
    required this.qualification,
    required this.gender,
  }) : super(key: key);
  final formKey;
  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController phone;
  final TextEditingController qualification;
  final TextEditingController gender;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
          InputFieldWidget(
            controller: qualification,
            label: "Qualification",
          ),
          kHeight10,
          InputFieldWidget(
            controller: gender,
            label: "Gender",
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
    required this.qualification,
    required this.gender,
    required this.isEdit,
  }) : super(key: key);
  final formKey;
  final TextEditingController email;
  final TextEditingController name;
  final TextEditingController mobile;
  final TextEditingController qualification;
  final TextEditingController gender;
  final bool isEdit;

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
            if (formKey.currentState!.validate()) {
              await editDetails(
                      name, email, mobile, gender, qualification, isEdit)
                  .then((value) => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BottomNavigation(),
                      )));
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

Future editDetails(
  TextEditingController name,
  TextEditingController email,
  TextEditingController mobile,
  TextEditingController gender,
  TextEditingController qualification,
  bool isEdit,
) async {
  if (isEdit) {
    final doc = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    final StudentModel student = StudentModel(
        file: file,
        id: FirebaseAuth.instance.currentUser!.uid,
        name: name.text.trim(),
        qualification: qualification.text.trim(),
        email: email.text.trim(),
        gender: gender.text.trim(),
        mobile: mobile.text.trim());
    if (file != '') {
      final path = email.text;
      final fle = File(file);
      final uploadPath =
          FirebaseStorage.instance.ref().child(path).putFile(fle);
      final snapshot = await uploadPath.whenComplete(() {});
      final url = await snapshot.ref.getDownloadURL();
      student.file = url;
    }
    await doc.update(student.toJson());
    final fb = FirebaseAuth.instance.currentUser!;
    fb.updateDisplayName(student.name);
    fb.updateEmail(student.email);
    fb.updatePhotoURL(file);
  } else {
    final StudentModel student = StudentModel(
        file: file,
        id: FirebaseAuth.instance.currentUser!.uid,
        name: name.text.trim(),
        qualification: qualification.text.trim(),
        email: email.text.trim(),
        gender: gender.text.trim(),
        mobile: mobile.text.trim());
    final fb = FirebaseAuth.instance.currentUser!;
    final db = FirebaseFirestore.instance.collection('users').doc(fb.uid);
    if (file != '') {
      final path = '$email';
      final fle = File(file);
      final uploadPath =
          FirebaseStorage.instance.ref().child(path).putFile(fle);
      final snapshot = await uploadPath.whenComplete(() {});
      final url = await snapshot.ref.getDownloadURL();
      student.file = url;
    }
    db.set(student.toJson());

    fb.updateDisplayName(student.name);
    fb.updateEmail(student.email);
    fb.updatePhotoURL(file);
  }
}

class InputFieldWidget extends StatelessWidget {
  const InputFieldWidget({
    Key? key,
    required this.controller,
    required this.label,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (controller.text.isEmpty) {
          return "Cannot be empty";
        } else {
          return null;
        }
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
                : label == "Name"
                    ? const Icon(Icons.person)
                    : label == "Qualification"
                        ? const Icon(Icons.book)
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
