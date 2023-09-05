class TicketsModel {
  String? Id;
  String? TicketDate;
  String? custNameA;
  String? custNameE;
  String? IssueDescr;
  String? assignto;

  String? empname;

  TicketsModel(
      {
        this.Id,
        this.TicketDate,
        this.custNameA,
        this.custNameE,
        this.IssueDescr,
        this.assignto,
        this.empname
      });

  TicketsModel.fromJson(Map<String, dynamic> json) {
    Id = json['id'];
    TicketDate = json['ticketDate'];
    custNameA = json['custNameA'];
    custNameE = json['custNameE'];
    IssueDescr = json['issueDescr'];
    assignto = json['assignto'];
    empname = json['empname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.Id;
    data['ticketDate'] = this.TicketDate;
    data['custNameA'] = this.custNameA;
    data['custNameE'] = this.custNameE;
    data['issueDescr'] = this.IssueDescr;
    data['assignto'] = this.assignto;
    data['empname'] = this.empname;

    return data;
  }
}