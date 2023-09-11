import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kochin_machine_test/core/color/color.dart';
import 'package:kochin_machine_test/feature/home_view/view/widget/user_details_displaying.dart';
import 'package:kochin_machine_test/feature/home_view/view_model/home_controller.dart';
import 'package:provider/provider.dart';

import '../../../core/responsive_ui/responsive_ui.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 0, 122, 138),
      ),
      body: Consumer<HomeController>(
        builder: (context, userList, _) {
          return kIsWeb && ResponsiveUi.isDesktop(context)
              ? Container(
                  color: Apc.gold,
                  height: 50,
                  width: 800,
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: userList.myPostList?.length ?? 0,
                  itemBuilder: (context, index) {
                    final data = userList.myPostList?[index];
                    return SizedBox(
                      height: 150,
                      child: Card(
                        elevation: 3,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                                child: CachedNetworkImage(
                              imageUrl: data?.image ?? "",
                              height: 120,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) {
                                return const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CupertinoActivityIndicator(), // Show Cupertino activity indicator on error
                                    SizedBox(height: 10),
                                    Text('Error loading image'),
                                  ],
                                );
                              },
                            )),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    UserDetailShowingWidget(
                                      title: 'Name',
                                      subTitle: data?.username??"",
                                    ),
                                     UserDetailShowingWidget(
                                      title: 'Age',
                                      subTitle: data?.age.toString()??"",
                                    ),
                                     UserDetailShowingWidget(
                                      title: 'Address',
                                      subTitle: "${data?.address?.address} , ${data?.address?.city}",
                                    ),
                                     UserDetailShowingWidget(
                                      title: 'Company',
                                      subTitle: data?.company?.name??"",
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
