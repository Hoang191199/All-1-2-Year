class EpubSpineItemRef {
  EpubSpineItemRef({
    this.idRef,
    this.isLinear,
  });

  String? idRef;
  bool? isLinear;

  @override
  String toString() {
    return 'idRef: $idRef';
  }
}