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
import 'package:ujilevel_bk/main.dart';
import 'package:ujilevel_bk/providers/auth.dart';
import 'package:ujilevel_bk/widgets/custom_snack_bar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? image;
  String? id;
  String? email;
  String? password;

  bool onChange = false;
  TextEditingController emailController = new TextEditingController();

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return;

      final imageTemporary = File(pickedImage.path);
      setState(() => this.image = imageTemporary);
      setState(() {
        onChange = true;
      });
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

  Future update() async {
    try{
      uploadImage();
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

  void initState() {
    super.initState();


  }

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

                        Flexible(
                            flex: 20,
                            child: Center(
                              child: Text(
                                "Edit Profile",
                                style: GoogleFonts.mPlus1(
                                    fontWeight: FontWeight.w700,
                                    color: CusColors.header,
                                    fontSize: width * .045),
                              ),
                            )
                        ),
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
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircleAvatar(
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

                                  Positioned(
                                    right: 10,
                                    bottom: 8,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.fromARGB(255, 197, 197, 197),
                                      ),
                                      child: Icon(
                                          Icons.edit,
                                        color: Colors.black.withOpacity(.8),
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                ],
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

                            // Edit form start
                            Form(
                              child: Consumer<Auth>(
                                builder: (context, auth, child) {
                                  if (auth.authenticated) {
                                    return Column(
                                      children: [
                                        CusTextField(
                                          context,
                                          label: "Email",
                                          value: auth.user?.email ?? '',
                                          type: TextInputType.emailAddress,
                                          onChanged: (val) {
                                            onChange = true;
                                            print(auth.profile?.photo_path);
                                          },
                                        ),
                                        CusTextField(
                                          context,
                                          label: "Password",
                                          value: auth.user?.password ?? '',
                                          radius: 8,
                                          forPassword: true,
                                          onChanged: (val) => setState(() {
                                            onChange = true;
                                          })
                                        ),

                                        Container(
                                          margin: EdgeInsets.only(
                                              top: height * .23),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButton(
                                                onPressed: onChange ? () => showAlert(
                                                    context,
                                                    title: "Confirm Changes",
                                                    content: "Are you sure want to save all changes?",
                                                    onYes: () {
                                                      Navigator.pop(context);
                                                      Get.back();
                                                      update();
                                                    }
                                                ) : null,
                                                style: ButtonStyle(
                                                    minimumSize: MaterialStatePropertyAll(
                                                        Size(
                                                          width * .4,
                                                          height * .065,
                                                        )
                                                    ),
                                                    shape: MaterialStatePropertyAll(
                                                        RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(0),
                                                            side: BorderSide(
                                                                width: 1,
                                                                color: onChange ? Colors.black : Colors.black.withOpacity(.25)
                                                            )
                                                        )
                                                    ),
                                                    shadowColor: MaterialStatePropertyAll(Colors.transparent),
                                                    backgroundColor: MaterialStatePropertyAll(Colors.transparent)
                                                ),
                                                child: Text(
                                                  'Save',
                                                  style: GoogleFonts.mPlus1(
                                                      color: onChange ? Color(0xFF2c2c2c) : Color(0xFF2c2c2c).withOpacity(.25),
                                                      fontWeight: FontWeight.w700
                                                  ),
                                                ),
                                              ),

                                              AnimatedContainer(
                                                duration: Duration(milliseconds: 200),
                                                curve: Curves.easeInOut,
                                                decoration: BoxDecoration(
                                                  color: onChange ? Color(0xFF2c2c2c) : Color(0xFF2c2c2c).withOpacity(.25)
                                                ),
                                                child: ElevatedButton(
                                                  onPressed: onChange ?  () => showAlert(
                                                      context,
                                                      title: "Confirm Discard Changes",
                                                      content: "are you sure want to discard all changes?",
                                                      onYes: () {
                                                        Navigator.pop(context);
                                                        Get.back();
                                                      }
                                                  ) : () => Get.back(),
                                                  style: ButtonStyle(
                                                      minimumSize: MaterialStatePropertyAll(
                                                        Size(
                                                          width * .4,
                                                          height * .065,
                                                        ),
                                                      ),
                                                      shape: MaterialStatePropertyAll(
                                                          RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(0),
                                                            side: BorderSide(
                                                              width: 2,
                                                              color: Colors.black
                                                            )
                                                          ),
                                                      ),
                                                      backgroundColor: MaterialStatePropertyAll(Colors.black),
                                                  ),
                                                  child: Text(
                                                    'Back',
                                                    style: GoogleFonts.mPlus1(
                                                        fontWeight: FontWeight.w700,
                                                      color: Colors.white
                                                    ),
                                                  ),
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
