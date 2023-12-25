class EpubGuideReference {
  EpubGuideReference({
    this.type,
    this.title,
    this.href,
  });

  String? type;
  String? title;
  String? href;

  @override
  String toString() {
    return 'type: $type, href: $href';
  }
}