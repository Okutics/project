import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:project/Controllers/home_controller.dart';
import 'package:project/Helper/colors.dart';

class OtpPage extends StatelessWidget {
  OtpPage({Key? key}) : super(key: key);
  final TextEditingController otp = TextEditingController();

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
                flex: 3,
                child: Image.asset(
                  "assets/icons/firebase.png",
                  width: Get.width * .3,
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Text(
                            'Verify OTP',
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Check your mobile. We have send the code verification to your mobile number ',
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: PinCodeTextField(
                        appContext: context,
                        length: 6,
                        obscureText: false,
                        hintCharacter: '',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(50),
                          fieldHeight: 50,
                          fieldWidth: 50,
                          activeFillColor: colors.white,
                          activeColor: colors.primary,
                          borderWidth: 2,
                          selectedColor: colors.blue,
                          selectedFillColor: colors.white,
                          inactiveColor: colors.lightWhite,
                          inactiveFillColor: colors.lightWhite,
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        backgroundColor: colors.white,
                        enableActiveFill: true,
                        controller: otp,
                        onCompleted: (v) {
                          print("Completed");
                        },
                        onChanged: (value) {
                          print(value);
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.verifyOTP(context, otp.text);
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
                                  'Verify OTP',
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
