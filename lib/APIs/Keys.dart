class Keys{
  static final String API_KEY = "2bbf158a2ca5c5656993641e0b1fd67b";
  static final String BASE_URL = "https://www.flickr.com/services/rest/?method=";
  static final String GET_RECENT = BASE_URL + "flickr.photos.getRecent&api_key=$API_KEY"
      +"&format=json&nojsoncallback=1/per_page=20&page=%s}";

  static final String IMAGE_PATH = 'https://farm%s.staticflickr.com/%s/%s_%s.jpg';

  // https://farm{farm_id}.staticflickr.com/{iconserver}/buddyicons/{group_id}.jpg

  
  static final String GROUP_IMAGE = 'https://farm%s.staticflickr.com/%s/buddyicons/%s.jpg';
  static final String GET_GROUPS = BASE_URL+ "flickr.groups.search&api_key=$API_KEY&text=%s&format=json&nojsoncallback=1&page_number=%s";

}