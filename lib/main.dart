import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:jsonplaceholder_posts/app_messages.dart';
import 'package:jsonplaceholder_posts/colors.dart';
import 'package:jsonplaceholder_posts/src/data/sources.dart';
import 'package:jsonplaceholder_posts/src/ui/bloc/post_bloc.dart';
import 'package:jsonplaceholder_posts/src/ui/screens/home_screen.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppMessages.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => PostBloc(PostApiRepository(
          client: Client(),
        )),
        child: BlocListener<PostBloc, PostState>(
          listener: (context, state) {
            if (state is PostError) {
              ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
                content: Text(state.message),
                actions: [
                  ElevatedButton(
                    child: const Text(AppMessages.actionOk),
                    onPressed: () {
                      ScaffoldMessenger.of(context).clearMaterialBanners();
                    },
                  )
                ],
              ));
            }
          },
          listenWhen: (previous, current) => current is PostError,
          child: const HomeScreen(),
        ),
      ),
    );
  }
}
