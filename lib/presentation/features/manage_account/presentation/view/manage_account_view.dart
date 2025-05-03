import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_user_details_notifier.dart';
import 'package:laxmii_app/presentation/features/manage_account/data/model/update_profile_request.dart';
import 'package:laxmii_app/presentation/features/manage_account/presentation/notifier/update_profile_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_form_field.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class ManageAccountView extends ConsumerStatefulWidget {
  const ManageAccountView({super.key});
  static const routeName = '/manageAccountView';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ManageAccountViewState();
}

class _ManageAccountViewState extends ConsumerState<ManageAccountView> {
  final _businessNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _accountNameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _bankController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getUserName();
    populateProfileFields();
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

  File? _pickedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      imageQuality: 85,
    );
    if (picked != null) {
      setState(() => _pickedImage = File(picked.path));

      //  ref.read(updateProfileNotifier.notifier).updateProfile(data: data, onError: onError, onSuccess: onSuccess)
    }
  }

  Future<void> populateProfileFields() async {
    // final profileResponse = await AppDataStorage().getStoredProfile();
    final profileResponse = await AppDataStorage().getUserDetails();

    final profile = profileResponse?.profile;
    if (profile == null) return;

    _businessNameController.text = profile.businessName ?? '';
    _phoneNumberController.text = profile.phoneNumber ?? '';
    _addressController.text = profile.address ?? '';
    _accountNameController.text = profile.accountName ?? '';
    _accountNumberController.text = profile.accountNumber ?? '';
    _bankController.text = profile.bankName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final userDetails = ref.watch(getUserDetailsNotifier.select((v) => v.data));
    final colorScheme = Theme.of(context);
    final isLoading =
        ref.watch(updateProfileNotifier.select((v) => v.state.isLoading));
    return Scaffold(
      appBar: const LaxmiiAppBar(),
      body: PageLoader(
        isLoading: isLoading,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: _pickImage,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: _pickedImage != null
                                      ? FileImage(_pickedImage!)
                                          as ImageProvider
                                      : (userDetails?.profile?.profilePicture !=
                                                  null &&
                                              userDetails!.profile!
                                                  .profilePicture!.isNotEmpty
                                          ? CachedNetworkImageProvider(
                                              userDetails
                                                  .profile!.profilePicture!)
                                          : const AssetImage(
                                              'assets/images/account_image.png')),
                                  onBackgroundImageError: (_, __) {
                                    // Handle error if needed
                                  },
                                  child: _pickedImage == null &&
                                          (userDetails?.profile
                                                      ?.profilePicture ==
                                                  null ||
                                              userDetails!.profile!
                                                  .profilePicture!.isEmpty)
                                      ? Image.asset(
                                          'assets/images/account_image.png')
                                      : null,
                                ),
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
                    color: colorScheme.colorScheme.onSurface,
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
                const VerticalSpacing(10),
                LaxmiiFormfield(
                  hasIcon: false,
                  backgroundColor: Colors.transparent,
                  hintStyle: const TextStyle(
                    color: AppColors.primary808080,
                  ),
                  label: 'Business name',
                  hintText: 'Enter business name',
                  controller: _businessNameController,
                ),
                const VerticalSpacing(10),
                LaxmiiFormfield(
                  backgroundColor: Colors.transparent,
                  hasIcon: false,
                  label: 'Phone number',
                  hintStyle: const TextStyle(
                    color: AppColors.primary808080,
                  ),
                  hintText: 'Enter phone number',
                  keyboardType: TextInputType.phone,
                  controller: _phoneNumberController,
                ),
                const VerticalSpacing(10),
                LaxmiiFormfield(
                  hasIcon: false,
                  backgroundColor: Colors.transparent,
                  label: 'Address',
                  hintStyle: const TextStyle(
                    color: AppColors.primary808080,
                  ),
                  hintText: 'Enter address',
                  controller: _addressController,
                ),
                const VerticalSpacing(10),
                LaxmiiFormfield(
                  hasIcon: false,
                  backgroundColor: Colors.transparent,
                  label: 'Account name',
                  hintStyle: const TextStyle(
                    color: AppColors.primary808080,
                  ),
                  hintText: 'Enter account name',
                  controller: _accountNameController,
                ),
                const VerticalSpacing(10),
                LaxmiiFormfield(
                  hasIcon: false,
                  backgroundColor: Colors.transparent,
                  label: 'Account number',
                  hintStyle: const TextStyle(
                    color: AppColors.primary808080,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  hintText: 'Enter account number',
                  controller: _accountNumberController,
                ),
                const VerticalSpacing(10),
                LaxmiiFormfield(
                  hasIcon: false,
                  backgroundColor: Colors.transparent,
                  label: 'Bank name',
                  hintStyle: const TextStyle(
                    color: AppColors.primary808080,
                  ),
                  hintText: 'Enter bank name',
                  controller: _bankController,
                ),
                const VerticalSpacing(40),
                LaxmiiSendButton(
                    onTap: () {
                      _updateProfile();
                    },
                    title: 'Update profile'),
                const VerticalSpacing(40),
              ],
            ),
          ),
        )),
      ),
    );
  }

  void _updateProfile() {
    final data = UpdateProfileRequest(
      accountName: _accountNameController.text.trim(),
      businessName: _businessNameController.text.trim(),
      phoneNumber: _phoneNumberController.text.trim(),
      address: _addressController.text.trim(),
      accountNumber: _accountNumberController.text.trim(),
      bankName: _bankController.text.trim(),
    );
    ref.read(updateProfileNotifier.notifier).updateProfile(
        data: data,
        onError: (error) {
          context.showError(message: error);
        },
        onSuccess: (message) {
          context.showSuccess(message: message);
          ref.read(getUserDetailsNotifier.notifier).getUserDetails();
        },
        imagePath: _pickedImage?.path ?? '');
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
