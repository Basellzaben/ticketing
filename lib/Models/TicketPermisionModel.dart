class TicketPermisionModel {
  String? openn;
  String? assign;

  String? showAllDaily;
  String? showAllTicket;

  TicketPermisionModel(
      {
        this.openn,
        this.assign,

        this.showAllDaily,
        this.showAllTicket,

        });

  TicketPermisionModel.fromJson(Map<String, dynamic> json) {

    openn = json['openn'];
    assign = json['assign'];

    showAllDaily = json['showAllDaily'];
    showAllTicket = json['showAllTicket'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['openn'] = this.openn.toString();
    data['assign'] = this.assign.toString();

    data['showAllDaily'] = this.showAllDaily.toString();
    data['showAllTicket'] = this.showAllTicket.toString();
    return data;
  }
}