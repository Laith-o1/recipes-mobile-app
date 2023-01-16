class Recipes {
  int? id;
  String? name;
  List<String>? ingredients;
  List<String>? instructions;

  Recipes({this.id, this.name, this.ingredients, this.instructions});

  Recipes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    ingredients = json['ingredients'].cast<String>();
    instructions = json['instructions'].cast<String>();
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['ingredients'] = this.ingredients;
  //   data['instructions'] = this.instructions;
  //   return data;
  // }
}
