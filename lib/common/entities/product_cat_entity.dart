// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProductCatEntity {
  final String id;
  final String name;
  final String label;
  final String image;
  final dynamic personalizeImage;

  ProductCatEntity(
      {required this.id,
      required this.name,
      required this.label,
      required this.image,
      required this.personalizeImage});
}
