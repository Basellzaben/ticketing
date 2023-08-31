class chartModle {
  double? d;
  double? d1;
  double? d2;
  double? d3;
  double? d4;

  chartModle(
      {
        this.d,
        this.d1,
        this.d2,
        this.d3,
        this.d4
        });

  chartModle.fromJson(Map<String, dynamic> json) {
    d = json['d'];
    d1 = json['d1'];
    d2 = json['d2'];
    d3 = json['d3'];
    d4 = json['d4'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['d'] = this.d1;
    data['d1'] = this.d1;
    data['d2'] = this.d2;
    data['d3'] = this.d3;
    data['d4'] = this.d4;
    return data;
  }
}