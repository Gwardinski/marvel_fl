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

  Resource.fromApi(Map<String, dynamic> json) {
    this.name = resourceName[json['type']] ?? json['type'];
    this.url = json['url'];
  }
  Resource.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.url = json['url'];
  }

  static List<Resource> listFromApi(List<dynamic> json) {
    List<Resource> formattedResources = [];
    if (json.length > 0) {
      formattedResources = json.map((c) => Resource.fromApi(c)).toList();
    }
    return formattedResources;
  }

  static List<Resource> listFromJson(List<dynamic> json) {
    List<Resource> formattedResources = [];
    if (json.length > 0) {
      formattedResources = json.map((r) => Resource.fromJson(r)).toList();
    }
    return formattedResources;
  }

  Map<String, dynamic> toJson() => {
        'url': url,
        'name': name,
      };
}
