import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class CourseDetail extends StatefulWidget {
  CourseDetail(this.url);
  final String url;

  @override
  CourseDetailState createState() => CourseDetailState();
}

class CourseDetailState extends State<CourseDetail> {
  bool isLoading = true;

  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          title: Text('Udemy', style: TextStyle(fontWeight: FontWeight.w700)),
          centerTitle: true),
      body: Stack(children: [
        WebView(
          initialUrl: widget.url,
          onPageStarted: (started) {
            setState(() {
              isLoading = false;
            });
          },
        ),
        isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(),
      ]),
    );
  }
}
