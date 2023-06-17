///
/// NativeAd util class, so the developer does not need to work with plain dictionary and instead typed class is ready
///
class NativeAdData {
  String? zoneId,
      responseId,
      adId,
      title,
      description,
      callToActionText,
      iconUrl,
      portraitImageUrl,
      landscapeImageUrl;

  NativeAdData(
      {this.zoneId,
      this.responseId,
      this.adId,
      this.title,
      this.description,
      this.callToActionText,
      this.iconUrl,
      this.portraitImageUrl,
      this.landscapeImageUrl});

  static NativeAdData fromMap(Map<String, String?> map) {
    return NativeAdData(
        zoneId: map['zone_id'],
        responseId: map['response_id'],
        adId: map['ad_id'],
        title: map['title'],
        description: map['description'],
        callToActionText: map['call_to_action_text'],
        iconUrl: map['icon_url'],
        portraitImageUrl: map['portrait_static_image_url'],
        landscapeImageUrl: map['landscape_static_image_url']);
  }

  Map<String, String> toMap() {
    Map<String, String> map = {};
    if (zoneId != null) map['zone_id'] = zoneId!;
    if (responseId != null) map['response_id'] = responseId!;
    if (adId != null) map['ad_id'] = adId!;
    if (title != null) map['title'] = title!;
    if (description != null) map['description'] = description!;
    if (callToActionText != null)
      map['call_to_action_text'] = callToActionText!;
    if (iconUrl != null) map['icon_url'] = iconUrl!;
    if (portraitImageUrl != null)
      map['portrait_static_image_url'] = portraitImageUrl!;
    if (landscapeImageUrl != null)
      map['landscape_static_image_url'] = landscapeImageUrl!;
    return map;
  }
}
