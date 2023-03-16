import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:megafreepoint/app/modules/signup_module/signup_controller.dart';

import '../../components/my_button.dart';
import '../../data/provider/Globalvariable.dart';
/// GetX Template Generator - fb.com/htngu.99
///

class signupPage extends GetView<signupController> {

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final mobileNumberController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  final collegeNameContoller = TextEditingController().obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: HexColor("#fed8c3"),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(0, 300, 0, 0),
          shrinkWrap: true,
          reverse: true,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    Container(
                        // height: 535,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: HexColor("#ffffff"),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.offAllNamed('/loginpage');
                                  },
                                  child: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  width: 67,
                                ),
                                Text(
                                  "Sign Up",
                                  style: GoogleFonts.poppins(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor("#4f4f4f"),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: HexColor("#8d8d8d"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  TextField(
                                    autofillHints: const [AutofillHints.email],
                                    controller: emailController.value,
                                    onChanged: (value) {
                                      controller.validateEmail(value);
                                      controller.setEmail(value);
                                    },
                                    onSubmitted: (value) {
                                      controller.setEmail(value);
                                    },
                                    cursorColor: HexColor("#4f4f4f"),
                                    decoration: InputDecoration(
                                      hintText: "hello@gmail.com",
                                      fillColor: HexColor("#f0f3f1"),
                                      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                      hintStyle: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: HexColor("#8d8d8d"),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                    child: Text(
                                      controller.errorMessage.value,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Mobile Number",
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: HexColor("#8d8d8d"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  TextField(
                                    autofillHints: const [AutofillHints.telephoneNumber],
                                    onChanged: (value) {
                                      controller.setMobileNumber(value);
                                    },
                                    onSubmitted: (value) {
                                      controller.setMobileNumber(value);
                                    },
                                    controller: mobileNumberController.value,
                                    keyboardType: TextInputType.number,
                                    cursorColor: HexColor("#4f4f4f"),
                                    decoration: InputDecoration(
                                      hintText: "1234567890",
                                      fillColor: HexColor("#f0f3f1"),
                                      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                      hintStyle: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: HexColor("#8d8d8d"),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Name",
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: HexColor("#8d8d8d"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  TextField(
                                    autofillHints: const [AutofillHints.name],
                                    onChanged: (value) {
                                      controller.setName(value);
                                    },
                                    onSubmitted: (value) {
                                      controller.setName(value);
                                    },
                                    controller: nameController.value,
                                    cursorColor: HexColor("#4f4f4f"),
                                    decoration: InputDecoration(
                                      hintText: "Jack Smith",
                                      fillColor: HexColor("#f0f3f1"),
                                      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                      hintStyle: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: HexColor("#8d8d8d"),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Password",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: HexColor("#8d8d8d"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  TextField(
                                    autofillHints: const [AutofillHints.password],
                                    onChanged: (value) {
                                      controller.setPassword(value);
                                    },
                                    onSubmitted: (value) {
                                      controller.setPassword(value);
                                    },
                                    obscureText: true,
                                    controller: passwordController.value,
                                    cursorColor: HexColor("#4f4f4f"),
                                    decoration: InputDecoration(
                                      hintText: "*************",
                                      fillColor: HexColor("#f0f3f1"),
                                      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                      hintStyle: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: HexColor("#8d8d8d"),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      focusColor: HexColor("#44564a"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                              Obx(()=>controller.isloading? loader():MyButton(
                                      buttonText: 'Register',
                                      onPressed: () {
                                        if (controller.email != null &&
                                            controller.password != null &&
                                            controller.mobileNumber != null &&
                                            controller.name != null
                                        ) {
                                         controller.registerUser();
                                        }
                                      })),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Already have an account?",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: HexColor("#8d8d8d"),
                                            )),
                                        TextButton(
                                          child: Text(
                                            "Log In",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: HexColor("#44564a"),
                                            ),
                                          ),
                                          onPressed: () => Get.toNamed('/loginpage'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),),
                    Transform.translate(
                        offset: const Offset(0, -300),
                        child: Image.asset(
                          'assets/Images/plants2.png',
                          scale: 1.5,
                          width: double.infinity,
                        )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
