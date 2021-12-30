class Wishlist {

  int id;
  String name;
  String sub_desc;
  String description;
  String price;
  String image;

	Wishlist.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		name = map["name"],
		sub_desc = map["sub_desc"],
		description = map["description"],
		price = map["price"],
		image = map["image"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['product']['id'] = id;
		data['product']['name'] = name;
		data['product']['sub_desc'] = sub_desc;
		data['product']['description'] = description;
		data['product']['price'] = price;
		data['product']['image'] = image;
		return data;
	}
}