import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kochin_machine_test/feature/home_view/view_model/home_controller.dart';
import 'package:provider/provider.dart';

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
          return ListView.builder(
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
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Expanded(child:Column(
                        children: [
                          
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
