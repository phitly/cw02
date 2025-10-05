import 'package:flutter/foundation.dart';
import '../models/recipe.dart';

class FavoritesManager extends ChangeNotifier {
  static final FavoritesManager _instance = FavoritesManager._internal();
  factory FavoritesManager() => _instance;
  FavoritesManager._internal();

  final Set<String> _favoriteRecipeIds = <String>{};

  Set<String> get favoriteRecipeIds => Set.unmodifiable(_favoriteRecipeIds);

  bool isFavorite(String recipeId) {
    return _favoriteRecipeIds.contains(recipeId);
  }

  void toggleFavorite(String recipeId) {
    if (_favoriteRecipeIds.contains(recipeId)) {
      _favoriteRecipeIds.remove(recipeId);
    } else {
      _favoriteRecipeIds.add(recipeId);
    }
    notifyListeners();
  }

  List<Recipe> getFavoriteRecipes(List<Recipe> allRecipes) {
    return allRecipes.where((recipe) => _favoriteRecipeIds.contains(recipe.id)).toList();
  }

  int get favoriteCount => _favoriteRecipeIds.length;
}