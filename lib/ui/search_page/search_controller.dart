import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/base/base_controller.dart';
import 'package:food_delivery_app/models/food/dishes.dart';
import 'package:food_delivery_app/models/food/dish_categories.dart';

class SearchScreenController extends BaseController {
  final TextEditingController searchTextController = TextEditingController();
  final RxString searchText = ''.obs;
  final RxBool loading = false.obs;
  final RxInt selectedCategoryFilter = (-1).obs; // -1 means all categories

  // All dishes data
  final RxList<Dishes> allDishes = RxList<Dishes>([]);
  final RxList<Dishes> filteredDishes = RxList<Dishes>([]);
  final RxList<Dishes> popularDishes = RxList<Dishes>([]);

  // Categories for filtering
  final RxList<Map<String, dynamic>> categories = RxList<Map<String, dynamic>>([]);
  final RxList<DishesCategory> apiCategories = RxList<DishesCategory>([]);

  // Recent searches
  final RxList<String> recentSearches = RxList<String>([]);

  // Debounce timer for search
  Timer? _debounceTimer;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
    _loadRecentSearches();
  }

  Future<void> _initializeData() async {
    loading.value = true;
    try {
      // Load categories first
      await _loadCategories();

      // Load all dishes
      await _loadAllDishes();

      // Load popular dishes (first 10 dishes as popular)
      _loadPopularDishes();

    } catch (e) {
      print('Error initializing search data: $e');
    } finally {
      loading.value = false;
    }
  }

  Future<void> _loadCategories() async {
    try {
      final response = await categoryRepositories.getListCategories();

      if (response.data != null && response.data!.isNotEmpty) {
        apiCategories.value = response.data!;

        // Create categories list with "Tất cả" option
        categories.clear();
        categories.add({'name': 'Tất cả', 'id': -1});

        for (var category in apiCategories) {
          categories.add({
            'name': category.name ?? 'Không tên',
            'id': category.id,
          });
        }

        print('Loaded ${categories.length} categories for search filter');
      }
    } catch (e) {
      print('Error loading categories: $e');
    }
  }

  Future<void> _loadAllDishes() async {
    try {
      // Load all dishes at once (assuming you have an API endpoint for this)
      // If you don't have getAllDishes endpoint, you can use getDishesByCategory with no categoryId
      final response = await categoryRepositories.getDishesByCategory(
        categoryId: '', // Empty or null to get all dishes
      );

      if (response.data?.isNotEmpty == true) {
        allDishes.value = response.data!;
        print('Loaded ${allDishes.length} dishes for search');
      } else {
        allDishes.clear();
        print('No dishes found');
      }

    } catch (e) {
      print('Error loading all dishes: $e');
      // Fallback: try to load without categoryId parameter
      try {
        final response = await productRepositories.getListDishes(); // If this method exists
        if (response.data?.isNotEmpty == true) {
          allDishes.value = response.data!;
          print('Loaded ${allDishes.length} dishes for search (fallback)');
        }
      } catch (fallbackError) {
        print('Fallback also failed: $fallbackError');
        allDishes.clear();
      }
    }
  }

  void _loadPopularDishes() {
    // Take first 10 dishes as popular (you can implement your own logic)
    if (allDishes.isNotEmpty) {
      popularDishes.value = allDishes.take(10).toList();
    }
  }

  void _loadRecentSearches() {
    // Load from local storage if available
    // For now, using empty list - you can implement SharedPreferences here
    recentSearches.value = [];
  }

  void onSearchChanged(String value) {
    searchText.value = value;

    // Cancel previous timer
    _debounceTimer?.cancel();

    // Start new timer
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _performSearch(value);
    });
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      filteredDishes.clear();
      return;
    }

    loading.value = true;

    try {
      List<Dishes> results = allDishes.where((dish) {
        final dishName = dish.name?.toLowerCase() ?? '';
        final searchQuery = query.toLowerCase();

        return dishName.contains(searchQuery);
      }).toList();

      // Apply category filter if selected
      if (selectedCategoryFilter.value >= 0 && selectedCategoryFilter.value < categories.length) {
        final selectedCategoryId = categories[selectedCategoryFilter.value]['id'];
        if (selectedCategoryId != -1) {
          results = results.where((dish) => dish.categoryId == selectedCategoryId).toList();
        }
      }

      // Sort by relevance (exact matches first, then partial matches)
      results.sort((a, b) {
        final aName = a.name?.toLowerCase() ?? '';
        final bName = b.name?.toLowerCase() ?? '';
        final searchQuery = query.toLowerCase();

        // Exact matches first
        if (aName.startsWith(searchQuery) && !bName.startsWith(searchQuery)) {
          return -1;
        } else if (!aName.startsWith(searchQuery) && bName.startsWith(searchQuery)) {
          return 1;
        }

        // Then by alphabetical order
        return aName.compareTo(bName);
      });

      filteredDishes.value = results;
      print('Found ${results.length} dishes for query: "$query"');

    } catch (e) {
      print('Error performing search: $e');
      filteredDishes.clear();
    } finally {
      loading.value = false;
    }
  }

  void setSelectedCategoryFilter(int index) {
    selectedCategoryFilter.value = index;

    // Re-perform search with new filter
    if (searchText.value.isNotEmpty) {
      _performSearch(searchText.value);
    }
  }

  void clearSearch() {
    searchTextController.clear();
    searchText.value = '';
    filteredDishes.clear();
    selectedCategoryFilter.value = -1;
  }

  void addToRecentSearches(String search) {
    if (search.trim().isEmpty) return;

    // Remove if already exists
    recentSearches.remove(search);

    // Add to beginning
    recentSearches.insert(0, search);

    // Keep only last 10 searches
    if (recentSearches.length > 10) {
      recentSearches.removeRange(10, recentSearches.length);
    }

    // Save to local storage (implement SharedPreferences here)
    _saveRecentSearches();
  }

  void removeRecentSearch(String search) {
    recentSearches.remove(search);
    _saveRecentSearches();
  }

  void clearRecentSearches() {
    recentSearches.clear();
    _saveRecentSearches();
  }

  void _saveRecentSearches() {
    // Implement SharedPreferences to save recent searches
    // For now, just print
    print('Saving recent searches: ${recentSearches.toList()}');
  }

  void searchFromHistory(String query) {
    searchTextController.text = query;
    searchText.value = query;
    _performSearch(query);
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    searchTextController.dispose();
    super.onClose();
  }
}