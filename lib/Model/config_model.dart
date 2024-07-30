import 'package:cloud_firestore/cloud_firestore.dart';

class ConfigModel {
  final String mobileRegex;
  final String nameRegex;
  final String textRegex;
  final String passwordRegex;
  final String ageRegex;
  final String genderRegex;

  ConfigModel({
    required this.textRegex,
    required this.mobileRegex,
    required this.passwordRegex,
    required this.nameRegex,
    required this.ageRegex,
    required this.genderRegex,
  });

  factory ConfigModel.fromDocument(DocumentSnapshot doc) {
    return ConfigModel(
      textRegex: doc['textRegex'],
      mobileRegex: doc['mobileRegex'],
      nameRegex: doc['nameRegex'],
      passwordRegex: doc['passwordRegex'],
      ageRegex: doc['ageRegex'],
      genderRegex: doc['genderRegex'],
    );
  }
}
