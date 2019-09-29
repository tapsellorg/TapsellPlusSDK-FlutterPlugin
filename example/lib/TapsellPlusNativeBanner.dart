class TapsellPlusNativeBanner {
  String adId;
  String callToActionText;
  String description;
  bool error;
  String iconUrl;
  String landscapeStaticImageUrl;
  String portraitStaticImageUrl;
  String title;
  String zoneId;

  TapsellPlusNativeBanner(
      {this.adId,
      this.callToActionText,
      this.description,
      this.error,
      this.iconUrl,
      this.landscapeStaticImageUrl,
      this.portraitStaticImageUrl,
      this.title,
      this.zoneId});

  factory TapsellPlusNativeBanner.fromJson(Map<String, dynamic> json) {
    return TapsellPlusNativeBanner(
      adId: json['adId'],
      callToActionText: json['callToActionText'],
      description: json['description'],
      error: json['error'],
      iconUrl: json['iconUrl'],
      landscapeStaticImageUrl: json['landscapeStaticImageUrl'],
      portraitStaticImageUrl: json['portraitStaticImageUrl'],
      title: json['title'],
      zoneId: json['zoneId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adId'] = this.adId;
    data['callToActionText'] = this.callToActionText;
    data['description'] = this.description;
    data['error'] = this.error;
    data['iconUrl'] = this.iconUrl;
    data['landscapeStaticImageUrl'] = this.landscapeStaticImageUrl;
    data['portraitStaticImageUrl'] = this.portraitStaticImageUrl;
    data['title'] = this.title;
    data['zoneId'] = this.zoneId;
    return data;
  }
}
