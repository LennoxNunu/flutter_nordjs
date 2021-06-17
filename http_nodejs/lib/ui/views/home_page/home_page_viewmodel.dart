import 'package:http_nodejs/models/note_capturing.dart';
import 'package:http_nodejs/services/api.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http_nodejs/app/app.router.dart';
import 'package:http_nodejs/app/app.locator.dart';

class HomePageViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _api = locator<Api>();
  bool isNoteAvailable = false;
  List<NoteCapturingModel> data = [];
  String noNotes = 'You have no notes in memory.';
  String addNotes = 'Add notes by clicking the plus icon.';
  String errorText;

  // navigate user to the NewNote Screen to allow editing of the note
  dynamic openNewNoteViewEdit(
      {int noteId,
      String email,
      String token,
      String description,
      String title}) {
    _navigationService.navigateTo(Routes.newNoteView,
        arguments: NewNoteViewArguments(
            noteId: noteId,
            email: email,
            editingScreen: false,
            token: token,
            description: description,
            title: title));
  }

  //navigate user to the NewNote Screen to allow for user to add note
  dynamic openNewNoteViewAdd({String email, String token}) {
    _navigationService.navigateTo(Routes.newNoteView,
        arguments: NewNoteViewArguments(
            email: email, editingScreen: true, token: token));
  }

  //navigate user to the Onboarding Screen
  dynamic openOnboardingView() {
    _navigationService.navigateTo(Routes.onboardingView);
  }

  // app receives a list of notes from api
  Future<List<NoteCapturingModel>> notes(
      {String userEmail, String token}) async {
    NoteCapturingModel _noteCapturingModel =
        NoteCapturingModel(token: token, userEmail: userEmail);

    errorText = 'There is no internet connection';
    notifyListeners();

    //http get
    var response = await _api.getNotes(body: _noteCapturingModel);
    if (response.isEmpty) {
      isNoteAvailable = true;
      notifyListeners();
    } else {
      isNoteAvailable = false;
      notifyListeners();
    }
    return data = response;
  }

  //delete the note from the api
  Future deletingNote({int noteId, String token, String email}) async {
    NoteCapturingModel _noteCapturingModel =
        NoteCapturingModel(id: noteId, token: token);
    var response = await _api.deleteNote(body: _noteCapturingModel);

    if (response.isSent == true) {
      //navigate to the HomePage Screen
      _navigationService.navigateTo(Routes.homePageView,
          arguments: HomePageViewArguments(userEmail: email, token: token));
    }
  }
}
