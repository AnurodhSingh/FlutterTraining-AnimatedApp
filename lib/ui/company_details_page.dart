import 'dart:ui' as ui;

import 'package:animated_app/model/company.dart';
import 'package:animated_app/ui/company_details_intro_animation.dart';
import 'package:animated_app/ui/course_card.dart';
import 'package:flutter/material.dart';

class CompanyDetailsPage extends StatelessWidget {
  CompanyDetailsPage(
      {@required this.company, @required AnimationController controller})
      : animation = new CompanyDetsIntroAnimation(controller);

  final Company company;
  final CompanyDetsIntroAnimation animation;

  Widget _createAnimation(BuildContext context, Widget child) {
    return new Stack(fit: StackFit.expand, children: <Widget>[
      new Opacity(
          opacity: animation.bgdropOpacity.value,
          child: new Image.asset(
            company.backdropPhoto,
            fit: BoxFit.cover,
          )),
      new BackdropFilter(
        filter: new ui.ImageFilter.blur(
            sigmaX: animation.bgdropBlur.value,
            sigmaY: animation.bgdropBlur.value),
        child: new Container(
          color: Colors.black.withOpacity(0.3),
          child: _createContent(context),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new AnimatedBuilder(
          animation: animation.controller, builder: _createAnimation),
    );
  }

  Widget _createLogoAvatar() {
    return new Transform(
      transform: new Matrix4.diagonal3Values(
          animation.avatarSize.value, animation.avatarSize.value, 1.0),
      alignment: Alignment.center,
      child: new Container(
        width: double.infinity,
        height: 110.0,
        margin: const EdgeInsets.only(top: 32.0, left: 19.0),
        padding: const EdgeInsets.all(3.0),
        child: Row(
          children: <Widget>[
            new CircleAvatar(
              backgroundColor: Colors.white,
              child: new Image.asset(
                company.logo,
                width: 90.0,
                height: 90.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Build Apps With Paulo",
                style: new TextStyle(
                    fontSize: 19 * animation.avatarSize.value + 2.0,
                    color: Colors.white70),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _createContent(BuildContext context) {
    return new SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _createLogoAvatar(),
          _createAboutCompany(context),
          _createCourseScroller()
        ],
      ),
    );
  }

  Widget _createAboutCompany(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(top: 14.0, left: 14.0, right: 14.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            company.name,
            style: new TextStyle(
                color: Colors.white.withOpacity(animation.nameOpacity.value),
                fontWeight: FontWeight.bold,
                fontSize: 30.0 * animation.avatarSize.value + 2.0),
          ),
          new Text(
            company.location,
            style: new TextStyle(
              color: Colors.white.withOpacity(animation.locationOpacity.value),
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            color: Colors.white.withOpacity(0.85),
            margin: const EdgeInsets.symmetric(vertical: 14.0),
            width: MediaQuery.of(context).size.width * animation.dividerWidth.value,
            height: 1.0,
          ),
          Text(
            company.about,
            style: TextStyle(
                color:
                    Colors.white.withOpacity(animation.biographyOpacity.value),
                height: 1.4),
          )
        ],
      ),
    );
  }

  Widget _createCourseScroller() {
    return new Padding(
        padding: const EdgeInsets.only(top: 14.0),
        child: new Opacity(
            opacity: animation.courseScrollerOpacity.value,
            child: new SizedBox.fromSize(
              size: new Size.fromHeight(250.0),
              // child:CourseCard(company.courses[0]),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  itemCount: company.courses.length,
                  itemBuilder: (BuildContext context, int index) {
                    var course = company.courses[index];
                    return new CourseCard(course);
                  }),
            )));
  }
}
