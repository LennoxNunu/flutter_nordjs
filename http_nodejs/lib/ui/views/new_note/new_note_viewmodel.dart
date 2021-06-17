import 'package:http_nodejs/models/note_capturing.dart';
import 'package:http_nodejs/services/api.dart';
import 'package:http_nodejs/ui/widgets/form_model/form_model.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http_nodejs/app/app.router.dart';
import 'package:http_nodejs/app/app.locator.dart';
import 'package:http_nodejs/ui/views/new_note/new_note_view.form.dart';

class NewNoteViewModel extends AuthenticationForm {
  final _navigationService = locator<NavigationService>();
  final _api = locator<Api>();
  String errorText = ''; //TODO add error text

  // navigate to the HomePage Screen
  dynamic openHomePageViewBack({String giventoken, String userEmail}) {
    _navigationService.navigateTo(Routes.homePageView,
        arguments:
            HomePageViewArguments(userEmail: userEmail, token: giventoken));
  }

  // navigate to the HomePage Screen
  dynamic openHomePageViewAdd({String giventoken, String userEmail}) {
    runBusyFuture(addNote(giventoken: giventoken, userEmail: userEmail));
  }

  // navigate to the HomePage Screen
  dynamic openHomePageViewEdit(
      {String giventoken, String userEmail, int userId}) {
    // sets the model to busy while updating the note
    runBusyFuture(updateNote(
        giventoken: giventoken, userEmail: userEmail, userId: userId));
  }

  // connect to the api before navigating
  Future addNote({String giventoken, String userEmail}) async {
    NoteCapturingModel _noteCapturingModel =
        NoteCapturingModel(title: titleValue, description: descriptionValue);

    errorText = 'There is no internet connection';
    notifyListeners();

    // http post
    var response = await _api.postNote(body: _noteCapturingModel);

    // checks if api created the new note
    if (response.isSent == true) {
      _navigationService.navigateTo(Routes.homePageView,
          arguments:
              HomePageViewArguments(userEmail: userEmail, token: giventoken));
    } else {
      // handles all failing cases
      if (response.message != null) {
        errorText = response.message;
        notifyListeners();
      } else {
        if (response.error != null) {
          errorText = response.error;
          notifyListeners();
        } else {
          errorText = 'Note failed to upload.';
          notifyListeners();
        }
      }
    }
  }

  // connects to the api before navigating
  Future updateNote({String giventoken, String userEmail, int userId}) async {
    errorText = 'There is no internet connection';
    notifyListeners();

    NoteCapturingModel _noteCapturingModel = NoteCapturingModel(
        id: userId, description: descriptionValue, title: titleValue);

    var response = await _api.patchNote(body: _noteCapturingModel);
    //checks if  note was updated by api
    if (response.isSent == true) {
      _navigationService.navigateTo(Routes.homePageView,
          arguments:
              HomePageViewArguments(userEmail: userEmail, token: giventoken));
    } else {
      // handles all failed cases from api
      if (response.message != null) {
        errorText = response.message;
        notifyListeners();
      } else {
        if (response.error != null) {
          errorText = response.error;
          notifyListeners();
        } else {
          errorText = 'Note failed to edit and upload.';
          notifyListeners();
        }
      }
    }
  }
}
