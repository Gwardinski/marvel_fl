const resourceName = {
  "detail": "Details",
  "comiclink": "Comics",
  "wiki": "Wiki",
  "purchase": "Purchase",
  "reader": "Reader",
  "inAppLink": "Open-in-App",
};

class Resource {
  String url;
  String name;

  Resource.fromJson(Map<String, dynamic> json) {
    this.name = resourceName[json['type']] ?? json['type'];
    this.url = json['url'];
  }

  static List<Resource> listFromJson(List<dynamic> json) {
    List<Resource> formattedResources = [];
    if (json.length > 0) {
      formattedResources = json.map((c) => Resource.fromJson(c)).toList();
    }
    return formattedResources;
  }
}
