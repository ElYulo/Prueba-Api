class ApiModel {
  int id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  String? image;

  ApiModel({
    required this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.image,
  });

  factory ApiModel.transInstancia(Map<String, dynamic> api) => ApiModel(
        id: api['id'],
        name: api['name'],
        status: api['status'],
        species: api['species'],
        type: api['type'],
        gender: api['gender'],
        image: api['image'],
      );
}
