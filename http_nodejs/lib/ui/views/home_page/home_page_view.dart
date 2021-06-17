import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http_nodejs/ui/views/home_page/home_page_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomePageView extends StatelessWidget {
  final String userEmail;
  final String token;

  HomePageView({Key key, this.userEmail, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomePageViewModel>.reactive(
      viewModelBuilder: () => HomePageViewModel(),
      onModelReady: (model) =>
          model.notes(token: this.token, userEmail: this.userEmail),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Container(
                child: model.isBusy
                    ? Padding(
                        padding: EdgeInsets.all(12),
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      )
                    : IconButton(
                        icon: Icon(Icons.cast_connected),
                        onPressed: () {
                          model.openOnboardingView();
                        }))
          ],
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue,
          elevation: 0,
          title: Text(
            "My Notes",
            style: TextStyle(fontSize: 30),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //  mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: Container(
              color: Colors.lightBlueAccent,
              child: model.isNoteAvailable
                  ? ListView(
                      children: <Widget>[
                        Container(
                          child: Text(
                            model.noNotes,
                            style: TextStyle(fontSize: 18),
                          ),
                          padding: EdgeInsets.all(16),
                        ),
                        Container(
                          child: Text(model.addNotes,
                              style: TextStyle(fontSize: 18)),
                          padding: EdgeInsets.all(20),
                        )
                      ],
                    )
                  : ListView.builder(
                      itemCount: model.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.3,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.03),
                                      offset: Offset(0, 9),
                                      blurRadius: 20,
                                      spreadRadius: 1)
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 80),
                                  child: Text(
                                    model.data[index].title,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 26),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    model.data[index].description,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 18),
                                  ),
                                )
                              ],
                            ),
                          ),
                          secondaryActions: [
                            IconSlideAction(
                              caption: "Edit",
                              color: Colors.white,
                              icon: Icons.edit,
                              onTap: () => model.openNewNoteViewEdit(
                                  noteId: model.data[index].id,
                                  email: this.userEmail,
                                  description: model.data[index].description,
                                  title: model.data[index].title,
                                  token: this.token),
                            ),
                            IconSlideAction(
                              caption: "Delete",
                              color: Colors.red,
                              icon: Icons.edit,
                              onTap: () => model.deletingNote(
                                email: this.userEmail,
                                  noteId: model.data[index].id,
                                  token: this.token),
                            )
                          ],
                        );
                      },
                    ),
            )),
            Container(
              color: Colors.lightBlueAccent,
              height: 110,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 90,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black.withOpacity(0.8),
                      //  padding: EdgeInsets.all(20),
                    ),
                  ),
                  Positioned(
                    bottom: 25,
                    left: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () =>
                          model.openNewNoteViewAdd(email: this.userEmail),
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [Color(0xfff96060), Colors.orange],
                            ),
                            shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            "+",
                            style: TextStyle(fontSize: 40, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
