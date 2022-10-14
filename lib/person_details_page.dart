import 'package:employees_catalogue/data/component.dart';
import 'package:employees_catalogue/data/person.dart';
import 'package:flutter/material.dart';

class PersonDetailsPage extends StatefulWidget {
  final int? personId;

  const PersonDetailsPage({Key? key, required this.personId}) : super(key: key);

  @override
  _PersonDetailsPageState createState() => _PersonDetailsPageState();
}

class _PersonDetailsPageState extends State<PersonDetailsPage> {
  Person? person;

  @override
  void initState() {
    if (widget.personId != null) {
      person = Component.instance.api.getPerson(widget.personId);
    } else {
      Navigator.of(context).pop();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Person details'), leading: CloseButton()),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Text("Name: ${person?.fullName ?? ''}"),
              SizedBox(height: 20),
              Text("Email: ${person?.email ?? ''}"),
              SizedBox(height: 20),
              Text("Phone: ${person?.phone ?? ''}"),
              SizedBox(height: 20),
              Text("Email: ${person?.email ?? ''}"),
              SizedBox(height: 20),
              Text("Id: ${person?.id ?? ''}"),
              SizedBox(height: 20),
              Text("Responsibility: ${person?.responsibility.name ?? ''}"),
            ],
          ),
        ));
  }
}
