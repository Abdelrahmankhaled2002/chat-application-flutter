class Category{
  static String musicId='music';
  static String moviesId='movies';
  static String sportsId ='sports';
  late String id;
  late String title;
  Category(this.id,this.title, );
  Category.fromId(this.id){
    title=id;
  }
  static List<Category>getCategories(){
    return [Category.fromId(sportsId),Category.fromId(moviesId), Category.fromId(musicId)];
  }
}