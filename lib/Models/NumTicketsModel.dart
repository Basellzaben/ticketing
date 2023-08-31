class NumTicketsModel {
  int? closedTicket;
  int? openTicket;
  int? todayTicket;

  NumTicketsModel(
      {this.closedTicket,
        this.openTicket,
        this.todayTicket
        });

  NumTicketsModel.fromJson(Map<String, dynamic> json) {
    closedTicket = json['closedTicket'];
    openTicket = json['openTicket'];
    todayTicket = json['todayTicket'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['closedTicket'] = this.closedTicket;
    data['openTicket'] = this.openTicket;
    data['todayTicket'] = this.todayTicket;
    return data;
  }
}