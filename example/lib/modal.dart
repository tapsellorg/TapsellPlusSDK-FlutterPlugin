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
      margin: EdgeInsets.all(1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(title),
                  Text(description),
                ],
              ),
              IconButton(
                iconSize: 48,
                onPressed: () {},
                icon: Image.network(
                  iconUrl,
                  width: 48,
                  height: 48,
                ),
              )
            ],
          ),
          OrientationBuilder(builder: (context, orientation) {
            if (portraitImageUrl.isEmpty && orientation == Orientation.portrait)
              return SizedBox(width: 0, height: 0);
            if (landScapeImageUrl.isEmpty &&
                orientation == Orientation.landscape)
              return SizedBox(width: 0, height: 0);

            if (orientation == Orientation.portrait)
              return Image.network(portraitImageUrl,
                  width: MediaQuery.of(context).size.width - 100,
                  height: MediaQuery.of(context).size.height / 5 * 3);
            else
              return Image.network(landScapeImageUrl,
                  width: MediaQuery.of(context).size.width - 40,
                  height: MediaQuery.of(context).size.height / 5 * 3);
          }),
          ElevatedButton(
              onPressed: () {
                TapsellPlus.instance.nativeBannerAdClicked(responseId);
                onClick?.call();
              },
              child: Text(callToAction))
        ],
      ),
    ));
  }
}
