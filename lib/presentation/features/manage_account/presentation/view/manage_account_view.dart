import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_user_details_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class ManageAccountView extends ConsumerStatefulWidget {
  const ManageAccountView({super.key});
  static const routeName = '/manageAccountView';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ManageAccountViewState();
}

class _ManageAccountViewState extends ConsumerState<ManageAccountView> {
  @override
  void initState() {
    super.initState();
    getUserName();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getUserDetailsNotifier.notifier).getUserDetails();
    });
  }

  String userName = '';
  String userEmail = '';

  getUserName() async {
    final name = await AppDataStorage().getUserAccountName();
    final email = await AppDataStorage().getUserEmail();

    setState(() {
      userName = name.toString();
      userEmail = email.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userDetails = ref.watch(getUserDetailsNotifier.select((v) => v.data));
    return Scaffold(
      appBar: const LaxmiiAppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          // CircleAvatar(
                          //     radius: 50,
                          //     backgroundImage: userDetails?.profilePicture !=
                          //                 null &&
                          //             userDetails!.profilePicture!.isNotEmpty
                          //         ? NetworkImage(userDetails.profilePicture!)
                          //         : const AssetImage(
                          //             'assets/images/account_image.png')
                          //     //  NetworkImage(userDetails?.profilePicture ?? ''),
                          //     ),

                          CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                userDetails?.profilePicture != null &&
                                        userDetails!.profilePicture!.isNotEmpty
                                    ? CachedNetworkImageProvider(
                                        userDetails.profilePicture!)
                                    : const AssetImage(
                                            'assets/images/account_image.png')
                                        as ImageProvider,
                            onBackgroundImageError: (_, __) {
                              // Handle error if needed (e.g., logging)
                            },
                            child: userDetails?.profilePicture == null ||
                                    userDetails!.profilePicture!.isEmpty
                                ? Image.asset(
                                    'assets/images/account_image.png') // Ensures a default image
                                : null,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                  right: 110,
                  top: 25,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: AppColors.primary14131A,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: AppColors.white,
                    ),
                  ),
                )
              ],
            ),
            const VerticalSpacing(8),
            Text(
              userName,
              style: context.textTheme.s20w600.copyWith(
                color: AppColors.primaryEBEBF5,
              ),
            ),
            const VerticalSpacing(8),
            Text(
              userEmail,
              style: context.textTheme.s14w400.copyWith(
                color: AppColors.primary808080,
              ),
            ),
            const VerticalSpacing(28),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Account',
                style: context.textTheme.s14w400.copyWith(
                    color: AppColors.primaryC4C4C4,
                    fontWeight: FontWeight.w300),
              ),
            ),
            const VerticalSpacing(10),
            ManageAccountWidget(
              title: 'Name',
              subTitle: userName,
            ),
            const VerticalSpacing(10),
            ManageAccountWidget(
              title: 'Email',
              subTitle: userEmail,
            ),
            const VerticalSpacing(10),
            const ManageAccountWidget(
              title: 'Your plan',
              subTitle: 'Free',
              subTitleColor: AppColors.primaryColor,
            ),
          ],
        ),
      )),
    );
  }
}

class ManageAccountWidget extends StatelessWidget {
  const ManageAccountWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      this.subTitleColor});
  final String title;
  final String subTitle;
  final Color? subTitleColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary101010),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: context.textTheme.s14w500.copyWith(
              color: AppColors.primary5E5E5E,
            ),
          ),
          Text(
            subTitle,
            style: context.textTheme.s14w500.copyWith(
              color: subTitleColor ?? AppColors.primary5E5E5E,
            ),
          )
        ],
      ),
    );
  }
}
