import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_news.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';

class NewsFeedSectionItemText extends StatelessWidget {
  const NewsFeedSectionItemText({
    super.key,
    this.postNews,
  });

  final PostNews? postNews;

  @override
  Widget build(BuildContext context) {
    return Html(
      data: postNews?.text ?? '',
      style: {
        'body': Style(
          lineHeight: LineHeight(context.responsive(1.6)),
          fontSize: FontSize(context.responsive(14.0)),
          color: HexColor('464646'),
          fontFamily: 'Raleway',
          margin: Margins.zero,
          padding: HtmlPaddings.zero
        )
      },
    );
  }
}