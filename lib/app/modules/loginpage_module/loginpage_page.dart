import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../components/my_button.dart';
import '../../components/my_textfield.dart';
import '../../data/provider/Globalvariable.dart';
import 'loginpage_controller.dart';
/// GetX Template Generator - fb.com/htngu.99
///

class loginpagePage extends GetView<loginpageController> {
  const loginpagePage({super.key});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: HexColor("#fed8c3"),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(0, 400, 0, 0),
          shrinkWrap: true,
          // reverse: true,
          children: [
            Stack(
              children: [
                Container(
                  height: 535,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: HexColor("#ffffff"),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Log In",
                          style: GoogleFonts.poppins(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: HexColor("#4f4f4f"),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: HexColor("#8d8d8d"),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              MyTextField(
                                autofillHints: const [AutofillHints.username],
                                onChanged: (() {
                                  controller.validateEmail(controller.emailController.text);
                                }),
                                controller: controller.emailController,
                                hintText: "hello@gmail.com",
                                obscureText: false,
                                prefixIcon: const Icon(Icons.mail_outline),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Text(
                                  controller.errorMessage,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Password",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: HexColor("#8d8d8d"),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              MyTextField(
                                autofillHints: const [AutofillHints.password],
                                controller: controller.passwordController,
                                hintText: "**************",
                                obscureText: controller.obscuretext,
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(icon:const Icon(Icons.visibility),
                                  onPressed: (){
                                    controller.passwordvisibility();
                                  },),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                          Obx(()=>controller.isloading? loader():MyButton(
                                onPressed: controller.signUserIn,
                                buttonText: 'Submit',
                              )),
                              const SizedBox(
                                height: 12,
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(35, 0, 0, 0),
                                child: Row(
                                  children: [
                                    Text("Don't have an account?",
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color: HexColor("#8d8d8d"),
                                        )),
                                    TextButton(
                                      child: Text(
                                        "Sign Up",
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color: HexColor("#44564a"),
                                        ),
                                      ),
                                      onPressed: () => Get.toNamed("/signup"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Positioned(
                //   top: 20,
                //   child: Image.asset(
                //     'assets/Images/plants2.png',
                //     scale: 1.5,
                //     width: double.infinity,
                //   ),
                // ),
                Transform.translate(
                  offset: Offset(0, -(Get.height/2)-100),
                  child: Image.asset(
                    'assets/Images/plants2.png',
                    scale: 1.5,
                    width: double.infinity,
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
