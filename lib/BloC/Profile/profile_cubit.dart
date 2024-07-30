import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> fetchUserData() async {
    try {
      emit(ProfileLoading());
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          emit(ProfileLoaded(userDoc.data() as Map<String, dynamic>));
        } else {
          emit(ProfileError('No user data found'));
        }
      } else {
        emit(ProfileError('No user is signed in'));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
