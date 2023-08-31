class TicketsModel {
  String? Id;
  String? TicketDate;
  String? custNameA;
  String? custNameE;
  String? IssueDescr;

  TicketsModel(
      {
        this.Id,
        this.TicketDate,
        this.custNameA,
        this.custNameE,
        this.IssueDescr
      });

  TicketsModel.fromJson(Map<String, dynamic> json) {
    Id = json['id'];
    TicketDate = json['ticketDate'];
    custNameA = json['custNameA'];
    custNameE = json['custNameE'];
    IssueDescr = json['issueDescr'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.Id;
    data['ticketDate'] = this.TicketDate;
    data['custNameA'] = this.custNameA;
    data['custNameE'] = this.custNameE;
    data['issueDescr'] = this.IssueDescr;
    return data;
  }
}