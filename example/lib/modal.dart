import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tapsell_plus/tapsell_plus.dart';

class NativeAdWidget extends StatelessWidget {
  final String responseId;
  final String title;
  final String description;
  final String callToAction;
  final String iconUrl;
  final String portraitImageUrl;
  final String landScapeImageUrl;
  final Function? onClick;

  NativeAdWidget(
      {required this.responseId,
      required this.title,
      required this.description,
      required this.callToAction,
      required this.iconUrl,
      required this.portraitImageUrl,
      required this.landScapeImageUrl,
      this.onClick});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(title),
                    Text(description),
                  ],
                ),
                IconButton(
                  iconSize: 56,
                  onPressed: () {},
                  icon: Image.network(
                    iconUrl,
                    width: 56,
                    height: 56,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Image.network(portraitImageUrl)
          ),
          SizedBox(height: 15,),
          Expanded(
            flex: 1,
            child: ElevatedButton(
                onPressed: () {
                  TapsellPlus.instance.nativeBannerAdClicked(responseId);
                  onClick?.call();
                },
                child: Text(callToAction),
            ),
          )
        ],
      ),
    ));
  }
}
