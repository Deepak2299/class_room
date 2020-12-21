import 'package:class_room/BLOC/assignment_bloc.dart';
import 'package:class_room/BLOC/bloc_provider.dart';
import 'package:class_room/models/assignment_list_model.dart';
import 'package:class_room/screens/card_decription.dart';
import 'package:flutter/material.dart';

class AssignmentScreen extends StatelessWidget {
  List<Color> colors = [
    Colors.blue,
    Colors.pink,
    Colors.deepOrange,
    Colors.yellow,
    Colors.lightGreenAccent,
  ];
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AssignmentBloc>(context)
        .fetchData('assets/json/assignment.json');
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              "Recents",
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
          StreamBuilder<List<Assignment>>(
            stream: BlocProvider.of<AssignmentBloc>(context).assignmentStream,
            builder: (context, snapshot) {
              List<Assignment> assignments = snapshot.data;
              if (assignments == null) {
                return Text("NO Assignment");
              }
              if (assignments.isEmpty) {
                return Text("NO Assignment");
              }
              return GridView.builder(
                  padding: EdgeInsets.all(4),
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 18,
                      mainAxisSpacing: 18,
                      childAspectRatio: 1.25),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CardDecription(
                                      assignment: assignments[i],
                                    )));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          color: colors[i % 5].withOpacity(0.4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  assignments[i].assignmentClass.toString(),
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w500,
                                      color: colors[i]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    'TH',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.5,
                                        color: colors[i]),
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                    icon: Icon(
                                      Icons.more_vert,
                                      size: 20,
                                      color: colors[i],
                                    ),
                                    alignment: Alignment.topRight,
                                    onPressed: null),
                              ],
                            ),
                            Text(
                              assignments[i].name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: colors[i]),
                            ),
                            Spacer(),
                            Text(
                              assignments[i].date,
                              style: TextStyle(
                                  color: colors[i],
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
