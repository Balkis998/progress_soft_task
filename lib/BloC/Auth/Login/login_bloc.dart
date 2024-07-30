import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import '../../../Language/key_lang.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  String phoneNumber = '';
  String password = '';
  String verificationId = '';

  LoginCubit() : super(AuthInitial());

  // Used to save token for user
  Future<void> _saveToken(String token) async {
    await _secureStorage.write(key: 'user_token', value: token);
  }

  void phoneNumberChanged(String phoneNumber) {
    this.phoneNumber = phoneNumber;
  }

  void passwordChanged(String password) {
    this.password = password;
  }

  Future<void> sendCodePressed() async {
    emit(AuthLoading());
    try {
      final usersQuery = await _firestore
          .collection('users')
          .where('phone', isEqualTo: phoneNumber)
          .get();

      if (usersQuery.docs.isEmpty) {
        emit(UserNotRegistered());
        return;
      }

      final userDoc = usersQuery.docs.first;
      final storedHashedPassword = userDoc['password'];
      final inputHashedPassword =
          sha256.convert(utf8.encode(password)).toString();

      if (storedHashedPassword != inputHashedPassword) {
        emit(AuthFailure(KeyLang.incorrectPassword.tr()));
        return;
      }

      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          if (!isClosed) {
            String token = await _auth.currentUser!.getIdToken() ?? '';
            await _saveToken(token);
            emit(AuthSuccess());
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          if (!isClosed) {
            emit(AuthFailure(e.message ?? KeyLang.verificationFailed.tr()));
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId = verificationId;
          if (!isClosed) {
            emit(AuthCodeSent(verificationId));
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId = verificationId;
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(AuthFailure(e.toString()));
      }
    }
  }

  Future<UserCredential?> verifyOTP({
    required String verificationId,
    required String smsCode,
  }) async {
    emit(AuthLoading());

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        String token = await user.getIdToken() ?? '';
        await _saveToken(token);
        emit(AuthSuccess());
        return userCredential;
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
    return null;
  }
}
