import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kochin_machine_test/feature/home_view/view/widget/user_details_displaying.dart';
import 'package:provider/provider.dart';

import '../../../../core/color/color.dart';
import '../../../../core/custom_container/container.dart';
import '../../../overview_page/view_model/over_view_controller.dart';
import '../../view_model/home_controller.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();

    final ScrollController scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        // Scroll reached the end, load more data
        userProvider.fetchData();
      }
    });

    return Scaffold(body: Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        if (userProvider.isLoading && userProvider.dataList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else if (!userProvider.isLoading && userProvider.dataList.isEmpty) {
          return const Center(child: Text('No data available.'));
        } else {
          return ListView.builder(
            itemCount:
                userProvider.dataList.length + (userProvider.hasMore ? 1 : 0),
            controller: scrollController,
            itemBuilder: (context, index) {
              if (index < userProvider.dataList.length) {
                final data = userProvider.dataList[index];
                return GestureDetector(
                  onTap: () async {
                    context.read<OverViewController>().getUserIndex(index + 1);
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
                                color: const Color.fromARGB(255, 0, 162, 146),
                                borderRadius: BorderRadius.circular(6)),
                            child: CachedNetworkImage(
                              imageUrl: data.image ?? "",
                              height: 120,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) {
                                return const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  UserDetailShowingWidget(
                                    title: 'Name',
                                    subTitle: data.username ?? "",
                                  ),
                                  UserDetailShowingWidget(
                                    title: 'Age',
                                    subTitle: data.age.toString(),
                                  ),
                                  UserDetailShowingWidget(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    title: 'Address',
                                    subTitle:
                                        "${data.address?.address} , ${data.address?.city}",
                                  ),
                                  UserDetailShowingWidget(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    title: 'Company',
                                    subTitle: data.company?.name ?? "",
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              } else if (userProvider.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (userProvider.hasMore) {
                return const SizedBox.shrink();
              } else {
                return const Center(
                  child: Text('End of List'),
                );
              }
            },
          );
        }
      },
    ));
  }
}