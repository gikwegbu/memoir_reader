import 'package:flutter/material.dart';
import 'package:memoir_reader/modules/memoir/memoir_details_screen.dart';
import 'package:memoir_reader/utils/utils.dart';
import 'package:memoir_reader/utils/widgets/text_utils.dart';
import 'package:bot_toast/bot_toast.dart';

class MemoirCard extends StatelessWidget {
  const MemoirCard({
    Key? key,
    required this.title,
    required this.content,
    required this.username,
    required this.id,
    required this.createdAt,
  }) : super(key: key);

  final String title, content, username, id;
  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        memoirLoader();
        Future.delayed(const Duration(milliseconds: 5000), () {
          BotToast.closeAllLoading();
          navigate(
            context,
            MemoirDetailsScreen.routeName,
            arguments: MemoirDetailsScreenArguements(
              id: id,
              title: title,
              content: content,
            ),
          );
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            labelText(title, context),
            ySpace(height: 10),
            subtext(
              content,
              context,
              height: 1.5,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const Divider(),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          subtext(
                            "@$username",
                            context,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                  subtext(
                    shortDate(createdAt),
                    context,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
