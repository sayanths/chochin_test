import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kochin_machine_test/core/color/color.dart';
import 'package:kochin_machine_test/core/custom_container/container.dart';
import 'package:kochin_machine_test/feature/overview_page/view_model/over_view_controller.dart';
import 'package:kochin_machine_test/responsive/responsive.dart';
import 'package:provider/provider.dart';

import '../../../core/responsive_ui/responsive_ui.dart';
import '../../home_view/view/widget/user_details_displaying.dart';

class OverViewPage extends StatelessWidget {
  const OverViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OverView Page'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 3, 148, 66),
        elevation: 0,
      ),
      body:
          Consumer<OverViewController>(builder: (context, overViewProvider, _) {
        return kIsWeb && ResponsiveUi.isDesktop(context)
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      const CustomHeight10(),
                      const CustomHeight10(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomContainer(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                                border: Border.all(color: Apc.primary)),
                            child: CachedNetworkImage(
                              imageUrl:
                                  overViewProvider.overviewObject?.image ?? "",
                              height: 200,
                            ),
                          ),
                        ],
                      ),
                      const CustomHeight10(),
                      HeadingWidgetCustom(
                        size: ResponsiveUi.isDesktop(context)
                            ? Responsive.textMultiplier! * 1.0
                            : Responsive.textMultiplier! * 1.8,
                        title: "Personal Details",
                      ),
                      const CustomHeight10(),
                      UserDetailShowingWidget(
                        title: 'Name',
                        subTitle: overViewProvider.overviewObject?.username
                                ?.toUpperCase() ??
                            "",
                      ),
                      UserDetailShowingWidget(
                        title: 'Address',
                        subTitle:
                            overViewProvider.overviewObject?.address?.address ??
                                "",
                      ),
                      UserDetailShowingWidget(
                        title: 'City',
                        subTitle:
                            overViewProvider.overviewObject?.address?.city ??
                                "",
                      ),
                      UserDetailShowingWidget(
                        title: 'Pin Code',
                        subTitle: overViewProvider
                                .overviewObject?.address?.postalCode ??
                            "",
                      ),
                      UserDetailShowingWidget(
                        title: 'State',
                        subTitle:
                            overViewProvider.overviewObject?.address?.state ??
                                "",
                      ),
                      UserDetailShowingWidget(
                        title: 'Age',
                        subTitle:
                            overViewProvider.overviewObject?.age.toString() ??
                                "",
                      ),
                      UserDetailShowingWidget(
                        title: 'DOB',
                        subTitle: DateFormat('dd-MM-yyyy').format(
                            overViewProvider.overviewObject!.birthDate!),
                      ),
                      UserDetailShowingWidget(
                        title: 'Height',
                        subTitle:
                            "${overViewProvider.overviewObject?.height.toString()} cm",
                      ),
                      UserDetailShowingWidget(
                        title: 'Email',
                        subTitle: "${overViewProvider.overviewObject?.email}",
                      ),
                      UserDetailShowingWidget(
                        title: 'Eye Color',
                        subTitle:
                            "${overViewProvider.overviewObject?.eyeColor}",
                      ),
                      UserDetailShowingWidget(
                        title: 'Gender',
                        subTitle: "${overViewProvider.overviewObject?.gender}",
                      ),
                      UserDetailShowingWidget(
                        title: 'Hair Color',
                        subTitle:
                            "${overViewProvider.overviewObject?.hair?.color}",
                      ),
                      UserDetailShowingWidget(
                        title: 'Hair Type',
                        subTitle:
                            "${overViewProvider.overviewObject?.hair?.type}",
                      ),
                      UserDetailShowingWidget(
                        title: 'Phone',
                        subTitle: "${overViewProvider.overviewObject?.phone}",
                      ),
                      UserDetailShowingWidget(
                        maxLines: null,
                        title: 'University',
                        subTitle:
                            "${overViewProvider.overviewObject?.university}",
                      ),
                      UserDetailShowingWidget(
                        maxLines: 1,
                        title: 'Weight',
                        subTitle: "${overViewProvider.overviewObject?.weight}",
                      ),
                      const CustomHeight10(),
                      const CustomDivider(),
                      const CustomHeight10(),
                      HeadingWidgetCustom(
                        title: "Bank Details",
                        size: ResponsiveUi.isDesktop(context)
                            ? Responsive.textMultiplier! * 1.0
                            : Responsive.textMultiplier! * 1.8,
                      ),
                      const CustomHeight10(),
                      UserDetailShowingWidget(
                        maxLines: 1,
                        title: 'Card Number',
                        subTitle:
                            "${overViewProvider.overviewObject?.bank?.cardNumber}",
                      ),
                      UserDetailShowingWidget(
                        maxLines: 1,
                        title: 'Card Expire',
                        subTitle:
                            "${overViewProvider.overviewObject?.bank?.cardExpire}",
                      ),
                      UserDetailShowingWidget(
                        maxLines: 1,
                        title: 'Card Type',
                        subTitle:
                            "${overViewProvider.overviewObject?.bank?.cardType}",
                      ),
                      UserDetailShowingWidget(
                        maxLines: 1,
                        title: 'Card Currency',
                        subTitle:
                            "${overViewProvider.overviewObject?.bank?.currency}",
                      ),
                      UserDetailShowingWidget(
                        maxLines: 1,
                        title: 'Iban',
                        subTitle:
                            "${overViewProvider.overviewObject?.bank?.iban}",
                      ),
                      const CustomHeight10(),
                    ],
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Responsive.widthMultiplier! * 5),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CachedNetworkImage(
                          imageUrl:
                              overViewProvider.overviewObject?.image ?? "",
                          height: 200,
                        ),
                      ),
                      const CustomHeight10(),
                      const CustomDivider(),
                      const CustomHeight10(),
                      const HeadingWidgetCustom(
                        title: "Personal Details",
                      ),
                      SizedBox(
                        height: Responsive.heightMultiplier! * 2,
                      ),
                      UserDetailShowingWidget(
                        title: 'Name',
                        subTitle: overViewProvider.overviewObject?.username
                                ?.toUpperCase() ??
                            "",
                      ),
                      UserDetailShowingWidget(
                        title: 'Address',
                        subTitle:
                            overViewProvider.overviewObject?.address?.address ??
                                "",
                      ),
                      UserDetailShowingWidget(
                        title: 'City',
                        subTitle:
                            overViewProvider.overviewObject?.address?.city ??
                                "",
                      ),
                      UserDetailShowingWidget(
                        title: 'Pin Code',
                        subTitle: overViewProvider
                                .overviewObject?.address?.postalCode ??
                            "",
                      ),
                      UserDetailShowingWidget(
                        title: 'State',
                        subTitle:
                            overViewProvider.overviewObject?.address?.state ??
                                "",
                      ),
                      UserDetailShowingWidget(
                        title: 'Age',
                        subTitle:
                            overViewProvider.overviewObject?.age.toString() ??
                                "",
                      ),
                      UserDetailShowingWidget(
                        title: 'DOB',
                        subTitle: DateFormat('dd-MM-yyyy').format(
                            overViewProvider.overviewObject!.birthDate!),
                      ),
                      UserDetailShowingWidget(
                        title: 'Height',
                        subTitle:
                            "${overViewProvider.overviewObject?.height.toString()} cm",
                      ),
                      UserDetailShowingWidget(
                        title: 'Email',
                        subTitle: "${overViewProvider.overviewObject?.email}",
                      ),
                      UserDetailShowingWidget(
                        title: 'Eye Color',
                        subTitle:
                            "${overViewProvider.overviewObject?.eyeColor}",
                      ),
                      UserDetailShowingWidget(
                        title: 'Gender',
                        subTitle: "${overViewProvider.overviewObject?.gender}",
                      ),
                      UserDetailShowingWidget(
                        title: 'Hair Color',
                        subTitle:
                            "${overViewProvider.overviewObject?.hair?.color}",
                      ),
                      UserDetailShowingWidget(
                        title: 'Hair Type',
                        subTitle:
                            "${overViewProvider.overviewObject?.hair?.type}",
                      ),
                      UserDetailShowingWidget(
                        title: 'Phone',
                        subTitle: "${overViewProvider.overviewObject?.phone}",
                      ),
                      UserDetailShowingWidget(
                        maxLines: null,
                        title: 'University',
                        subTitle:
                            "${overViewProvider.overviewObject?.university}",
                      ),
                      UserDetailShowingWidget(
                        maxLines: 1,
                        title: 'Weight',
                        subTitle: "${overViewProvider.overviewObject?.weight}",
                      ),
                      const CustomHeight10(),
                      const CustomDivider(),
                      const CustomHeight10(),
                      const HeadingWidgetCustom(
                        title: "Bank Details",
                      ),
                      const CustomHeight10(),
                      UserDetailShowingWidget(
                        maxLines: 1,
                        title: 'Card Number',
                        subTitle:
                            "${overViewProvider.overviewObject?.bank?.cardNumber}",
                      ),
                      UserDetailShowingWidget(
                        maxLines: 1,
                        title: 'Card Expire',
                        subTitle:
                            "${overViewProvider.overviewObject?.bank?.cardExpire}",
                      ),
                      UserDetailShowingWidget(
                        maxLines: 1,
                        title: 'Card Type',
                        subTitle:
                            "${overViewProvider.overviewObject?.bank?.cardType}",
                      ),
                      UserDetailShowingWidget(
                        maxLines: 1,
                        title: 'Card Currency',
                        subTitle:
                            "${overViewProvider.overviewObject?.bank?.currency}",
                      ),
                      UserDetailShowingWidget(
                        maxLines: 1,
                        title: 'Iban',
                        subTitle:
                            "${overViewProvider.overviewObject?.bank?.iban}",
                      ),
                      const CustomHeight10(),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 2,
      thickness: 2,
    );
  }
}

class CustomHeight10 extends StatelessWidget {
  const CustomHeight10({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.heightMultiplier! * 2,
    );
  }
}

class HeadingWidgetCustom extends StatelessWidget {
  final String title;
  final double? size;
  const HeadingWidgetCustom({
    super.key,
    required this.title,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: size ?? Responsive.textMultiplier! * 1.8),
    );
  }
}
