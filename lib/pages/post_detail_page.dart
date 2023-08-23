import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_parsing/providers/async_posts.dart';

class PostDetailPage extends HookConsumerWidget {
  const PostDetailPage({super.key, required this.postId});

  final int postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final post = ref.watch(fetchPostByIdProvider(postId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Post $postId'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: post.when(
          data: (post) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20),
                Text(
                  post.body,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            );
          },
          error: (err, stack) => Center(
            child: Text('Error: $err'),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
