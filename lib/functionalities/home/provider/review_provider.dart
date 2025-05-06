import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ReviewProvider extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> _reviews = [];
  List<Map<String, dynamic>> get reviews => _reviews;

  Future<void> fetchReviews(String itemId) async {
    try {
      final querySnapshot = await firestore
          .collection('reviews')
          .where('item_id', isEqualTo: itemId)
          .orderBy('created_at', descending: true)
          .get();

      _reviews = querySnapshot.docs.map((doc) => doc.data()).toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching reviews: $e');
    }
  }

  Future<void> submitReview(
      {required String itemId,
      required String userId,
      required String username,
      required double rating,
      required String comment,
      required String foodName,
      required String foodCategory,
      required String averageRating}) async {
    try {
      final databaseBox = Hive.box('userProfile');
      final id = await databaseBox.get("userid");

      final reviewData = {
        'item_id': itemId,
        'user_id': userId,
        'username': username,
        'rating': rating,
        'comment': comment,
        'foodName': foodName,
        'foodCategory': foodCategory,
        'averageRating': averageRating,
        'created_at': Timestamp.now(),
      };

      await firestore
          .collection('users')
          .doc(id)
          .collection("reviews")
          .add(reviewData);

      await firestore.collection('reviews').add(reviewData);

      await fetchReviews(itemId);
    } catch (e) {
      debugPrint('Error submitting review: $e');
    }
  }
}
