import 'package:class_room/BLOC/bloc_provider.dart';
import 'package:class_room/BLOC/chapter_bloc.dart';
import 'package:class_room/models/chapters_list_model.dart';
import 'package:flutter/material.dart';

class ChapterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChapterBloc>(context)
        .fetchData('assets/json/chapters.json');
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              "Chapter Uploaded",
              style: TextStyle(
                  color: Color(0xfff22215b),
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic),
            ),
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
//              size: 20,
                  color: Color(0xfff22215b),
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          SizedBox(
            height: 20,
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
                    margin: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: Colors.grey)),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
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
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 11),
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
                itemCount: snapshot.data.length,
              );
            },
          ),
        ],
      ),
    );
  }
}
