class systemsModel {
  String? id;
  String? namea;
  String? namee;

  systemsModel(
      {
        this.id,
        this.namea,
        this.namee,
        });

  systemsModel.fromJson(Map<String, dynamic> json) {
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