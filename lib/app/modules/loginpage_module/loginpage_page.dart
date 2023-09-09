import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:validators/validators.dart';

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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // color: Colors.red.withOpacity(0.1),
            image: DecorationImage(
                image: NetworkImage(
                  // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShp2T_UoR8vXNZXfMhtxXPFvmDWmkUbVv3A40TYjcunag0pHFS_NMblOClDVvKLox4Atw&usqp=CAU',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx7IBkCtYd6ulSfLfDL-aSF3rv6UfmWYxbSE823q36sPiQNVFFLatTFdGeUSnmJ4tUzlo&usqp=CAU'),
                fit: BoxFit.cover,
                opacity: 0.3)),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.network(
                    // 'https://assets6.lottiefiles.com/private_files/lf30_ulp9xiqw.json', //shakeing lock
                      'https://assets6.lottiefiles.com/packages/lf20_k9wsvzgd.json',
                      animate: true,
                      height: 120,
                      width: 600),
                  // logo here
                  // Image.asset(
                  //   'assets/images/logo_new.png',
                  //   height: 120,
                  //   width: 120,
                  // ),
                  Text(
                    'Log In Now',
                    style: GoogleFonts.indieFlower(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  Text(
                    'Please login to continue using our app',
                    style: GoogleFonts.indieFlower(
                      textStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w300,
                          // height: 1.5,
                          fontSize: 15),
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    // height: controller.isEmailCorrect ? 280 : 200,
                    // _formKey!.currentState!.validate() ? 200 : 600,
                    // height: isEmailCorrect ? 260 : 182,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 1.1,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20, top: 20),
                          child: TextFormField(
                            autofillHints: const [AutofillHints.username],
                            controller: controller.emailController,
                            onChanged: (val) {
                              controller.isEmailCorrect = isEmail(val);
                            },
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.purple,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "Email",
                              hintText: 'your-email@domain.com',
                              labelStyle: TextStyle(color: Colors.purple),
                              // suffixIcon: IconButton(
                              //     onPressed: () {},
                              //     icon: Icon(Icons.close,
                              //         color: Colors.purple))
                            ),
                          ),
                        ),
                        Obx(() {
                          return Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Form(
                              key: controller.formKey,
                              child: TextFormField(
                                autofillHints: const [AutofillHints.password],
                                controller: controller.passwordController,
                                obscuringCharacter: '*',
                                obscureText: controller.obscuretext,
                                decoration: InputDecoration(
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: "Password",
                                  hintText: '*********',
                                  labelStyle: const TextStyle(
                                      color: Colors.purple),
                                  prefixIcon: const Icon(Icons.lock_outline,
                                    color: Colors.purple,),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.visibility,
                                      color: Colors.purple,),
                                    onPressed: () {
                                      controller.passwordvisibility();
                                    },),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty && value.length < 5) {
                                    return 'Enter a valid password';
                                  }
                                },
                              ),
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 20,
                        ),
                        Obx(() =>
                        controller.isEmailCorrect
                            ? controller.isloading ? loader() : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10.0)),
                                backgroundColor: controller.isEmailCorrect ==
                                    false
                                    ? Colors.red
                                    : Colors.purple,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 131, vertical: 20)
                              // padding: EdgeInsets.only(
                              //     left: 120, right: 120, top: 20, bottom: 20),
                            ),
                            onPressed: () {
                              if (controller.formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                controller.signUserIn();
                              }
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => loginScreen()));
                            },
                            child: const Text(
                              'Log In',
                              style: TextStyle(fontSize: 17),
                            ))
                            : Container()),
                      ],
                    ),
                  ),

                  //this is button
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  // ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10.0)),
                  //         backgroundColor: Colors.purple,
                  //         padding: EdgeInsets.symmetric(
                  //             horizontal: MediaQuery.of(context).size.width / 3.3,
                  //             vertical: 20)
                  //         // padding: EdgeInsets.only(
                  //         //     left: 120, right: 120, top: 20, bottom: 20),
                  //         ),
                  //     onPressed: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => loginScreen()));
                  //     },
                  //     child: Text(
                  //       'Sounds Good!',
                  //       style: TextStyle(fontSize: 17),
                  //     )), //

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'You have\'t any account?',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed("/signup");
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
