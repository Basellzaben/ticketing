class AllusersModel {
  String? id;
  String? namea;
  String? namee;

  AllusersModel(
      {
        this.id,
        this.namea,
        this.namee,
        });

  AllusersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namea = json['namea'];
    namee = json['namee'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['namea'] = this.namea;
    data['namee'] = this.namee;
    return data;
  }
}