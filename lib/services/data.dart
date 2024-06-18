
import 'package:newapp/models/category_models.dart';


List<CategoryModel> getCategories() {
  List<CategoryModel> category=[];
  CategoryModel categoryModel= new CategoryModel();

  categoryModel.categoryName="Business";
  categoryModel.image = "assets/images/business.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName="Entertainment";
  categoryModel.image = "assets/images/entertainment.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName="General";
  categoryModel.image = "assets/images/general.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName="Health";
  categoryModel.image = "assets/images/health.png";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName="Sports";
  categoryModel.image = "assets/images/sport.png";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName="Science";
  categoryModel.image = "assets/images/Science.png";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  return category;
}