import 'package:flutter/material.dart';

class StandardBannerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Standard Banner'),
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                requestStandardBanner();
              },
              child: Text('Request And Show'),
            ),
          ],
        ),
      )),
    );
  }

  void requestStandardBanner() {

  }
}
