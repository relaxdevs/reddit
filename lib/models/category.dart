
class CategoryModel {
  late String emoji;
  late String link;

  CategoryModel.fromJson(Map item) {
    emoji = item['emoji'] ?? '';
    link = item['link'] ?? '';
  }
}