class EpubManifestItem {
  EpubManifestItem({
    this.id,
    this.href,
    this.mediaType,
    this.mediaOverlay,
    this.requiredNamespace,
    this.requiredModules,
    this.fallback,
    this.fallbackStyle,
    this.properties,
  });

  String? id;
  String? href;
  String? mediaType;
  String? mediaOverlay;
  String? requiredNamespace;
  String? requiredModules;
  String? fallback;
  String? fallbackStyle;
  String? properties;

  @override
  String toString() {
    return 'id: $id, href = $href, mediaType = $mediaType, properties = $properties, mediaOverlay = $mediaOverlay';
  }
}