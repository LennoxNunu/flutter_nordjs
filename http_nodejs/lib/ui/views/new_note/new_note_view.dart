import 'package:flutter/material.dart';
import 'package:http_nodejs/ui/views/new_note/new_note_view.form.dart';
import 'package:http_nodejs/ui/views/new_note/new_note_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'new_note_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'title'),
  FormTextField(name: 'description'),
])
class NewNoteView extends StatelessWidget with $NewNoteView {
  final String token;
  final String email;
  final int noteId;
  final String title;
  final String description;
  final bool editingScreen;
  NewNoteView(
      {Key key,
      this.noteId,
      this.editingScreen,
      this.email,
      this.token,
      this.title,
      this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using the reactive constructor gives you the traditional viewmodel
    // binding which will excute the builder again when notifyListeners is called.
    return ViewModelBuilder<NewNoteViewModel>.reactive(
      onModelReady: (model) {
        titleController.text = this.title;
        descriptionController.text = this.description;
        return listenToFormUpdated(model);
      },
      viewModelBuilder: () => NewNoteViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          title: editingScreen
              ? Text(
                  "New Note",
                  style: TextStyle(fontSize: 25),
                )
              : Text(
                  "Edit Note",
                  style: TextStyle(fontSize: 25),
                ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => model.openHomePageViewBack(
                userEmail: this.email, giventoken: this.token),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                height: 30,
                color: Colors.blue,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    color: Colors.white),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.85,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Title",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.grey.withOpacity(0.2),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Title", border: InputBorder.none),
                          style: TextStyle(fontSize: 18),
                          controller: titleController,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Description",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 240,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      topLeft: Radius.circular(15)),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.5))),
                              child: TextField(
                                maxLines: 9,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Add description here",
                                ),
                                style: TextStyle(fontSize: 18),
                                controller: descriptionController,
                              ),
                            ),
                            model.errorText == ''
                                ? SizedBox(
                                    height: 20,
                                  )
                                : Text(
                                    model.errorText,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                            InkWell(
                              onTap: () {
                                if (editingScreen == null) {
                                  model.openHomePageViewAdd(
                                      userEmail: this.email,
                                      giventoken: this.token);
                                } else {
                                  model.openHomePageViewEdit(
                                      userId: this.noteId,
                                      userEmail: this.email,
                                      giventoken: this.token);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: Colors.blue),
                                child: Center(
                                  child: model.isBusy
                                      ? CircularProgressIndicator(
                                          backgroundColor: Colors.white,
                                        )
                                      : editingScreen
                                          ? Text(
                                              "Add Note",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            )
                                          : Text(
                                              "Save Changes",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
