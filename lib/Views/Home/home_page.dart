import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Controllers/home_controller.dart';
import 'package:project/Helper/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    HomeController controller = Get.put(HomeController());
    tabController = TabController(
        length: controller.products[0].tableMenuList!.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return RefreshIndicator(
          onRefresh: () => controller.getHome(),
          child: Column(
            children: [
              TabBar(
                  controller: tabController,
                  isScrollable: true,
                  indicatorColor: colors.maroon,
                  labelColor: colors.maroon,
                  unselectedLabelColor: colors.fontColor,
                  tabs: controller.products[0].tableMenuList!
                      .map((tabName) => Tab(
                            child: Text(
                              tabName.menuCategory!,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          ))
                      .toList()),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    for (var i = 0;
                        i < controller.products[0].tableMenuList!.length;
                        i++)
                      ListView.builder(
                        itemCount: controller.products[0].tableMenuList![i]
                            .categoryDishes!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return dishCategoryCard(context, i, index);
                        },
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

  Widget dishCategoryCard(context, menuPos, index) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Container(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: colors.lightWhite,
                width: 1,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: controller.products[0].tableMenuList![menuPos]
                                .categoryDishes![index].dishType ==
                            2
                        ? colors.green
                        : colors.maroon,
                  ),
                ),
                child: Icon(
                  Icons.circle,
                  size: 14,
                  color: controller.products[0].tableMenuList![menuPos]
                              .categoryDishes![index].dishType ==
                          2
                      ? colors.green
                      : colors.maroon,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            controller.products[0].tableMenuList![menuPos]
                                .categoryDishes![index].dishName!,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "INR ${controller.products[0].tableMenuList![menuPos].categoryDishes![index].dishPrice!}",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "${controller.products[0].tableMenuList![menuPos].categoryDishes![index].dishCalories} Calories",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      controller.products[0].tableMenuList![menuPos]
                          .categoryDishes![index].dishDescription!,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: colors.fontColor.withOpacity(.8)),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: 140,
                      decoration: BoxDecoration(
                        color: colors.green,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, color: colors.white),
                            splashRadius: 15,
                            onPressed: () {
                              controller.decrementCart(menuPos, index);
                            },
                          ),
                          const SizedBox(width: 8),
                          if (controller.cartItems.contains(controller
                              .products[0]
                              .tableMenuList![menuPos]
                              .categoryDishes![index]
                              .dishId))
                            for (var i = 0;
                                i < controller.cartCount.length;
                                i++)
                              if (controller.cartCount[i][0] ==
                                  controller.products[0].tableMenuList![menuPos]
                                      .categoryDishes![index].dishId)
                                Text(
                                  controller.cartCount[i][4].toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                          color: colors.white,
                                          fontWeight: FontWeight.bold),
                                ),
                          if (!controller.cartItems.contains(controller
                              .products[0]
                              .tableMenuList![menuPos]
                              .categoryDishes![index]
                              .dishId))
                            Text(
                              0.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                      color: colors.white,
                                      fontWeight: FontWeight.bold),
                            ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.add, color: colors.white),
                            splashRadius: 15,
                            onPressed: () {
                              controller.incrementCart(menuPos, index);
                            },
                          ),
                        ],
                      ),
                    ),
                    if (controller.products[0].tableMenuList![menuPos]
                        .categoryDishes![index].addonCat!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          'Customizations Available',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: colors.maroon),
                        ),
                      )
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 100,
                height: 100,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: colors.lightWhite)),
                child: CachedNetworkImage(
                  imageUrl: controller.products[0].tableMenuList![menuPos]
                      .categoryDishes![index].dishImage!,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
