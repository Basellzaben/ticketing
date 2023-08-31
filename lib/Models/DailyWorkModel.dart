class DailyWorkModel {
  String? TransDate;
  String? TicketId;
  String? WorkTime;
  String? Descr;

  String? ustnameE;
  String? ustnameA;

  DailyWorkModel(
      {
        this.TransDate,
        this.TicketId,
        this.WorkTime,
        this.Descr,
        this.ustnameE,
        this.ustnameA
      });

  DailyWorkModel.fromJson(Map<String, dynamic> json) {
    TransDate = json['transDate'];
    TicketId = json['ticketId'];
    WorkTime = json['workTime'];
    Descr = json['descr'];

    ustnameE = json['ustnameE'];
    ustnameA = json['ustnameA'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transDate'] = this.TransDate;
    data['ticketId'] = this.TicketId;
    data['workTime'] = this.WorkTime;
    data['descr'] = this.Descr;

    data['ustnameE'] = this.ustnameE;
    data['ustnameA'] = this.ustnameA;
    return data;
  }
}