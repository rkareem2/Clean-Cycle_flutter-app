class CollectionItemModel {
  final String? id;
  final String name;
  final String description;
  final List<String> category;

  const CollectionItemModel({
    this.id,
    required this.name,
    required this.description,
    required this.category,
  });

  toJson() {
    return {
      "name": name,
      "description": description,
      "category": category,
    };
  }
}
