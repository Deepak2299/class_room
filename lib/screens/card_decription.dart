import 'package:class_room/models/assignment_list_model.dart';
import 'package:flutter/material.dart';

class CardDecription extends StatefulWidget {
  Assignment assignment;
  CardDecription({@required this.assignment});
  @override
  _CardDecriptionState createState() => _CardDecriptionState();
}

class _CardDecriptionState extends State<CardDecription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Details",
                style: TextStyle(
                    color: Color(0xfff22215b),
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic),
              ),
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xfff22215b),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Class " + widget.assignment.assignmentClass.toString(),
                    style: TextStyle(
                      color: Color(0xfff22215b),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Activity Name: " + widget.assignment.name,
                    style: TextStyle(
                      color: Color(0xfff22215b),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Date :" + widget.assignment.date,
                    style: TextStyle(
                      color: Color(0xfff22215b),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Information",
                    style: TextStyle(
                      color: Color(0xfff22215b),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    widget.assignment.information,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
