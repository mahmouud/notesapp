class NoteModel {
  int? notId;
  String? notTitel;
  String? notContact;
  String? notImage;
  int? notUser;

  NoteModel(
      {this.notId,
      this.notTitel,
      this.notContact,
      this.notImage,
      this.notUser});

  NoteModel.fromJson(Map<String, dynamic> json) {
    notId = json['not_id'];
    notTitel = json['not_titel'];
    notContact = json['not_contact'];
    notImage = json['not_image'];
    notUser = json['not_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['not_id'] = this.notId;
    data['not_titel'] = this.notTitel;
    data['not_contact'] = this.notContact;
    data['not_image'] = this.notImage;
    data['not_user'] = this.notUser;
    return data;
  }
}
