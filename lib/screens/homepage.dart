import 'package:flutter/material.dart';
import 'package:interviewposts/services/apiservices.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> posts = [];
  bool isPostsLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    print(posts);
  }

  fetchData() async {
    posts = await ApiServices().getPosts();

    setState(() {
      isPostsLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Posts App'),
        ),
      ),
      body: Visibility(
        visible: isPostsLoaded,
        child: ListView.builder(
            itemCount: 30,
            itemBuilder: (context, index) {
              final post = posts[index];
              final userID = post['userId'];
              final postTitle = post['title'];
              final postBody = post['body'];

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.lightBlue[100],
                  child: Text(
                    userID.toString(),
                  ),
                ),
                title: Text(postTitle.toString()),
                subtitle: Text(
                  postBody.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }),
        replacement: Center(
          child: LoadingAnimationWidget.twistingDots(
            leftDotColor: const Color(0xFF1A1A3F),
            rightDotColor: const Color(0xFFEA3799),
            size: 200,
          ),
        ),
      ),
    );
  }
}
