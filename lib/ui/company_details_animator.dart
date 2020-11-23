import 'package:animated_app/repo/repo.dart';
import 'package:animated_app/ui/company_details_page.dart';
import 'package:flutter/material.dart';

class CompanyDetsAnimator extends StatefulWidget {
  @override
  _CompanyDetsAnimatorState createState() => new _CompanyDetsAnimatorState();
}

class _CompanyDetsAnimatorState extends State<CompanyDetsAnimator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 4000),
        vsync: this);

    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new CompanyDetailsPage(
       company: RepoData.companyData,
       controller: _controller
    );
  }
}
