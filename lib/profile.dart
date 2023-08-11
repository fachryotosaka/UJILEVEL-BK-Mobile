import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ujilevel_bk/auth/signIn.dart';
import 'package:ujilevel_bk/components/constant.dart';
import 'package:ujilevel_bk/components/textField.dart';
import 'package:ujilevel_bk/controllers/profile.dart';
import 'package:ujilevel_bk/editProfile.dart';
import 'package:ujilevel_bk/main.dart';
import 'package:ujilevel_bk/providers/auth.dart';
import 'package:ujilevel_bk/widgets/custom_snack_bar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? image;
  String? id;
  String? name;
  String? email;
  String? password;

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return;

      final imageTemporary = File(pickedImage.path);
      setState(() => this.image = imageTemporary);
      print(image!.path);
      Navigator.pop(context);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> deleteImage() async {
    try {
      setState(() => image = null);
      Navigator.pop(context);
    } on PlatformException catch (e) {
      print('Failed to delete image: $e');
    }
  }

  Future<void> uploadImage() async {
      // print(image!.path);
    if (image == null) {
      print('No image selected');
      return;
    }

    ProfileController controller = ProfileController();
    try {
      final uploadResult = await controller.addProfilePhoto(image!.path);
      // Handle the uploaded image result, e.g., store the image URL or display a success message
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> editProfile() async {
    ProfileController controller = ProfileController();

    try {
      String? userId = id; // Replace 1 with the actual user ID
      Map<String, dynamic> data = {
        'name': name,
        'email': email,
        'password': password,
      };

      await controller.updateProfile(userId, data);

    if (image != null) {
        final uploadResult = await controller.addProfilePhoto(image!.path);
    }
      
      // Handle the API response, e.g., display a success message
    } catch (e) {
      print('Error updating profile: $e');
      // Handle errors, e.g., show an error message to the user
    }
  }

  Future logout() async {
    // ignore: duplicate_ignore
    await Provider.of<Auth>(context, listen: false).logout();
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar(context, 'successfully logout', false));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => const HomePage())));
    }
  }

  Future update() async {
    try{
      uploadImage();
      editProfile();
    } catch (e) {
      print('Error updating profile: $e');
    }
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              title: const Text('Change Profile'),
              actions: [
                CupertinoActionSheetAction(
                    onPressed: () => pickImage(ImageSource.gallery),
                    child: Text(
                      'Pick Image',
                      style: GoogleFonts.poppins(fontSize: 15),
                    )
                ),
                CupertinoActionSheetAction(
                    onPressed: () => pickImage(ImageSource.camera),
                    child: Text(
                      'Take Photo',
                      style: GoogleFonts.poppins(fontSize: 15),
                    )
                ),
                CupertinoActionSheetAction(
                    onPressed: () => deleteImage(),
                    child: Text(
                      'Delete Image',
                      style: GoogleFonts.poppins(fontSize: 15),
                    )
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style:
                      GoogleFonts.poppins(fontSize: 16, color: Colors.red[400]),
                ),
              ),
          )
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: width * .05, vertical: height * .05),
        child: Consumer<Auth>(
          builder: (context, auth, child) {
            if (auth.authenticated) {
              id = auth.user!.id;
              return Column(
                children: [
                  Flexible(
                    flex: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              String.fromCharCode(
                                  CupertinoIcons.chevron_left.codePoint),
                              style: TextStyle(
                                  inherit: false,
                                  color: const Color(0xFF0F1828),
                                  fontSize: width * .045,
                                  fontWeight: FontWeight.w700,
                                  fontFamily:
                                      CupertinoIcons.chevron_left.fontFamily,
                                  package: CupertinoIcons
                                      .chevron_left.fontPackage),
                            ),
                          ),
                        ),

                        Spacer(),

                        Flexible(
                            flex: 20,
                            child: Center(
                              child: Text(
                                "Profile",
                                style: GoogleFonts.mPlus1(
                                    fontWeight: FontWeight.w700,
                                    color: CusColors.header,
                                    fontSize: width * .045),
                              ),
                            )
                        ),

                        GestureDetector(
                          onTap: () => Get.to(EditProfile(), transition: Transition.rightToLeftWithFade),
                          child: Icon(
                              Icons.edit_note_outlined,
                            color: CusColors.subHeader,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * .0,
                  ),
                  Flexible(
                    flex: 3,
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () => _showActionSheet(context),
                              child: CircleAvatar(
                                maxRadius: 58,
                                backgroundColor:
                                    const Color.fromARGB(255, 197, 197, 197),
                                child: image != null 
                                    ? CircleAvatar(
                                        maxRadius: 55,
                                        backgroundImage: FileImage(image!),
                                      )
                                    : CircleAvatar(
                                      maxRadius: 55,
                                      backgroundImage: NetworkImage(
                                        auth.user!.photo,
                                      ),
                                    )
                              ),
                            ),
                            SizedBox(
                              height: height * .022,
                            ),
                            Text(
                              auth.user?.name ?? '',
                              style: GoogleFonts.dmSans(
                                  color: const Color(0xFF181D27),
                                  fontWeight: FontWeight.w700,
                                  fontSize: width * .055),
                            ),
                            Text(
                              auth.user?.classroom ?? '',
                              style: GoogleFonts.dmSans(
                                  color: const Color(0xFFababab),
                                  fontSize: width * .035),
                            ),
                            SizedBox(
                              height: height * .045,
                            ),
                            Form(
                              child: Consumer<Auth>(
                                builder: (context, auth, child) {
                                  if (auth.authenticated) {
                                    return Column(
                                      children: [
                                        CusTextField(
                                            context,
                                            label: "Name",
                                            hint: auth.user?.name ?? '',
                                            radius: 8,
                                            enabled: false,
                                        ),
                                        CusTextField(
                                          context,
                                          label: "Email",
                                          hint: auth.user?.email ?? '',
                                          radius: 8,
                                          enabled: false
                                        ),
                                        CusTextField(
                                          context,
                                          label: "Class",
                                          hint: auth.user?.classroom ?? '',
                                          radius: 8,
                                          enabled: false,
                                        ),
                                        CusTextField(
                                            context,
                                            label: "Role",
                                            hint: auth.user?.role ?? '',
                                            radius: 8,
                                            enabled: false,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: height * .026),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: height * .05,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        begin: const Alignment(
                                                            -1.9, 0.0),
                                                        colors: [
                                                          CusColors.mainColor,
                                                          const Color(
                                                              0xFF19A7CE),
                                                        ]),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(.25),
                                                          spreadRadius: 0,
                                                          blurRadius: 20,
                                                          offset: const Offset(
                                                              0, 4))
                                                    ]),
                                                child: ElevatedButton(
                                                  onPressed: () => showAlert(
                                                      context,
                                                      title: "Logout Confirmation",
                                                      content: "Are you sure want to logout?",
                                                      onYes: () {
                                                        Navigator.pop(context);
                                                        logout();
                                                      }
                                                  ),
                                                  style: ButtonStyle(
                                                      shape: MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      8))),
                                                      padding:
                                                          MaterialStateProperty.all<EdgeInsetsGeometry>(
                                                              const EdgeInsets.all(
                                                                  20)),
                                                      backgroundColor:
                                                          MaterialStateProperty.all(
                                                              Colors.transparent),
                                                      shadowColor: MaterialStateProperty.all(Colors.transparent)),
                                                  child: Text('Logout',
                                                      style: GoogleFonts.mulish(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white,
                                                          fontSize:
                                                              width * .033,
                                                          letterSpacing: .5)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          ),
                                      ],
                                    );
                                  } else {
                                    return const SignIn();
                                  }
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const HomePage();
            }
          },
        ),
      ),
    );
  }

  Future<void> showAlert(BuildContext context, {
    required String? title,
    required String? content,
    required onYes,
    onNo
  }) async {
    await showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title ?? "Alert"),
          content: Text(content ?? "Are you sure?"),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              child: Text("Yes"),
              onPressed: onYes ?? () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: Text("No"),
              isDestructiveAction: true,
              onPressed: onNo ?? () => Navigator.pop(context),
            ),
          ],
        )
    );
  }
}
