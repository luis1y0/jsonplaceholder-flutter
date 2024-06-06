import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonplaceholder_posts/src/ui/bloc/post_bloc.dart';
import 'package:jsonplaceholder_posts/src/ui/widgets/placeholder_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ListTile(
          title: Text('Blog'),
          subtitle: Text('Somnio Software'),
        ),
      ),
      body: Column(
        children: [
          NavigationBar(
            selectedIndex: _currentTab,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home),
                label: 'HOME',
              ),
              NavigationDestination(
                icon: Icon(Icons.article),
                label: 'POST',
              ),
            ],
            onDestinationSelected: (value) {
              setState(() {
                _currentTab = value;
                _pageController.animateToPage(
                  value,
                  duration: const Duration(
                    milliseconds: 400,
                  ),
                  curve: Curves.easeInOut,
                );
              });
            },
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  _currentTab = value;
                });
              },
              children: [
                BlocBuilder<PostBloc, PostState>(
                  buildWhen: (previous, current) => current is PostResult,
                  builder: (context, state) {
                    if (state is PostResult) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          if (index >= state.posts.length) {
                            return const PlaceholderTile();
                          }
                          return ListTile(
                            title: Text(
                              state.posts[index].title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {},
                          );
                        },
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                const Center(
                  child: Text('Mi post'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
