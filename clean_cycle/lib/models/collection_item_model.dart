class CollectionItemModel {
  final String? id;
  final String name;
  final String description;
  final String ownerId;
  final List<String> category;

  const CollectionItemModel({
    this.id,
    required this.name,
    required this.description,
    required this.ownerId,
    required this.category,
  });

  toJson() {
    return {
      "id" : id,
      "name": name,
      "description": description,
      "ownerId": ownerId,
      "category": category,
    };
  }
}
