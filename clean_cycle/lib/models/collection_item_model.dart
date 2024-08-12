class CollectionItemModel {
  final String? id;
  final String name;
  final String description;
  final bool isReusable;
  final bool isRecyclable;

  const CollectionItemModel({
    this.id,
    required this.name,
    required this.description,
    required this.isReusable,
    required this.isRecyclable,
  });

  get firstName => null;
  get lastName => null;
  get profileUrl => null;

  toJson() {
    return {
      "name": name,
      "description": description,
      "isReusable": isReusable,
      "isRecyclable": isRecyclable,
    };
  }
}
