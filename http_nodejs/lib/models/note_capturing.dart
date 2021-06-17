class NoteCapturingModel {
  int id;
  String title;
  String description;
  String userEmail;
  String token;
  NoteCapturingModel(
      {this.title, this.description, this.id, this.userEmail, this.token});

  NoteCapturingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    userEmail = json['userEmail'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['userEmail'] = this.userEmail;
    data['token'] = this.token;
    return data;
  }
}
