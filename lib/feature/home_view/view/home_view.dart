import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kochin_machine_test/feature/home_view/view/widget/mobile_view.dart';

import 'package:kochin_machine_test/feature/home_view/view/widget/user_details_displaying.dart';
import 'package:kochin_machine_test/feature/home_view/view_model/home_controller.dart';

import '../../../core/color/color.dart';

import 'package:provider/provider.dart';

import '../../../core/custom_container/container.dart';
import '../../../core/responsive_ui/responsive_ui.dart';
import '../../../responsive/responsive.dart';
import '../../overview_page/view_model/over_view_controller.dart';

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
          Consumer<UserProvider>(
            builder: (context, userList, _) {
              return kIsWeb && ResponsiveUi.isDesktop(context)
                  ? SingleChildScrollView(
                      child: Wrap(
                        children: List.generate(
                            growable: true, userList.dataList.length, (index) {
                          final data = userList.dataList[index];
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
                              width: Responsive.widthMultiplier! * 50,
                              child: Card(
                                elevation: 3,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                        child: CustomContainer(
                                      height: 120,
                                      width: 0,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 0, 162, 146),
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: CachedNetworkImage(
                                        imageUrl: data.image ?? "",
                                        height: 150,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) {
                                          return const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CupertinoActivityIndicator(
                                                color: Apc.grey,
                                              ),
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
                                                  Responsive.textMultiplier! *
                                                      1,
                                              titleSize:
                                                  Responsive.textMultiplier! *
                                                      1,
                                              size: 5,
                                              title: 'Name',
                                              subTitle: data.username ?? "",
                                            ),
                                            UserDetailShowingWidget(
                                              subTitleSize:
                                                  Responsive.textMultiplier! *
                                                      1,
                                              titleSize:
                                                  Responsive.textMultiplier! *
                                                      1,
                                              size: 5,
                                              title: 'Age',
                                              subTitle:
                                                  data.age.toString() ?? "",
                                            ),
                                            UserDetailShowingWidget(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              subTitleSize:
                                                  Responsive.textMultiplier! *
                                                      1,
                                              titleSize:
                                                  Responsive.textMultiplier! *
                                                      1,
                                              size: 5,
                                              title: 'Address',
                                              subTitle:
                                                  "${data.address?.address} , ${data.address?.city}",
                                            ),
                                            UserDetailShowingWidget(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              subTitleSize:
                                                  Responsive.textMultiplier! *
                                                      1,
                                              titleSize:
                                                  Responsive.textMultiplier! *
                                                      1,
                                              size: 5,
                                              title: 'Company',
                                              subTitle:
                                                  data.company?.name ?? "",
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    )
                  : const MyHomePage();
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
