import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Helper/colors.dart';

class CommonAppBar extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? bottomBar;
  const CommonAppBar({
    Key? key,
    required this.title,
    required this.child,
    this.bottomBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.fontColor.withOpacity(.5)),
          onPressed: () {
            Get.back();
          },
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: colors.fontColor.withOpacity(.7)),
          ),
        ),
      ),
      body: child,
      bottomNavigationBar: bottomBar,
    );
  }
}
