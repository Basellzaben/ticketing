class DailyPermisionModel {
  String? addd;


  DailyPermisionModel(
      {
        this.addd,

        });

  DailyPermisionModel.fromJson(Map<String, dynamic> json) {
    addd = json['addd'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addd'] = this.addd;
    return data;
  }
}