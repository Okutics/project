import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Controllers/home_controller.dart';
import 'package:project/Helper/colors.dart';
import 'package:project/Views/Auth/phone_auth_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (controller) {
          return Column(
            children: [
              Expanded(
                flex: 4,
                child: Image.asset(
                  "assets/icons/firebase.png",
                  width: Get.width * .3,
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.signInWithGoogle();
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: colors.green.withOpacity(.7),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: colors.white,
                              ),
                              child: Image.asset(
                                "assets/icons/google.png",
                                width: 20,
                                height: 20,
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  'Google',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                          color: colors.white,
                                          fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const PhoneAuthPage());
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: colors.blue,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.asset(
                                "assets/icons/phone.png",
                                width: 20,
                                height: 20,
                                color: colors.white,
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  'Phone',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                          color: colors.white,
                                          fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
