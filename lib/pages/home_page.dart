import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_parsing/pages/post_detail_page.dart';
import 'package:json_parsing/providers/async_posts.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPosts = ref.watch(asyncPostsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: asyncPosts.when(
        data: (posts) {
          if (posts.isEmpty) return const SizedBox();

          return RefreshIndicator(
            onRefresh: () async {
              ref.read(asyncPostsProvider.notifier).refresh();
            },
            child: ListView.separated(
              itemCount: posts.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (ctx, idx) {
                final post = posts[idx];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PostDetailPage(postId: post.id),
                      ),
                    );
                  },
                  title: Text(post.title),
                  subtitle: Text(post.body),
                );
              },
            ),
          );
        },
        error: (err, stack) => Center(
          child: Text('Error: $err'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
