import 'package:employees_catalogue/data/component.dart';
import 'package:employees_catalogue/data/extensions.dart';
import 'package:employees_catalogue/data/person.dart';
import 'package:employees_catalogue/person_details_page.dart';
import 'package:employees_catalogue/widget_keys.dart';
import 'package:employees_catalogue/widgets/leading_widget.dart';
import 'package:employees_catalogue/widgets/person_item_widget.dart';
import 'package:flutter/material.dart';

class PeopleListPage extends StatefulWidget {
  final String title;

  const PeopleListPage({Key? key, required this.title}) : super(key: key);

  @override
  _PeopleListPageState createState() => _PeopleListPageState();
}

class _PeopleListPageState extends State<PeopleListPage> {
  late List<Person> people;
  List<Person>? searched;
  late TextEditingController _searchController;
  bool _isSearching = false;
  Responsibility? responsibilityFilter;
  String previousQuery = '';

  @override
  void initState() {
    _searchController = TextEditingController();
    people = Component.instance.api.searchPeople();
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: LeadingWidget(
            isSearching: _isSearching,
            onClick: () {
              _isSearching = !_isSearching;
              setState(() {});
            },
          ),
          title: _isSearching
              ? TextField(
                  key: WidgetKey.search,
                  controller: _searchController,
                  onChanged: (text) {
                    previousQuery = text;
                    searched = people
                        .where(
                            (element) => element.responsibility.toNameString().toLowerCase().contains(text))
                        .toList();
                    if (text.isEmpty) {
                      searched = null;
                    }
                    setState(() {});
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Search employee...",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white30),
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                )
              : Text(widget.title),
          actions: [
            responsibilityFilter != null
                ? InkWell(
                    key: WidgetKey.clearFilter,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('CLEAR'),
                    )),
                    onTap: () {
                      responsibilityFilter = null;
                      searched = null;
                      setState(() {});
                    },
                  )
                : PopupMenuButton<Responsibility>(
                    key: WidgetKey.filter,
                    icon: Icon(Icons.filter_list),
                    onSelected: (responsibility) {
                      responsibilityFilter = responsibility;
                      searched = people
                          .where((element) =>
                              element.responsibility.toNameString() == responsibility.toNameString())
                          .toList();
                      setState(() {});
                    },
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuItem<Responsibility>>[
                        ...Responsibility.values
                            .map(
                              (Responsibility e) =>
                                  PopupMenuItem<Responsibility>(child: Text(e.toNameString()), value: e),
                            )
                            .toList()
                      ];
                    },
                  )
          ],
        ),
        body: buildListView());
  }

  void filterByResponsibility({String? responsibility}) {
    people.sort((a, b) => (a.responsibility.toNameString()).compareTo(b.responsibility.toNameString()));
    searched?.sort(
        (a, b) => a.responsibility.toNameString().toString().compareTo(b.responsibility.toNameString()));
  }

  Widget buildListView() {
    final currentList = searched ?? people;
    return ListView.builder(
      key: WidgetKey.listOfPeople,
      itemBuilder: (context, index) {
        final person = currentList[index];
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PersonDetailsPage(personId: person.id),
            ));
          },
          child: PersonItemWidget(
            id: person.id,
            fullName: person.fullName,
            responsibility: person.responsibility.toNameString(),
          ),
        );
      },
      itemCount: currentList.length,
    );
  }
}
