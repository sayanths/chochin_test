import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:kochin_machine_test/feature/home_view/view/widget/user_details_displaying.dart';

import '../../../core/color/color.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<dynamic> _dataList = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    fetchData();
  }

  final ScrollController _scrollController = ScrollController();

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // Scroll reached the end, load more data
      fetchData();
    }
  }

  Future<void> fetchData() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse(
        'https://dummyjson.com/users?limit=10&skip=${(_currentPage - 1) * 5}'));
    print('API Response: ${response.body}');
    setState(() {
      _isLoading = false;
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.containsKey('users') && data['users'] is List) {
          final users = data['users'];
          if (users.isNotEmpty) {
            _dataList.addAll(users);
            _currentPage++;
          } else {
            _hasMore = false;
          }
        } else {
          // Handle the case where 'users' key is missing or not a list
        }
      } else {
        // Handle error here
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagination Example'),
      ),
      body: ListView.builder(
        itemCount: _dataList.length + (_hasMore ? 1 : 0),
        controller: _scrollController,
        itemBuilder: (context, index) {
          if (index < _dataList.length) {
            final item = _dataList[index];
            return GestureDetector(
              onTap: () {
                // Handle onTap action here
              },
              child: Card(
                elevation: 3,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Container(
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 162, 146),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: item['image'] ?? "",
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
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          UserDetailShowingWidget(
                            title: 'Name',
                            subTitle: item['username'] ?? "",
                          ),
                          UserDetailShowingWidget(
                            title: 'Age',
                            subTitle: item['age'].toString() ?? "",
                          ),
                          UserDetailShowingWidget(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            title: 'Address',
                            subTitle:
                                "${item['address']['address']} , ${item['address']['city']}",
                          ),
                          UserDetailShowingWidget(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            title: 'Company',
                            subTitle: item['company']['name'] ?? "",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (_isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (_hasMore) {
            return const SizedBox.shrink();
          } else {
            return const Center(
              child: Text('End of List'),
            );
          }
        },
      ),
    );
  }
}
// class HomeView extends StatelessWidget {
//   const HomeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Apc.primary,
//         elevation: 0,
//       ),
//       body: Stack(
//         children: [
//           Consumer<HomeController>(
//             builder: (context, userList, _) {
//               return kIsWeb && ResponsiveUi.isDesktop(context)
//                   ? Wrap(
//                       children: List.generate(userList.myPostList?.length ?? 0,
//                           (index) {
//                         final data = userList.myPostList?[index];
//                         return GestureDetector(
//                           onTap: () async {
//                             context
//                                 .read<OverViewController>()
//                                 .getUserIndex(index + 1);
//                             await context
//                                 .read<OverViewController>()
//                                 .getAllOverViewObject();
//                           },
//                           child: SizedBox(
//                             height: 150,
//                             width: Responsive.widthMultiplier! * 50,
//                             child: Card(
//                               elevation: 3,
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Expanded(
//                                       child: CustomContainer(
//                                     height: 120,
//                                     width: 0,
//                                     decoration: BoxDecoration(
//                                         color: const Color.fromARGB(
//                                             255, 0, 162, 146),
//                                         borderRadius: BorderRadius.circular(6)),
//                                     child: CachedNetworkImage(
//                                       imageUrl: data?.image ?? "",
//                                       height: 150,
//                                       fit: BoxFit.cover,
//                                       errorWidget: (context, url, error) {
//                                         return const Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             CupertinoActivityIndicator(
//                                               color: Apc.grey,
//                                             ), // Show Cupertino activity indicator on error
//                                             SizedBox(height: 10),
//                                             Text('Error loading image'),
//                                           ],
//                                         );
//                                       },
//                                     ),
//                                   )),
//                                   Expanded(
//                                       flex: 2,
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         children: [
//                                           UserDetailShowingWidget(
//                                             subTitleSize:
//                                                 Responsive.textMultiplier! * 1,
//                                             titleSize:
//                                                 Responsive.textMultiplier! * 1,
//                                             size: 5,
//                                             title: 'Name',
//                                             subTitle: data?.username ?? "",
//                                           ),
//                                           UserDetailShowingWidget(
//                                             subTitleSize:
//                                                 Responsive.textMultiplier! * 1,
//                                             titleSize:
//                                                 Responsive.textMultiplier! * 1,
//                                             size: 5,
//                                             title: 'Age',
//                                             subTitle:
//                                                 data?.age.toString() ?? "",
//                                           ),
//                                           UserDetailShowingWidget(
//                                             maxLines: 1,
//                                             overflow: TextOverflow.ellipsis,
//                                             subTitleSize:
//                                                 Responsive.textMultiplier! * 1,
//                                             titleSize:
//                                                 Responsive.textMultiplier! * 1,
//                                             size: 5,
//                                             title: 'Address',
//                                             subTitle:
//                                                 "${data?.address?.address} , ${data?.address?.city}",
//                                           ),
//                                           UserDetailShowingWidget(
//                                              maxLines: 1,
//                                             overflow: TextOverflow.ellipsis,
//                                             subTitleSize:
//                                                 Responsive.textMultiplier! * 1,
//                                             titleSize:
//                                                 Responsive.textMultiplier! * 1,
//                                             size: 5,
//                                             title: 'Company',
//                                             subTitle: data?.company?.name ?? "",
//                                           ),
//                                         ],
//                                       ))
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       }),
//                     )
          //         : ListView.builder(
          //             shrinkWrap: true,
          //             itemCount: userList.myPostList?.length ?? 0,
          //             itemBuilder: (context, index) {
          //               final data = userList.myPostList?[index];
          //               return GestureDetector(
          //                 onTap: () async {
          //                   context
          //                       .read<OverViewController>()
          //                       .getUserIndex(index + 1);
          //                   await context
          //                       .read<OverViewController>()
          //                       .getAllOverViewObject();
          //                 },
          //                 child: SizedBox(
          //                   height: 150,
          //                   child: Card(
          //                     elevation: 3,
          //                     child: Row(
          //                       mainAxisSize: MainAxisSize.min,
          //                       children: [
          //                         Expanded(
          //                             child: CustomContainer(
          //                           height: 120,
          //                           width: MediaQuery.of(context).size.width,
          //                           decoration: BoxDecoration(
          //                               color: const Color.fromARGB(
          //                                   255, 0, 162, 146),
          //                               borderRadius: BorderRadius.circular(6)),
          //                           child: CachedNetworkImage(
          //                             imageUrl: data?.image ?? "",
          //                             height: 120,
          //                             fit: BoxFit.cover,
          //                             errorWidget: (context, url, error) {
          //                               return const Column(
          //                                 mainAxisAlignment:
          //                                     MainAxisAlignment.center,
          //                                 children: [
          //                                   CupertinoActivityIndicator(
          //                                     color: Apc.grey,
          //                                   ), // Show Cupertino activity indicator on error
          //                                   SizedBox(height: 10),
          //                                   Text('Error loading image'),
          //                                 ],
          //                               );
          //                             },
          //                           ),
          //                         )),
          //                         Expanded(
          //                             flex: 2,
          //                             child: Column(
          //                               mainAxisAlignment:
          //                                   MainAxisAlignment.start,
          //                               children: [
          //                                 UserDetailShowingWidget(
          //                                   title: 'Name',
          //                                   subTitle: data?.username ?? "",
          //                                 ),
          //                                 UserDetailShowingWidget(
          //                                   title: 'Age',
          //                                   subTitle:
          //                                       data?.age.toString() ?? "",
          //                                 ),
          //                                 UserDetailShowingWidget(
          //                                   maxLines: 2,
          //                                   overflow: TextOverflow.ellipsis,
          //                                   title: 'Address',
          //                                   subTitle:
          //                                       "${data?.address?.address} , ${data?.address?.city}",
          //                                 ),
          //                                 UserDetailShowingWidget(
          //                                   maxLines: 2,
          //                                   overflow: TextOverflow.ellipsis,
          //                                   title: 'Company',
          //                                   subTitle: data?.company?.name ?? "",
          //                                 ),
          //                               ],
          //                             ))
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               );
          //             },
          //           );
          //   },
          // ),
//           context.watch<OverViewController>().isOverViewPageLoading == true
//               ? CustomContainer(
//                   height: MediaQuery.of(context).size.height,
//                   width: MediaQuery.of(context).size.width,
//                   color: Apc.fadeGrey.withOpacity(0.3),
//                   child: const Center(child: CircularProgressIndicator()),
//                 )
//               : const SizedBox()
//         ],
//       ),
//     );
//   }
// }
