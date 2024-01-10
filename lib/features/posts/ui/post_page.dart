import 'package:flutter/material.dart';
import 'package:flutter_sbloc_api/features/posts/sbloc/posts_events.dart';
import 'package:flutter_sbloc_api/features/posts/sbloc/posts_sbloc.dart';
import 'package:flutter_sbloc_api/simplified_bloc.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  void initState() {
    ApiSbloc().postInitialFetchEvent();
    print(ApiSbloc().posts.length);
    print("is Api works well.......?");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Posts-SBloc',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500)),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () {},
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            )),
        body: SimplifiedBlocBuilder(
            bloc: ApiSbloc(),
            eventFilter: [
              ApiEvents.postInitialFetchEvent,
              ApiEvents.postAddEvent,
            ],
            builder: (BuildContext context, dynamic state) {
              ApiSbloc bloc = state;
              return Container(
                child: ListView.builder(
                  itemCount: bloc.posts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(20),
                        shadowColor: Colors.red,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue.shade400,
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bloc.posts[index].title,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                              ),
                              Text(
                                bloc.posts[index].body,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }));
  }
}
