import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:instagram/utils/colors.dart";

import "../widgets/post_card.dart";

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.inbox)),
        ],
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          'assets/ic_instagram.svg',
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          height: 32,
        ),
      ),
      body: const PostCard(),
    );
  }
}
