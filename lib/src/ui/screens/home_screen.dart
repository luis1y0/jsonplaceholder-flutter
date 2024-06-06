import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonplaceholder_posts/app_messages.dart';
import 'package:jsonplaceholder_posts/src/ui/bloc/post_bloc.dart';
import 'package:jsonplaceholder_posts/src/ui/widgets/placeholder_tile.dart';
import 'package:jsonplaceholder_posts/src/ui/widgets/post_widget.dart';

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
          title: Text(AppMessages.screenTitle),
          subtitle: Text(AppMessages.companyName),
        ),
      ),
      body: Column(
        children: [
          NavigationBar(
            selectedIndex: _currentTab,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home),
                label: AppMessages.tabHome,
              ),
              NavigationDestination(
                icon: Icon(Icons.settings),
                label: AppMessages.tabSettings,
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                            return PostWidget(
                              post: state.posts[index],
                            );
                          },
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                  const Placeholder(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
