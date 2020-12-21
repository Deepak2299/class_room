import 'dart:async';

import 'package:class_room/BLOC/assignment_bloc.dart';
import 'package:class_room/BLOC/bloc_provider.dart';
import 'package:class_room/BLOC/chapter_bloc.dart';
import 'package:class_room/models/assignment_list_model.dart';
import 'package:class_room/models/chapters_list_model.dart';
import 'package:class_room/screens/assignment_screen.dart';
import 'package:class_room/screens/card_decription.dart';
import 'package:class_room/screens/chapter_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  int bottomIndex = 0;

  int _numPages = 3;
  List<Color> colors = [
    Colors.blue,
    Colors.pink,
    Colors.deepOrange,
    Colors.yellow,
    Colors.lightGreenAccent,
  ];

  PageController pageController = PageController(initialPage: 0);

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  @override
  initState() {
    BlocProvider.of<ChapterBloc>(context)
        .fetchData('assets/json/chapters.json');
    BlocProvider.of<AssignmentBloc>(context)
        .fetchData('assets/json/assignment.json');
    super.initState();
    Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  Widget _indicator(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white12,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  Widget buildChapterUploaded() {
    return Column(
//      shrinkWrap: true,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "Chapters Uploaded",
              style: TextStyle(
                  color: Color(0xfff22215b),
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  alignment: Alignment.centerRight,
                  icon: Icon(
                    Icons.add,

//              size: 20,
                    color: Color(0xfff22215b),
                  ),
                  onPressed: null),
              IconButton(
                  alignment: Alignment.centerRight,
                  icon: Icon(
                    Icons.arrow_forward_ios,
//              size: 20,
                    color: Color(0xfff22215b),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChapterScreen()));
                  }),
            ],
          ),
        ),
        StreamBuilder<List<Chapter>>(
          stream: BlocProvider.of<ChapterBloc>(context).chapterStream,
          builder: (context, snapshot) {
            List<Chapter> chapters = snapshot.data;
            if (chapters == null) {
              return Text("NO Chapter");
            }
            if (chapters.isEmpty) {
              return Text("NO Chapter");
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  width: double.maxFinite,
//            height: 40,
                  margin: const EdgeInsets.all(3.0),
//            padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: Colors.grey)),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.picture_as_pdf),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Class ${chapters[index].chapterClass} | Chapter ${chapters[index].chapter} – ${chapters[index].name}",
                            style: TextStyle(fontSize: 13.5),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "PDF   *   Just Now   *  36.6KB",
                            style: TextStyle(color: Colors.grey, fontSize: 11),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                          alignment: Alignment.centerRight,
                          icon: Icon(
                            Icons.more_vert,
                            size: 20,
                          ),
                          onPressed: null),
                    ],
                  ),
                );
              },
              itemCount: snapshot.data.length < 2 ? snapshot.data.length : 2,
            );

//            return Text("NO Chapter");
          },
        ),
      ],
    );
  }

  Widget buildRecents() {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "Recents",
              style: TextStyle(
                  color: Color(0xfff22215b),
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  alignment: Alignment.centerRight,
                  icon: Icon(
                    Icons.add,
                    color: Color(0xfff22215b),
                  ),
                  onPressed: null),
              IconButton(
                  alignment: Alignment.centerRight,
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xfff22215b),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AssignmentScreen()));
                  }),
            ],
          ),
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
                itemCount: snapshot.data.length < 2 ? snapshot.data.length : 2,
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
                        color: colors[i].withOpacity(0.4),
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
                                fontWeight: FontWeight.w600, color: colors[i]),
                          ),
                          Spacer(),
                          Text(
                            assignments[i].date,
                            style: TextStyle(
                                color: colors[i], fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
      ],
    );
  }

  Widget buildAssignments() {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "Assignments and Notes",
              style: TextStyle(
                  color: Color(0xfff22215b),
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  alignment: Alignment.centerRight,
                  icon: Icon(
                    Icons.add,
//              size: 20,
                    color: Color(0xfff22215b),
                  ),
                  onPressed: null),
              IconButton(
                  alignment: Alignment.centerRight,
                  icon: Icon(
                    Icons.arrow_forward_ios,
//              size: 20,
                    color: Color(0xfff22215b),
                  ),
                  onPressed: null),
            ],
          ),
        ),
        GridView.builder(
            padding: EdgeInsets.all(4),
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
                childAspectRatio: 1.25),
            itemCount: 2,
            itemBuilder: (context, i) {
              return Container(
                height: 130,
                width: 165,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  color: colors[i + 2].withOpacity(0.4),
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
                          '5',
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w500,
                              color: colors[i + 2]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            'TH',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.5,
                                color: colors[i + 2]),
                          ),
                        ),
                        Spacer(),
                        IconButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: colors[i + 2],
                              size: 20,
                            ),
                            alignment: Alignment.topRight,
                            onPressed: null),
                      ],
                    ),
                    Text(
                      "History Assignment",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: colors[i + 2]),
                    ),
                    Spacer(),
                    Text(
                      "June 01 2020",
                      style: TextStyle(
                          color: colors[i + 2], fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }

  Widget buildSlider() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: PageView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Color(0xfff22215b)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          '5',
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
//
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          'TH',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 35,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("History Class",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Colors.white)),
                            Text("10:00 - 10:45",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.white)),
                            RaisedButton(
                              onPressed: () {},
                              color: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Text("Join Link",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.white)),
                            ),
                            Row(
                              children: _buildPageIndicator(),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Container(
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.pink),
                          child: Text(
                            "15:10",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          );
        },
        physics: ClampingScrollPhysics(),
        allowImplicitScrolling: true,
        scrollDirection: Axis.horizontal,
        itemCount: _numPages,
        controller: pageController,
        onPageChanged: (int pNo) {
          setState(() {
            _currentPage = pNo;
            _buildPageIndicator();
          });
        },
        pageSnapping: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: [
          ListTile(
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    alignment: Alignment.centerRight,
                    icon: Icon(Icons.video_call, color: Color(0xfff22215b)),
                    onPressed: null),
                IconButton(
                    alignment: Alignment.centerRight,
                    icon: Icon(
                      Icons.calendar_today,
                      color: Color(0xfff22215b),
                    ),
                    onPressed: null),
              ],
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xfff22215b),
                    ),
                    onPressed: null),
                CircleAvatar(
                  radius: 27,
                  backgroundImage: AssetImage("assets/images/dp.jpg"),
                ),
              ],
            ),
            enabled: true,
            contentPadding: EdgeInsets.zero,
          ),
          SizedBox(
            height: 20,
          ),
          buildSlider(),
          SizedBox(
            height: 20,
          ),
          buildChapterUploaded(),
          SizedBox(
            height: 20,
          ),
          buildRecents(),
          SizedBox(
            height: 20,
          ),
          buildAssignments(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedLabelStyle:
            TextStyle(color: Color(0xfff22215b), fontWeight: FontWeight.normal),
        selectedLabelStyle:
            TextStyle(color: Color(0xfff22215b), fontWeight: FontWeight.bold),
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            bottomIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                bottomIndex == 0 ? Icons.home : Icons.home_outlined,
                color: Color(0xfff22215b),
              ),
              title: Text(
                "Home",
                style: TextStyle(color: Color(0xfff22215b)),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                bottomIndex == 1
                    ? Icons.notifications
                    : Icons.notifications_outlined,
                color: Color(0xfff22215b),
              ),
              title: Text(
                "Notice",
                style: TextStyle(color: Color(0xfff22215b)),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                bottomIndex == 2 ? Icons.videocam : Icons.videocam_outlined,
                color: Color(0xfff22215b),
              ),
              title: Text(
                "Classes",
                style: TextStyle(color: Color(0xfff22215b)),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                bottomIndex == 3 ? Icons.message : Icons.message_outlined,
                color: Color(0xfff22215b),
              ),
              title: Text(
                "Chat",
                style: TextStyle(color: Color(0xfff22215b)),
              )),
        ],
      ),
    );
  }
}
