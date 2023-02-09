import 'package:flutter/material.dart';

class DefaultAuthtTitle extends StatelessWidget {
  const DefaultAuthtTitle(
      {Key? key, required this.title, required this.subTitle})
      : super(key: key);
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
