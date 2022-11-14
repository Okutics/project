import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:project/Controllers/home_controller.dart';
import 'package:project/Helper/colors.dart';
import 'package:project/Helper/session.dart';

class PhoneAuthPage extends StatelessWidget {
  const PhoneAuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      decoration: BoxDecoration(
                          color: colors.secondary,
                          borderRadius: BorderRadius.circular(15)),
                      child: TextFormField(
                        controller: controller.phone,
                        keyboardType: TextInputType.number,
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: colors.white),
                        maxLines: 1,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.call, color: colors.white),
                          prefixIconConstraints:
                              const BoxConstraints(minWidth: 40, maxHeight: 20),
                          isDense: true,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          hintText: 'Phone Number',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: colors.white),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (controller.phone.text.length != 10) {
                          toastMsg(context, "Phone Number must be 10 digits");
                        } else {
                          controller.sendOTP(context);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(25, 20, 25, 0),
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: colors.blue,
                        ),
                        child: Center(
                          child: controller.buttonLoader
                              ? Text(
                                  'Send OTP',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                          color: colors.white,
                                          fontWeight: FontWeight.w600),
                                )
                              : const CircularProgressIndicator(
                                  color: colors.white,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
