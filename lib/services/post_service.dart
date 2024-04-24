import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chisquarex/models/post.dart'; // Assuming chisquarex is your project name

class PostService {
  static Stream<List<Post>> getPostsStream() {
    final firestore = FirebaseFirestore.instance;
    return firestore.collection('posts').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Post(
          origin: data['origin'] ?? "",
          destination: data['destination'] ?? "",
          travelDate: (data['travelDate'] as Timestamp).toDate(),
          availableWeight: data['availableWeight'] ?? 0,
        );
      }).toList();
    });
  }
}
