import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../models/post.dart';
import '../services/post_service.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Travel Routes"),
      ),
      body: StreamBuilder<List<Post>>(
        stream: PostService.getPostsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final List<Post> posts = snapshot.data ?? [];

          if (posts.isEmpty) {
            // Display message when no travel routes are available
            return const Center(
              child: Text(
                'No travel routes currently available',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: SvgPicture.asset(
                    'assets/icons/plane.svg', // Path to your SVG file
                    width: 40, // Adjust the width as needed
                    height: 40, // Adjust the height as needed
                  ),
                  title: Text(
                    "${posts[index].origin} - ${posts[index].destination}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Travel Date: ",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            posts[index].travelDate.toString().split(" ")[0],
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4), // Adjust spacing between lines
                      Row(
                        children: [
                          const Text(
                            "Weight Allowed: ",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "${posts[index].availableWeight}kg",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                  tileColor: Colors.grey[100],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
