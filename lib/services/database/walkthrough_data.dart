class SliderModel{
  String imagePath, title, description;
  SliderModel({this.imagePath, this.title, this.description});

  void setImagePath(String getImagePath){
    imagePath = getImagePath;
  }
  void setTitle(String getTitle){
    title = getTitle;
  }
  void setDescription(String getDescription){
    description = getDescription;
  }

  String getImagePath(){
    return imagePath;
  }
  String getTitle(){
    return title;
  }
  String getDescription(){
    return description;
  }
}

List<SliderModel> getSlides(){
  List slides = <SliderModel>[];
  SliderModel sliderModel = new SliderModel();

  // TODO: Check the description formatting
  // TODO: Check if png works better or svg
  //1
  // TODO: pic of real phone showing listing of shops
  sliderModel.setImagePath("assets/grocery_shop.png");
  sliderModel.setTitle("Online Order");
  sliderModel.setDescription("Description 1");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setImagePath("assets/delivery.png");
  sliderModel.setTitle("Door-step Delivery");
  sliderModel.setDescription("Description 2");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  //sliderModel.setImagePath("assets/logo.png");
  //sliderModel.setTitle("Title 3");
  //sliderModel.setDescription("Description 3");
  //slides.add(sliderModel);

  //sliderModel = new SliderModel();


  return slides;
}