import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kochin_machine_test/core/color/color.dart';
import 'package:kochin_machine_test/core/custom_container/container.dart';
import 'package:kochin_machine_test/feature/home_view/view/widget/user_details_displaying.dart';
import 'package:kochin_machine_test/feature/home_view/view_model/home_controller.dart';
import 'package:kochin_machine_test/feature/overview_page/view_model/over_view_controller.dart';
import 'package:provider/provider.dart';

import '../../../core/responsive_ui/responsive_ui.dart';
import '../../../responsive/responsive.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Apc.primary,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Consumer<HomeController>(
            builder: (context, userList, _) {
              return kIsWeb && ResponsiveUi.isDesktop(context)
                  ? Wrap(
                      children: List.generate(userList.myPostList?.length ?? 0,
                          (index) {
                        final data = userList.myPostList?[index];
                        return GestureDetector(
                          onTap: () async {
                            context
                                .read<OverViewController>()
                                .getUserIndex(index + 1);
                            await context
                                .read<OverViewController>()
                                .getAllOverViewObject();
                          },
                          child: SizedBox(
                            height: 150,
                            width: Responsive.widthMultiplier! * 60,
                            child: Card(
                              elevation: 3,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                      child: CustomContainer(
                                    height: 120,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 0, 162, 146),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: CachedNetworkImage(
                                      imageUrl: data?.image ?? "",
                                      height: 150,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) {
                                        return const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CupertinoActivityIndicator(
                                              color: Apc.grey,
                                            ), // Show Cupertino activity indicator on error
                                            SizedBox(height: 10),
                                            Text('Error loading image'),
                                          ],
                                        );
                                      },
                                    ),
                                  )),
                                  Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          UserDetailShowingWidget(
                                            subTitleSize:
                                                Responsive.textMultiplier! * 1,
                                            titleSize:
                                                Responsive.textMultiplier! * 1,
                                            size: 5,
                                            title: 'Name',
                                            subTitle: data?.username ?? "",
                                          ),
                                          UserDetailShowingWidget(
                                            subTitleSize:
                                                Responsive.textMultiplier! * 1,
                                            titleSize:
                                                Responsive.textMultiplier! * 1,
                                            size: 5,
                                            title: 'Age',
                                            subTitle:
                                                data?.age.toString() ?? "",
                                          ),
                                          UserDetailShowingWidget(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            subTitleSize:
                                                Responsive.textMultiplier! * 1,
                                            titleSize:
                                                Responsive.textMultiplier! * 1,
                                            size: 5,
                                            title: 'Address',
                                            subTitle:
                                                "${data?.address?.address} , ${data?.address?.city}",
                                          ),
                                          UserDetailShowingWidget(
                                            subTitleSize:
                                                Responsive.textMultiplier! * 1,
                                            titleSize:
                                                Responsive.textMultiplier! * 1,
                                            size: 5,
                                            title: 'Company',
                                            subTitle: data?.company?.name ?? "",
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    )
                  // ? Row(
                  //     children: [
                  //       Expanded(
                  //         child: CustomContainer(
                  //           height: MediaQuery.of(context).size.height,
                  //           width: MediaQuery.of(context).size.width,
                  //           color: Apc.white,
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: CustomContainer(
                  //           height: MediaQuery.of(context).size.height,
                  //           width: MediaQuery.of(context).size.width,
                  //           child: List.generate(, (index) {

                  //           })
                  //           // ListView.builder(
                  //           //   shrinkWrap: true,
                  //           //   itemCount: userList.myPostList?.length ?? 0,
                  //           //   itemBuilder: (context, index) {
                  //           //     final data = userList.myPostList?[index];
                  //           //     return
                  //           //   },
                  //           // ),
                  //         ),
                  //       ),
                  //     ],
                  //   )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: userList.myPostList?.length ?? 0,
                      itemBuilder: (context, index) {
                        final data = userList.myPostList?[index];
                        return GestureDetector(
                          onTap: () async {
                            context
                                .read<OverViewController>()
                                .getUserIndex(index + 1);
                            await context
                                .read<OverViewController>()
                                .getAllOverViewObject();
                          },
                          child: SizedBox(
                            height: 150,
                            child: Card(
                              elevation: 3,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                      child: CustomContainer(
                                    height: 120,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 0, 162, 146),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: CachedNetworkImage(
                                      imageUrl: data?.image ?? "",
                                      height: 120,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) {
                                        return const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CupertinoActivityIndicator(
                                              color: Apc.grey,
                                            ), // Show Cupertino activity indicator on error
                                            SizedBox(height: 10),
                                            Text('Error loading image'),
                                          ],
                                        );
                                      },
                                    ),
                                  )),
                                  Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          UserDetailShowingWidget(
                                            title: 'Name',
                                            subTitle: data?.username ?? "",
                                          ),
                                          UserDetailShowingWidget(
                                            title: 'Age',
                                            subTitle:
                                                data?.age.toString() ?? "",
                                          ),
                                          UserDetailShowingWidget(
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            title: 'Address',
                                            subTitle:
                                                "${data?.address?.address} , ${data?.address?.city}",
                                          ),
                                          UserDetailShowingWidget(
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            title: 'Company',
                                            subTitle: data?.company?.name ?? "",
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
            },
          ),
          context.watch<OverViewController>().isOverViewPageLoading == true
              ? CustomContainer(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Apc.fadeGrey.withOpacity(0.3),
                  child: const Center(child: CircularProgressIndicator()),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
