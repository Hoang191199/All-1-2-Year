class EpubChapter {
  EpubChapter({
    this.title,
    this.contentFileName,
    this.anchor,
    this.htmlContent,
    this.subChapters,
    this.level,
  });

  String? title;
  String? contentFileName;
  String? anchor;
  String? htmlContent;
  List<EpubChapter>? subChapters;
  int? level;

  @override
  String toString() {
    return 'title: $title, subchapter count: ${subChapters?.length ?? 0}';
  }
}