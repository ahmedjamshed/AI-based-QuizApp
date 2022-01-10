import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/app/controllers/appController.dart';
import 'package:quizapp/app/data/api_helper.dart';

class Label {
  final String name;
  final String description;
  final List<String> alias;
  final String image;

  Label(this.name, this.description, this.alias, this.image);
  factory Label.fromMap(dynamic json) {
    return Label(
      json['title'].toString(),
      json['terms']['description'][0].toString(),
      (json['terms']['alias'] ?? []).cast<String>(),
      json['thumbnail'] == null ? '' : json['thumbnail']['source'].toString(),
    );
  }
}

class LabelsController extends GetxController
    with SingleGetTickerProviderMixin {
  final ApiHelper _apiHelper = Get.find();
  final AppController _appController = Get.find();

  final List<Label> _dataList = [];
  List<Label> get dataList => _dataList;
  set dataList(List<Label> dataList) => _dataList.addAll(dataList);

  final RxBool _isLoading = true.obs;
  dynamic get isLoading => _isLoading;

  final RxInt currentPage = 0.obs;
  final PageController pageController = PageController(viewportFraction: 0.8);

  void getLabels(String img) {
    _dataList.clear();
    _apiHelper.getLabels(img).futureValue((dynamic value) {
      dataList = value.map<Label>((val) => Label.fromMap(val)).toList();

      _isLoading.value = false;
    });
  }

  @override
  void onInit() {
    pageController.addListener(() {
      currentPage.value = pageController.page?.round() ?? 0;
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    final content = _appController.selectedImage;
    getLabels(content);
  }
}

//  Sample output of the api

// const dynamic value = [
//   {
//     "pageid": 4802,
//     "ns": 0,
//     "title": "Biome",
//     "thumbnail": {
//       "source":
//           "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Vegetation.png/500px-Vegetation.png",
//       "width": 500,
//       "height": 225
//     },
//     "original": {
//       "source":
//           "https://upload.wikimedia.org/wikipedia/commons/e/e4/Vegetation.png",
//       "width": 1385,
//       "height": 622
//     },
//     "pageimage": "Vegetation.png",
//     "terms": {
//       "alias": [
//         "bioms",
//         "bioformation",
//         "bioformations",
//         "biome type",
//         "biome types"
//       ],
//       "label": ["biome"],
//       "description": [
//         "distinct biological communities that have formed in response to a shared physical climate"
//       ]
//     },
//     "pageprops": {
//       "page_image_free": "Vegetation.png",
//       "wikibase-shortdesc":
//           "Community of organisms associated with an environment",
//       "wikibase_item": "Q101998"
//     }
//   },
//   {
//     "pageid": 9279,
//     "ns": 0,
//     "title": "Elephant",
//     "thumbnail": {
//       "source":
//           "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Elephant_Diversity.jpg/500px-Elephant_Diversity.jpg",
//       "width": 500,
//       "height": 394
//     },
//     "original": {
//       "source":
//           "https://upload.wikimedia.org/wikipedia/commons/1/1a/Elephant_Diversity.jpg",
//       "width": 4780,
//       "height": 3768
//     },
//     "pageimage": "Elephant_Diversity.jpg",
//     "terms": {
//       "label": ["elephant"],
//       "description": ["trunk-bearing large mammal"]
//     },
//     "pageprops": {
//       "page_image_free": "Elephant_Diversity.jpg",
//       "wikibase-badge-Q17437796": "1",
//       "wikibase-shortdesc":
//           "Large terrestrial mammals with trunks from Africa and Asia",
//       "wikibase_item": "Q7378"
//     }
//   },
//   {
//     "pageid": 45383,
//     "ns": 0,
//     "title": "Ecoregion",
//     "thumbnail": {
//       "source":
//           "https://upload.wikimedia.org/wikipedia/commons/f/f6/Amazon_rainforest.jpg",
//       "width": 400,
//       "height": 329
//     },
//     "original": {
//       "source":
//           "https://upload.wikimedia.org/wikipedia/commons/f/f6/Amazon_rainforest.jpg",
//       "width": 400,
//       "height": 329
//     },
//     "pageimage": "Amazon_rainforest.jpg",
//     "terms": {
//       "alias": ["ecological region", "Ecoregion, Ecological region"],
//       "label": ["ecoregion"],
//       "description": [
//         "ecologically and geographically defined area that is smaller than a bioregion"
//       ]
//     },
//     "pageprops": {
//       "page_image_free": "Amazon_rainforest.jpg",
//       "wikibase-shortdesc":
//           "Ecologically and geographically defined area that is smaller than a bioregion",
//       "wikibase_item": "Q295469"
//     }
//   },
//   {
//     "pageid": 265118,
//     "ns": 0,
//     "title": "Elephantidae",
//     "thumbnail": {
//       "source":
//           "https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/Elephas_maximus_%28Bandipur%29.jpg/500px-Elephas_maximus_%28Bandipur%29.jpg",
//       "width": 500,
//       "height": 333
//     },
//     "original": {
//       "source":
//           "https://upload.wikimedia.org/wikipedia/commons/9/98/Elephas_maximus_%28Bandipur%29.jpg",
//       "width": 2598,
//       "height": 1732
//     },
//     "pageimage": "Elephas_maximus_(Bandipur).jpg",
//     "terms": {
//       "alias": ["elephant family", "Elephants", "Elephant"],
//       "label": ["Elephantidae"],
//       "description": ["family of mammals"]
//     },
//     "pageprops": {
//       "page_image_free": "Elephas_maximus_(Bandipur).jpg",
//       "wikibase-shortdesc": "Family of mammals",
//       "wikibase_item": "Q2372824"
//     }
//   },
//   {
//     "pageid": 1416251,
//     "ns": 0,
//     "title": "African elephant",
//     "thumbnail": {
//       "source":
//           "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/African_Elephant_%28Loxodonta_africana%29_male_%2817289351322%29.jpg/456px-African_Elephant_%28Loxodonta_africana%29_male_%2817289351322%29.jpg",
//       "width": 456,
//       "height": 500
//     },
//     "original": {
//       "source":
//           "https://upload.wikimedia.org/wikipedia/commons/b/bf/African_Elephant_%28Loxodonta_africana%29_male_%2817289351322%29.jpg",
//       "width": 3648,
//       "height": 4000
//     },
//     "pageimage": "African_Elephant_(Loxodonta_africana)_male_(17289351322).jpg",
//     "terms": {
//       "alias": ["Loxodonta"],
//       "label": ["African elephant"],
//       "description": ["genus comprising two living elephant species"]
//     },
//     "pageprops": {
//       "defaultsort": "elephant, African",
//       "page_image_free":
//           "African_Elephant_(Loxodonta_africana)_male_(17289351322).jpg",
//       "wikibase-shortdesc": "Genus comprising two living elephant species",
//       "wikibase_item": "Q185038"
//     }
//   },
//   {
//     "pageid": 2729585,
//     "ns": 0,
//     "title": "Working animal",
//     "thumbnail": {
//       "source":
//           "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Bullock_team.jpg/500px-Bullock_team.jpg",
//       "width": 500,
//       "height": 345
//     },
//     "original": {
//       "source":
//           "https://upload.wikimedia.org/wikipedia/commons/a/a4/Bullock_team.jpg",
//       "width": 1300,
//       "height": 896
//     },
//     "pageimage": "Bullock_team.jpg",
//     "terms": {
//       "alias": ["animal work"],
//       "label": ["working animal"],
//       "description": ["domesticated animals for assisting people"]
//     },
//     "pageprops": {
//       "defaultsort": "Working Animal",
//       "page_image_free": "Bullock_team.jpg",
//       "wikibase-shortdesc": "Domesticated animals for assisting people",
//       "wikibase_item": "Q228534"
//     }
//   },
//   {
//     "pageid": 14389994,
//     "ns": 0,
//     "title": "Natural landscape",
//     "thumbnail": {
//       "source":
//           "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f5/Terra.png/500px-Terra.png",
//       "width": 500,
//       "height": 500
//     },
//     "original": {
//       "source": "https://upload.wikimedia.org/wikipedia/commons/f/f5/Terra.png",
//       "width": 599,
//       "height": 599
//     },
//     "pageimage": "Terra.png",
//     "terms": {
//       "label": ["natural landscape"],
//       "description": ["original landscape formed by nature"]
//     },
//     "pageprops": {
//       "defaultsort": "Natural Landscape",
//       "page_image_free": "Terra.png",
//       "wikibase-shortdesc": "Original landscape formed by nature",
//       "wikibase_item": "Q1286517"
//     }
//   },
//   {
//     "pageid": 19653842,
//     "ns": 0,
//     "title": "Organism",
//     "thumbnail": {
//       "source":
//           "https://upload.wikimedia.org/wikipedia/commons/thumb/3/32/EscherichiaColi_NIAID.jpg/500px-EscherichiaColi_NIAID.jpg",
//       "width": 500,
//       "height": 420
//     },
//     "original": {
//       "source":
//           "https://upload.wikimedia.org/wikipedia/commons/3/32/EscherichiaColi_NIAID.jpg",
//       "width": 1024,
//       "height": 861
//     },
//     "pageimage": "EscherichiaColi_NIAID.jpg",
//     "terms": {
//       "alias": [
//         "living thing",
//         "living organism",
//         "biological organism",
//         "life form",
//         "lifeform",
//         "living organisms",
//         "orpanisms"
//       ],
//       "label": ["organism"],
//       "description": [
//         "any contiguous alive physical entity; entity or being that is living; an individual living thing, such as one animal, plant, fungus, or bacterium"
//       ]
//     },
//     "pageprops": {
//       "page_image_free": "EscherichiaColi_NIAID.jpg",
//       "wikibase-shortdesc":
//           "Any individual living being or physical living system",
//       "wikibase_item": "Q7239"
//     }
//   },
//   {
//     "pageid": 19828134,
//     "ns": 0,
//     "title": "Plant",
//     "thumbnail": {
//       "source":
//           "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Diversity_of_plants_image_version_5.png/336px-Diversity_of_plants_image_version_5.png",
//       "width": 336,
//       "height": 500
//     },
//     "original": {
//       "source":
//           "https://upload.wikimedia.org/wikipedia/commons/6/6e/Diversity_of_plants_image_version_5.png",
//       "width": 896,
//       "height": 1331
//     },
//     "pageimage": "Diversity_of_plants_image_version_5.png",
//     "terms": {
//       "alias": [
//         "green plants",
//         "plants",
//         "green plant",
//         "Plantæ",
//         "planta",
//         "kingdom Plantae",
//         "plantae"
//       ],
//       "label": ["plant"],
//       "description": ["multicellular eukaryote of the kingdom Plantae"]
//     },
//     "pageprops": {
//       "page_image_free": "Diversity_of_plants_image_version_5.png",
//       "wikibase-shortdesc":
//           "Kingdom of mainly multicellular, predominantly photosynthetic eukaryotes",
//       "wikibase_item": "Q756"
//     }
//   },
//   {
//     "pageid": 23291939,
//     "ns": 0,
//     "title": "Plant community",
//     "thumbnail": {
//       "source":
//           "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/Mt_Anne_from_High_Shelf_Camp.jpg/500px-Mt_Anne_from_High_Shelf_Camp.jpg",
//       "width": 500,
//       "height": 333
//     },
//     "original": {
//       "source":
//           "https://upload.wikimedia.org/wikipedia/commons/e/e5/Mt_Anne_from_High_Shelf_Camp.jpg",
//       "width": 4190,
//       "height": 2793
//     },
//     "pageimage": "Mt_Anne_from_High_Shelf_Camp.jpg",
//     "terms": {
//       "alias": [
//         "phytocoenosis",
//         "phytocenosis",
//         "plant communities",
//         "phytosociology",
//         "vegetation community",
//         "vegetation communities"
//       ],
//       "label": ["plant community"],
//       "description": [
//         "collection or association of plant species within a designated geographical unit"
//       ]
//     },
//     "pageprops": {
//       "page_image_free": "Mt_Anne_from_High_Shelf_Camp.jpg",
//       "wikibase-shortdesc": "Collection of native photosynthetic organisms",
//       "wikibase_item": "Q1418712"
//     }
//   }
// ];
