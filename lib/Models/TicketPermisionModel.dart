class TicketPermisionModel {
  String? openn;
  String? assign;


  TicketPermisionModel(
      {
        this.openn,
        this.assign,

        });

  TicketPermisionModel.fromJson(Map<String, dynamic> json) {

    openn = json['openn'];
    assign = json['assign'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['openn'] = this.openn.toString();
    data['assign'] = this.assign.toString();
    return data;
  }
}