import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Model/config_model.dart';

class ConfigRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ConfigModel> fetchSystemConfig() async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('config').doc('systemConfig').get();
      return ConfigModel.fromDocument(doc);
    } catch (e) {
      throw Exception('Error fetching system configuration: $e');
    }
  }
}
