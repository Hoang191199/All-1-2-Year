import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mooc_app/app/config/app_constants.dart';
import 'package:mooc_app/domain/entities/document_file.dart';
import 'package:mooc_app/presentation/widgets/circular_loading_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CourseLessonDocumentDetail extends StatefulWidget {
  const CourseLessonDocumentDetail({
    super.key,
    required this.documentFile,
  });

  final DocumentFile documentFile;

  @override
  State<CourseLessonDocumentDetail> createState() => _CourseLessonDocumentDetailState();
}

class _CourseLessonDocumentDetailState extends State<CourseLessonDocumentDetail> {
  
  var loadingPercentage = 0;
  late WebViewController webViewController;
  
  @override
  void initState() {
    if ((widget.documentFile.type ?? '').toLowerCase() != LessonType.image.toLowerCase()) {
      webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(Colors.white)
        ..setNavigationDelegate(NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
        ))
        ..loadRequest(Uri.parse(
          (widget.documentFile.type ?? '').toLowerCase() == LessonType.pdf.toLowerCase()
            ? 'https://cdn.mobiedu.vn/mobiedu/pdfjs/web/viewer.html?file=${widget.documentFile.url}'
            : (widget.documentFile.type ?? '').toLowerCase() == LessonType.msOffice.toLowerCase() 
              ? 'https://view.officeapps.live.com/op/embed.aspx?src=${widget.documentFile.url}'
              : ''
        ));
    }
    
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.documentFile.name ?? ''),
      ),
      child: Container(
        padding: EdgeInsets.only(top: (statusBarHeight + const CupertinoNavigationBar().preferredSize.height), bottom: bottomPadding),
        child: (widget.documentFile.type ?? '').toLowerCase() == LessonType.image.toLowerCase() 
        ? Center(
          child: CachedNetworkImage(
            imageUrl: widget.documentFile.url ?? '',
            width: widthScreen,
            // height: 220.0,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) => const SizedBox(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ) 
        : Stack(
          children: [
            WebViewWidget(
              controller: webViewController
            ),
            loadingPercentage < 100 
              ? const Center(
                child: CircularLoadingIndicator(),
              )
              : Container()
          ],
        ),
      ),
    );
  }
}