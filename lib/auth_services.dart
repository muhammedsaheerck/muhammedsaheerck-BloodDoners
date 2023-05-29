import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testfire/Screens/screen_otp.dart';

class AuthServices {
  EmailOTP myauth = EmailOTP();
  static signupUser(String email, String password, String name, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
      EmailOTP myauth = EmailOTP();
      myauth.setConfig(
          appEmail: "contact@blooddoners.com",
          appName: "Blood doners app  OTP",
          userEmail: email,
          otpLength: 4,
          otpType: OTPType.digitsOnly);
      if (await myauth.sendOTP() == true) {
        await saveUser(name, email, userCredential.user!.uid);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("OTP has been sent"),
        ));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpScreen(
                      myauth: myauth,
                    )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Oops, OTP send failed"),
        ));
      }

      // ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text('Registration Successful')));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password Provided is too weak')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email Provided already Exists')));
      }
      log(e.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  static signinUser(String email, String password, context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('You are Logged in')));
      Navigator.of(context).pushNamed("/");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No user Found with this Email')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password did not match')));
      }
    }
  }

  static saveUser(String name, String emil, String id) async {
    final CollectionReference user =
        FirebaseFirestore.instance.collection("users");
    final data = {
      "name": name,
      "email": emil,
    };
    await user.doc(id).set(data);
  }

  static logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
