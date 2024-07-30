import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/Language/key_lang.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RegisterCubit() : super(RegisterInitial());

  void verifyPhoneNumber(String phoneNumber) async {
    emit(RegisterLoading());

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        emit(RegisterSuccess());
      },
      verificationFailed: (FirebaseAuthException e) {
        emit(RegisterError(e.message ?? KeyLang.verificationFailed.tr()));
      },
      codeSent: (String verificationId, int? resendToken) {
        emit(PhoneCodeSent(verificationId));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<UserCredential?> verifyOTP({
    required String verificationId,
    required String smsCode,
    required String phone,
  }) async {
    emit(RegisterLoading());

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      emit(RegisterSuccess());

      return userCredential;
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
    return null;
  }

  saveToDatabase(
      {required String phone,
      required String age,
      required String gender,
      required String fullName,
      required String password,
      required UserCredential userCredential}) async {
    var bytes = utf8.encode(password);
    var hashedPassword = sha256.convert(bytes).toString();

    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'fullName': fullName,
      'phone': phone,
      'age': age,
      'gender': gender,
      'password': hashedPassword
    });

    emit(RegisterSuccess());
  }
}
