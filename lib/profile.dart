import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ujilevel_bk/auth/signIn.dart';
import 'package:ujilevel_bk/components/constant.dart';
import 'package:ujilevel_bk/controllers/profile.dart';
import 'package:ujilevel_bk/main.dart';
import 'package:ujilevel_bk/providers/auth.dart';
import 'package:ujilevel_bk/widgets/custom_snack_bar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // File? image;

  // Future pickImage() async {
  //   try{
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if(image == null) return;

  //     final imageTemporary = File(image.path);
  //     setState(() => this.image = imageTemporary);
  //   } on PlatformException catch(e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

   File? image;

  Future<void> pickImage() async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;

      final imageTemporary = File(pickedImage.path);
      setState(() => image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> uploadImage() async {
    if (image == null) {
      print('No image selected');
      return;
    }

    ProfileController controller = ProfileController();
    try {
      final uploadResult = await controller.addProfilePhoto(image!.path);
      // Handle the uploaded image result, e.g., store the image URL or display a success message
      print('Upload result: successfully?');
    } catch (e) {
      print('Error uploading image: $e');
    }
  }



  Future submit() async {
    // ignore: duplicate_ignore
    await Provider.of<Auth>(context, listen: false).logout();
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar(context, 'successfully logout', false));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => const HomePage())));
    }
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
              return Column(
                children: [
                  Flexible(
                    flex: 0,
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: GestureDetector(
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
                        ),
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
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * .01,
                  ),
                  Flexible(
                    flex: 3,
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () => pickImage(),
                              child: CircleAvatar(
                                  maxRadius: 58,
                                  backgroundColor: const Color(0xFF979797),
                                  child: image != null
                                      ? CircleAvatar(
                                          maxRadius: 55,
                                          backgroundImage: FileImage(image!),
                                        )
                                      : const CircleAvatar(
                                          maxRadius: 55,
                                          backgroundImage:
                                              AssetImage('images/rendang.jpg'),
                                        )),
                            ),
                            SizedBox(
                              height: height * .022,
                            ),
                            Text(
                              auth.user?.name ?? '',
                              style: GoogleFonts.dmSans(
                                  color: const Color(0xFF181D27),
                                  fontWeight: FontWeight.w700,
                                  fontSize: width * .05),
                            ),
                            Text(
                              auth.user?.name ?? '',
                              style: GoogleFonts.dmSans(
                                  color: const Color(0xFFababab),
                                  fontSize: width * .03),
                            ),
                            SizedBox(
                              height: height * .055,
                            ),
                            const UserProfile(),
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
}

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Form(
      child: Consumer<Auth>(
        builder: (context, auth, child) {
          if (auth.authenticated) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: height * .026),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: GoogleFonts.mPlus1(
                            fontWeight: FontWeight.w500,
                            color: CusColors.subHeader.withOpacity(.25),
                            fontSize: width * .028),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: auth.user?.name ?? '',
                            hintStyle: GoogleFonts.mulish(
                              color: CusColors.header.withOpacity(.6),
                              fontSize: width * .034,
                              fontWeight: FontWeight.w500,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 18),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: CusColors.subHeader.withOpacity(.2),
                                    width: 1.5)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: CusColors.subHeader.withOpacity(.5),
                                  width: 1.5),
                            )),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: height * .026),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Class",
                        style: GoogleFonts.mPlus1(
                          fontWeight: FontWeight.w600,
                          color: CusColors.subHeader.withOpacity(.3),
                          fontSize: width * .03,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: auth.user?.classroom ?? '',
                            hintStyle: GoogleFonts.mulish(
                              color: CusColors.header.withOpacity(.6),
                              fontSize: width * .034,
                              fontWeight: FontWeight.w500,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 18),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: CusColors.subHeader.withOpacity(.2),
                                    width: 1.5)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: CusColors.subHeader.withOpacity(.5),
                                  width: 1.5),
                            )),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: height * .026),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Role",
                        style: GoogleFonts.mPlus1(
                          fontWeight: FontWeight.w600,
                          color: CusColors.subHeader.withOpacity(.3),
                          fontSize: width * .03,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: auth.user?.role ?? '',
                            hintStyle: GoogleFonts.mulish(
                              color: CusColors.header.withOpacity(.6),
                              fontSize: width * .034,
                              fontWeight: FontWeight.w500,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 18),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: CusColors.subHeader.withOpacity(.2),
                                  width: 1.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: CusColors.subHeader.withOpacity(.5),
                                  width: 1.5),
                            )),
                      ),
                      SizedBox(
                        height: height * .05,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: const Alignment(-1.9, 0.0),
                                colors: [
                                  CusColors.mainColor,
                                  const Color(0xFF19A7CE),
                                ]),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(.25),
                                  spreadRadius: 0,
                                  blurRadius: 20,
                                  offset: const Offset(0, 4))
                            ]),
                        child: ElevatedButton(
                          onPressed: () => Get.to(const SignIn(),
                              transition: Transition.circularReveal),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      const EdgeInsets.all(20)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              shadowColor: MaterialStateProperty.all(
                                  Colors.transparent)),
                          child: Text('Logout',
                              style: GoogleFonts.mulish(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: width * .033,
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
    );
  }
}
