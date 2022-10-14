import 'package:flutter/material.dart';

class PersonItemWidget extends StatelessWidget {
  final int id;
  final String fullName;
  final String responsibility;

  const PersonItemWidget({Key? key, required this.id, required this.fullName, this.responsibility = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.green)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14),
        child: Column(
          children: [
            Text("Name: $fullName"),
            SizedBox(height: 8),
            Text("Responsibility: $responsibility"),
          ],
        ),
      ),
    );
  }
}
