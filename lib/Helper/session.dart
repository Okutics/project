import 'package:flutter/material.dart';
import 'package:project/Helper/colors.dart';

toastMsg(context, msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(
          msg,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(color: colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: colors.green,
        elevation: 1.0,
        behavior: SnackBarBehavior.floating,
        shape: const StadiumBorder()),
  );
}
