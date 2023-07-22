import "package:flutter/material.dart";
import "package:instagram/utils/colors.dart";

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: const Text('Post To'),
          centerTitle: false,
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text(
                'Post',
                style: TextStyle(
                    color: Colors.blueAccent, fontWeight: FontWeight.bold),
              ),
            ),
          ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Navigator.pop(context);
            },
          ),
        ),
        body: Column(children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://images8.alphacoders.com/131/1318148.png',
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: const TextField(
                    maxLines: 8,
                    decoration: InputDecoration(
                      hintText: 'Write Caption...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                        'https://images8.alphacoders.com/131/1318148.png'),
                  ),
                ),
                const Divider(color: Colors.white, thickness: 0.5),
              ])
        ]));
  }
}
