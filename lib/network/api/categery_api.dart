abstract class CategoryApi {
  // add ctegery api
  Future<bool> createTable();
  addCategory({
    required String category,
  });
  fetchCategory();
  deleteCategory();
  updateCategory();
}
