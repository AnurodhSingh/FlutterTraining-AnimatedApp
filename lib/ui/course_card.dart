import 'package:animated_app/model/company.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'course_detail.dart';

class CourseCard extends StatelessWidget {
  CourseCard(this.course);

  final Course course;

  BoxDecoration _createShadowRoundCorners() {
    return BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: new BorderRadius.circular(12.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
              color: Colors.black26, spreadRadius: 2.0, blurRadius: 10.0)
        ]);
  }

  Widget _createThumbnail(BuildContext context) {
    return new ClipRRect(
      borderRadius: new BorderRadius.circular(8.0),
      child: Stack(
        children: <Widget>[
          Image.asset(course.thumbnail),
          new Positioned(
              bottom: 12.0, right: 12.0, child: _createLinkButton(context))
        ],
      ),
    );
  }

  Widget _createLinkButton(BuildContext context) {
    return new Hero(
        tag: course.title,
        child: Material(
          color: Colors.white24,
          type: MaterialType.circle,
          child: IconButton(
            icon: Icon(Icons.link),
            onPressed: () async {
              if (await canLaunch(course.url)) {
                Navigator.push(
                  context,
                  // For default screen transition
                  
                  // MaterialPageRoute(
                  //     builder: (context) => CourseDetail(course.url)),
                  
                  // For custom screen transition
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => CourseDetail(course.url),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      var begin = Offset(1.0, 0.0);
                      var end = Offset.zero;
                      var tween = Tween(begin: begin, end: end);
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  )
                );
              }
            },
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 175.0,
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      decoration: _createShadowRoundCorners(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(flex: 3, child: _createThumbnail(context)),
          Flexible(
            flex: 2,
            child: _createCourseInfo(),
          )
        ],
      ),
    );
  }

  Widget _createCourseInfo() {
    return new Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 4.0, right: 4.0),
        child: Text(
          course.title,
          style: TextStyle(color: Colors.white.withOpacity(0.85)),
        ));
  }
}
