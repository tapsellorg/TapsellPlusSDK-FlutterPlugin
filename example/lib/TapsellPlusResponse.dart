class TapsellPlusResponse {
  String responseType;
  String zoneId;

  TapsellPlusResponse({this.responseType, this.zoneId});

  factory TapsellPlusResponse.fromJson(Map<String, dynamic> json) {
    return TapsellPlusResponse(
      responseType: json['responseType'],
      zoneId: json['zoneId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseType'] = this.responseType;
    data['zoneId'] = this.zoneId;
    return data;
  }
}
