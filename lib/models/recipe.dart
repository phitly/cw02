class Recipe {
  final String id;
  final String name;
  final String description;
  final List<String> ingredients;
  final List<String> instructions;
  final String cookingTime;
  final String difficulty;
  final String imageUrl;
  final int servings;

  const Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.cookingTime,
    required this.difficulty,
    required this.imageUrl,
    required this.servings,
  });
}