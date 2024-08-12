class RecycleItemModel {
  final String? id;
  final String name;
  final String description;
  final bool isReuseable;
  final bool isRecyclable;

  const RecycleItemModel({
    this.id,
    required this.name,
    required this.description,
    required this.isReuseable,
    required this.isRecyclable,
  });

  get firstName => null;
  get lastName => null;
  get profileUrl => null;

  toJson() {
    return {
      "name": name,
      "description": description,
      "isReuseable": isReuseable,
      "isRecyclable": isRecyclable,
    };
  }
}
