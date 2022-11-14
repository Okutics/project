import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Controllers/home_controller.dart';
import 'package:project/Helper/colors.dart';
import 'package:project/Views/Cart/cart_page.dart';
import 'package:project/Views/Home/home_page.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    Get.to(() => const CartPage());
                  },
                ),
                Positioned(
                  right: 5,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: colors.maroon,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${controller.cartItems.length}',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                color: colors.green,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Image.network(
                        "https://expertphotography.b-cdn.net/wp-content/uploads/2020/08/social-media-profile-photos-9.jpg",
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      controller.userName,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'ID: ${controller.userId}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () async {
                  controller.googleSignIn.signOut();
                  controller.auth.signOut();
                  Get.offAndToNamed('/');
                },
              )
            ],
          ),
        ),
        body: const HomePage(),
      );
    });
  }
}
