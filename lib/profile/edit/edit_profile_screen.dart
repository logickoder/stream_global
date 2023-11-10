import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/assets.dart';
import '../../app/dimens.dart';
import '../../app/widgets/profile_avatar.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _image = StateProvider<String?>((ref) => null);
  final _username = TextEditingController();
  final _fullName = TextEditingController();
  final _email = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      // final user = ref.read(profileController).user;
      // if (user == null) return;
      //
      // _username.text = user.username;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final user = ModalRoute.of(context)?.settings.arguments as User?;
    // if (user != null) {
    //   _username.text = user.username;
    //   _zodiacSign.text = user.zodiacSign ?? '';
    //   _about.text = user.about ?? '';
    //   _schoolLevel.text = user.schoolLevel ?? '';
    //   _ageRange.text = user.ageRange ?? '';
    //   _gender.text = user.gender ?? '';
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(AppDimens.secondaryPadding),
          children: [
            Align(
              alignment: Alignment.center,
              child: Consumer(
                builder: (context, ref, child) {
                  // final oldImage = ref.read(
                  //   profileController
                  //       .select((value) => value.user?.profilePicture),
                  // );
                  final newImage = ref.watch(_image);
                  return GestureDetector(
                    onTap: _selectPhoto,
                    child: FractionallySizedBox(
                      widthFactor: .51,
                      child: Stack(
                        children: [
                          ProfileAvatar(
                            url: newImage,
                            isFile: newImage != null,
                          ),
                          Positioned(
                            bottom: AppDimens.secondaryPadding,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                AppAssets.cameraIcon,
                                width: AppDimens.padding,
                                height: AppDimens.padding,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppDimens.padding),
            TextFormField(
              controller: _fullName,
              decoration: const InputDecoration(
                labelText: 'Enter your full name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Your full name is required';
                }
                return null;
              },
            ),
            const SizedBox(height: AppDimens.secondaryPadding),
            TextFormField(
              controller: _email,
              readOnly: true,
            ),
            const SizedBox(height: AppDimens.secondaryPadding),
            TextFormField(
              controller: _username,
              decoration: const InputDecoration(
                labelText: 'Enter your username',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Username is required';
                }
                return null;
              },
            ),
            const SizedBox(height: AppDimens.secondaryPadding),
            SizedBox(
              width: double.infinity,
              child: Consumer(
                builder: (context, ref, child) {
                  // final loading = ref.watch(
                  //   profileController.select(
                  //         (value) => value.editProfileLoading,
                  //   ),
                  // );
                  final loading = false;
                  return FilledButton(
                    onPressed: loading ? null : _submitForm,
                    child: Text(
                      loading ? 'please wait...' : 'Save Changes',
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _username.dispose();
    _fullName.dispose();
    _email.dispose();
    super.dispose();
  }

  void _selectPhoto() {
    // ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
    //   if (image == null) return;
    //
    //   ref.read(_image.notifier).state = image.path;
    // });
  }

  void _submitForm() {
    if (_form.currentState?.validate() != true) return;
    // final response = ref.read(profileController.notifier).updateUserProfile(
    //   username: _username.text,
    //   zodiacSign: _zodiacSign.text,
    //   about: _about.text,
    //   ageRange: _ageRange.text,
    //   gender: _gender.text,
    //   schoolLevel: _schoolLevel.text,
    //   profilePicture: ref.read(_image),
    // );
    //
    // response.then((_) {
    //   Navigator.pop(context);
    // }).catchError((e, _) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text(e.toString())),
    //   );
    // });
  }
}
