import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:project/Helper/session.dart';
import 'package:project/Models/HomeModel.dart';
import 'package:project/Views/Auth/otp_page.dart';

class HomeController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  TextEditingController phone = TextEditingController();

  bool homeLoader = true;
  bool buttonLoader = true;
  List<HomeModel> products = [];

  List cartItems = [];
  int cartItemCount = 0;
  List cartCount = [];
  double cartTotal = 0;

  String verifyId = '';
  String userName = "";
  String userId = "";

  Future<List<HomeModel>?> getHome() async {
    try {
      homeLoader = false;
      update();
      var result = await get(
        Uri.parse('https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
      );
      homeLoader = true;
      update();
      if (result.statusCode == 200) {
        products = homeModelFromJson(result.body);
        update();
        Get.offAndToNamed("home");
        print(products);
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    print(await auth.signInWithCredential(credential));
    var authResult = await auth.signInWithCredential(credential);

    var user = authResult.user;
    userName = user!.email!;
    userId = user.uid;
    getHome();
  }

  Future sendOTP(BuildContext context) async {
    buttonLoader = false;
    update();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91${phone.text}',
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          toastMsg(context, 'The provided phone number is not valid.');
        } else if (e.code == 'too-many-requests') {
          toastMsg(context, 'Maximum sms limit reached.');
        } else {
          toastMsg(context, e.code);
        }
        buttonLoader = true;
      },
      codeSent: (String verificationId, int? resendToken) async {
        print(verificationId);
        buttonLoader = true;
        verifyId = verificationId;
        Get.to(() => OtpPage());
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    update();
  }

  Future verifyOTP(BuildContext context, String otp) async {
    buttonLoader = false;
    update();
    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp);
    await auth.signInWithCredential(credential).then((value) async {
      print(value.user!);
      userName = value.user!.phoneNumber!;
      userId = value.user!.uid;
      getHome();
    }).catchError((e) {
      print(e);
    });
    buttonLoader = true;
    update();
  }

  incrementCart(menuPos, index) {
    if (cartItems.contains(
        products[0].tableMenuList![menuPos].categoryDishes![index].dishId)) {
      for (var i = 0; i < cartCount.length; i++) {
        if (cartCount[i][0] ==
            products[0].tableMenuList![menuPos].categoryDishes![index].dishId) {
          cartCount[i][4] += 1;
          cartItemCount += 1;
          cartTotal += cartCount[i][3];
        }
      }
    } else {
      cartItems.add(
          products[0].tableMenuList![menuPos].categoryDishes![index].dishId!);
      cartItemCount = cartItemCount + 1;
      cartTotal +=
          products[0].tableMenuList![menuPos].categoryDishes![index].dishPrice!;
      cartCount.add([
        products[0].tableMenuList![menuPos].categoryDishes![index].dishId!,
        products[0].tableMenuList![menuPos].categoryDishes![index].dishType!,
        products[0].tableMenuList![menuPos].categoryDishes![index].dishName!,
        products[0].tableMenuList![menuPos].categoryDishes![index].dishPrice!,
        1,
        products[0]
            .tableMenuList![menuPos]
            .categoryDishes![index]
            .dishCalories!,
      ]);
    }
    update();
  }

  decrementCart(menuPos, index) {
    if (cartItems.contains(
        products[0].tableMenuList![menuPos].categoryDishes![index].dishId)) {
      for (var i = 0; i < cartCount.length; i++) {
        if (cartCount[i][0] ==
            products[0].tableMenuList![menuPos].categoryDishes![index].dishId) {
          if (cartCount[i][4] > 0) {
            cartCount[i][4] -= 1;
            cartItemCount -= 1;
            cartTotal -= cartCount[i][3];
          }
          if (cartCount[i][4] == 0) {
            cartItems.removeAt(i);
            cartCount.removeAt(i);
          }
        }
      }
    }
    update();
  }
}
