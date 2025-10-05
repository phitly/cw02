import 'package:flutter/material.dart';
import '../data/sample_recipes.dart';
import '../managers/favorites_manager.dart';
import 'details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FavoritesManager _favoritesManager = FavoritesManager();

  @override
  void initState() {
    super.initState();
    _favoritesManager.addListener(_onFavoritesChanged);
  }

  @override
  void dispose() {
    _favoritesManager.removeListener(_onFavoritesChanged);
    super.dispose();
  }

  void _onFavoritesChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final favoriteRecipes = _favoritesManager.getFavoriteRecipes(sampleRecipes);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Recipes'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 2,
      ),
      body: favoriteRecipes.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No favorite recipes yet',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Mark recipes as favorites to see them here',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favoriteRecipes.length,
              itemBuilder: (context, index) {
                final recipe = favoriteRecipes[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(recipe: recipe),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Image.network(
                                recipe.imageUrl,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 200,
                                    color: Colors.grey[300],
                                    child: const Icon(
                                      Icons.image_not_supported,
                                      size: 64,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipe.name,
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                recipe.description,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey[600],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 16,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    recipe.cookingTime,
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  const SizedBox(width: 16),
                                  Icon(
                                    Icons.signal_cellular_alt,
                                    size: 16,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    recipe.difficulty,
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  const SizedBox(width: 16),
                                  Icon(
                                    Icons.people,
                                    size: 16,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${recipe.servings} servings',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}