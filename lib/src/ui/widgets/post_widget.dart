import 'package:flutter/material.dart';
import 'package:jsonplaceholder_posts/app_messages.dart';
import 'package:jsonplaceholder_posts/colors.dart';
import 'package:jsonplaceholder_posts/src/domain/entities.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(
          color: Colors.black12,
          width: 1,
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  child: const Text(
                    AppMessages.tagCommunity,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                      fontSize: 10,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  post.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                Text(
                  post.body,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                MaterialButton(
                  child: const Row(
                    children: [
                      Text(
                        AppMessages.actionReadMore,
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      Icon(
                        Icons.arrow_right_alt_outlined,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 32,
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              gradient: RadialGradient(
                colors: [
                  AppColors.gradientLight,
                  AppColors.gradientDark,
                  Color.fromARGB(255, 5, 86, 148),
                  AppColors.gradientDark,
                ],
                center: Alignment(0.8, 0.8),
                radius: 4,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: const TextSpan(
                      text: AppMessages.companyName,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                      children: [
                        TextSpan(
                          text: ' at',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    AppMessages.eventName,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    AppMessages.eventYear,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1
                        ..color = Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
