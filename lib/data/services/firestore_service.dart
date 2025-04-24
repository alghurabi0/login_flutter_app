import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:login/data/repositories/authentication_repository.dart';
import 'package:login/features/authentication/models/user_model.dart';
import 'package:login/utils/exceptions/firebase_exceptions.dart';
import 'package:login/utils/exceptions/format_exceptions.dart';
import 'package:login/utils/exceptions/platform_exceptions.dart';

class FirestoreService extends GetxController {
  static FirestoreService get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to fetch user details based on username.
  Future<UserModel> fetchUserDetails(String username, String password) async {
    try {
      final documentSnapshot =
          await _db
              .collection("Users")
              .where("username", isEqualTo: username)
              .get();
      if (documentSnapshot.docs.isNotEmpty) {
        // Check if the password matches
        final userData = documentSnapshot.docs.first.data();
        if (userData['password'] != password) {
          throw Exception("المعطيات المدخلة غير صحيحة");
        }
        return UserModel.fromSnapshot(documentSnapshot.docs.first);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'حدث خطأ غير معروف, يرجى المحاولة لاحقًا';
    }
  }

  /// Function to fetch user details based on id.
  Future<UserModel> fetchUserDetailsById(String id) async {
    try {
      final documentSnapshot = await _db.collection("Users").doc(id).get();

      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'حدث خطأ غير معروف, يرجى المحاولة لاحقًا';
    }
  }

  /// Function to update user data in Firestore.
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.currentUser.id)
          .update(updatedUser.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
