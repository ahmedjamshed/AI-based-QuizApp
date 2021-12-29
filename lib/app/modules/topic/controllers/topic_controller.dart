import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/app/data/api_helper.dart';
import 'package:quizapp/app/modules/labels/controllers/labels_controller.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class Topic {
  final String heading;
  final String description;
  final List<Topic> subTopics;

  Topic(this.heading, this.description, this.subTopics);
  factory Topic.fromMap(dynamic json) {
    final List<Topic> subTopics = [];
    for (final subTopic in json['subTopics']) {
      subTopics.add(Topic(subTopic['heading'], subTopic['description'], []));
    }
    return Topic(json['heading'], json['description'], subTopics);
  }
}

class TopicController extends GetxController {
  final ApiHelper _apiHelper = Get.find();

  final List<Topic> _dataList = [Topic('Intro', '', [])];
  List<Topic> get dataList => _dataList;
  set dataList(List<Topic> dataList) => _dataList.addAll(dataList);

  final RxBool _isLoading = true.obs;
  dynamic get isLoading => _isLoading;

  final RxInt currentPage = 0.obs;

  final pageController = IndexController();
  final itemScrollController = AutoScrollController();

  final RxBool isDrawerOpen = false.obs;

  void toggleDrawer() {
    isDrawerOpen.value = !isDrawerOpen.value;
  }

  void getTopic(String title) {
    _isLoading.value = true;
    // _apiHelper.getTopic(title).futureValue((dynamic value) {
    dataList = value['topics'].map<Topic>((val) => Topic.fromMap(val)).toList();
    _isLoading.value = false;
    // });
  }

  void gotoPage(int position, {bool fromDrawer = false}) {
    currentPage.value = position;
    fromDrawer
        ? pageController.move(position)
        : itemScrollController.scrollToIndex(position);
  }

  @override
  void onInit() {
    // pageController.addListener(() {
    //   currentPage.value = pageController.index ?? 0;
    //   print('ahmed' + pageController.index.toString());
    // });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    final Label data = Get.arguments ?? Label('', '', [], '');
    getTopic(data.name);
  }

  @override
  void onClose() {
    super.onClose();
    print('close');
  }
}

const dynamic value = {
  "page": {
    "pageid": 9279,
    "ns": 0,
    "title": "Elephant",
    "original": {
      "source":
          "https://upload.wikimedia.org/wikipedia/commons/1/1a/Elephant_Diversity.jpg",
      "width": 4780,
      "height": 3768
    },
    "terms": {
      "label": ["elephant"],
      "description": ["trunk-bearing large mammal"]
    },
    "images": [
      {"ns": 6, "title": "File:2005-tusker-musth-crop.jpg"},
      {"ns": 6, "title": "File:2010-kabini-tusker-bark.jpg"},
      {"ns": 6, "title": "File:Aardvark2 (PSF) colourised.png"},
      {"ns": 6, "title": "File:African Bush Elephant.jpg"},
      {"ns": 6, "title": "File:African Elephant distribution map.svg"},
      {"ns": 6, "title": "File:African Forest Elephant.jpg"},
      {
        "ns": 6,
        "title": "File:African elephant (Loxodonta africana) reaching up 1.jpg"
      },
      {"ns": 6, "title": "File:African elephant carcass ratio, OWID.svg"},
      {"ns": 6, "title": "File:African elephant warning raised trunk.jpg"},
      {"ns": 6, "title": "File:Angry elephant ears.jpg"},
      {"ns": 6, "title": "File:Archidiskodon imperator121.jpg"},
      {
        "ns": 6,
        "title": "File:Asian Elephant, Royal Chitwan National Park.jpg"
      },
      {"ns": 6, "title": "File:Asian Elephant area.png"},
      {"ns": 6, "title": "File:Asian Elephant at Corbett National Park 15.jpg"},
      {"ns": 6, "title": "File:Barytherium graveDB1.jpg"},
      {"ns": 6, "title": "File:BlankMastodon.jpg"},
      {"ns": 6, "title": "File:Blind monks examining an elephant.jpg"},
      {
        "ns": 6,
        "title":
            "File:Brehms Thierleben - Allgemeine Kunde des Thierreichs (1876) (Tenrec ecaudatus).jpg"
      },
      {"ns": 6, "title": "File:Commons-logo.svg"},
      {"ns": 6, "title": "File:Cscr-featured.svg"},
      {"ns": 6, "title": "File:Deinotherium12.jpg"},
      {"ns": 6, "title": "File:DendrohyraxEminiSmit white background.jpg"},
      {"ns": 6, "title": "File:Dugong dugon Hardwicke white background.jpg"},
      {"ns": 6, "title": "File:Elefant pune.jpg"},
      {"ns": 6, "title": "File:Elephant Diversity.jpg"},
      {"ns": 6, "title": "File:Elephant Walking animated.gif"},
      {"ns": 6, "title": "File:Elephant eating Yala Sri Lanka.ogv"},
      {"ns": 6, "title": "File:Elephant skeleton.jpg"},
      {"ns": 6, "title": "File:Elephantsmating.jpg"},
      {"ns": 6, "title": "File:Elephas-antiquus.jpg"},
      {
        "ns": 6,
        "title":
            "File:Elephas africanus - 1700-1880 - Print - Iconographia Zoologica - (white background).jpg"
      },
      {"ns": 6, "title": "File:Elephas maximus (Bandipur).jpg"},
      {"ns": 6, "title": "File:Em - Loxodonta africana heart - GMZ 2.jpg"},
      {
        "ns": 6,
        "title":
            "File:Flickr - …trialsanderrors - Terrific flights over ponderous elephants, poster for Forepaugh ^ Sells Brothers, ca. 1899.jpg"
      },
      {"ns": 6, "title": "File:Forest elephant.jpg"},
      {"ns": 6, "title": "File:Forest elephant group 4 (6987537249).jpg"},
      {"ns": 6, "title": "File:Gomphotherium NT small.jpg"},
      {
        "ns": 6,
        "title": "File:Illustration at p. 73 in Just So Stories (c1912).png"
      },
      {
        "ns": 6,
        "title":
            "File:Insightful-Problem-Solving-in-an-Asian-Elephant-pone.0023251.s005.ogv"
      },
      {"ns": 6, "title": "File:Ivory trade.jpg"},
      {
        "ns": 6,
        "title":
            "File:Jaw of a deceased Loxodonta africana juvenile individual found within the Voyager Ziwani Safari Camp, on the edge of the Tsavo West National Park, near Ziwani, Kenya 3 (edited).jpg"
      },
      {
        "ns": 6,
        "title":
            "File:Loxodonta africana oral rumble visualized with acoustic camera (25fps) - pone.0048907.s003.ogv"
      },
      {"ns": 6, "title": "File:Loxodontacyclotis.jpg"},
      {"ns": 6, "title": "File:Mammuthus trogontherii122DB.jpg"},
      {"ns": 6, "title": "File:Manatee white background.jpg"},
      {"ns": 6, "title": "File:Moeritherium NT small.jpg"},
      {"ns": 6, "title": "File:OOjs UI icon edit-ltr-progressive.svg"},
      {"ns": 6, "title": "File:Okapi2.jpg"},
      {"ns": 6, "title": "File:Red Pencil Icon.png"},
      {
        "ns": 6,
        "title": "File:Rhynchocyon chrysopygus-J Smit white background.jpg"
      },
      {"ns": 6, "title": "File:Schlacht bei Zama Gemälde H P Motte.jpg"},
      {"ns": 6, "title": "File:Semi-protection-shackle.svg"},
      {"ns": 6, "title": "File:Serengeti Elefantenherde1.jpg"},
      {"ns": 6, "title": "File:Stegodon Siwalik Hills.jpg"},
      {
        "ns": 6,
        "title":
            "File:The animal kingdom, arranged according to its organization, serving as a foundation for the natural history of animals (Pl. 18) (Chrysochloris asiatica).jpg"
      },
      {"ns": 6, "title": "File:Three elephant's curly kisses.jpg"},
      {"ns": 6, "title": "File:Wikibooks-logo.svg"},
      {"ns": 6, "title": "File:Wikiquote-logo.svg"},
      {"ns": 6, "title": "File:Wikisource-logo.svg"},
      {"ns": 6, "title": "File:Wiktionary-logo-v2.svg"},
      {
        "ns": 6,
        "title": "File:Woolly mammoth model Royal BC Museum in Victoria.jpg"
      }
    ]
  },
  "topics": [
    {
      "heading": "Elephant",
      "description":
          "Elephants are the largest existing land animals. Three living species are currently recognised: the African bush elephant, the African forest elephant, and the Asian elephant. They are an informal grouping within the proboscidean family Elephantidae. Elephantidae is the only surviving family of proboscideans; extinct members include the mastodons. Elephantidae also contains several extinct groups, including the mammoths and straight-tusked elephants. African elephants have larger ears and concave backs, whereas Asian elephants have smaller ears, and convex or level backs. Distinctive features of all elephants include a long proboscis called a trunk, tusks, large ear flaps, massive legs, and tough but sensitive skin. The trunk is used for breathing, bringing food and water to the mouth, and grasping objects. Tusks, which are derived from the incisor teeth, serve both as weapons and as tools for moving objects and digging. The large ear flaps assist in maintaining a constant body temperature as well as in communication. The pillar-like legs carry their great weight.Elephants are scattered throughout sub-Saharan Africa, South Asia, and Southeast Asia and are found in different habitats, including savannahs, forests, deserts, and marshes. They are herbivorous, and they stay near water when it is accessible. They are considered to be keystone species, due to their impact on their environments.  Elephants have a fission–fusion society, in which multiple family groups come together to socialise. Females (cows) tend to live in family groups, which can consist of one female with her calves or several related females with offspring. The groups, which do not include bulls, are usually led by the oldest cow, known as the matriarch.Males (bulls) leave their family groups when they reach puberty and may live alone or with other males. Adult bulls mostly interact with family groups when looking for a mate. They enter a state of increased testosterone and aggression known as musth, which helps them gain dominance over other males as well as reproductive success. Calves are the centre of attention in their family groups and rely on their mothers for as long as three years. Elephants can live up to 70 years in the wild. They communicate by touch, sight, smell, and sound; elephants use infrasound, and seismic communication over long distances. Elephant intelligence has been compared with that of primates and cetaceans. They appear to have self-awareness, and appear to show empathy for dying and dead family members.African bush elephants and Asian elephants are listed as endangered and African forest elephants as critically endangered by the International Union for Conservation of Nature (IUCN). One of the biggest threats to elephant populations is the ivory trade, as the animals are poached for their ivory tusks. Other threats to wild elephants include habitat destruction and conflicts with local people. Elephants are used as working animals in Asia. In the past, they were used in war; today, they are often controversially put on display in zoos, or exploited for entertainment in circuses. Elephants are highly recognisable and have been featured in art, folklore, religion, literature, and popular culture.",
      "subTopics": []
    },
    {
      "heading": "Etymology",
      "description":
          "The word \"elephant\" is based on the Latin elephas (genitive elephantis) (\"elephant\"), which is the Latinised form of the Greek ἐλέφας (elephas) (genitive ἐλέφαντος (elephantos), probably from a non-Indo-European language, likely Phoenician. It is attested in Mycenaean Greek as e-re-pa (genitive e-re-pa-to) in Linear B syllabic script. As in Mycenaean Greek, Homer used the Greek word to mean ivory, but after the time of Herodotus, it also referred to the animal. The word \"elephant\" appears in Middle English as olyfaunt (c.1300) and was borrowed from Old French oliphant (12th century).",
      "subTopics": []
    },
    {
      "heading": "Taxonomy and phylogeny",
      "description":
          "Elephants belong to the family Elephantidae, the sole remaining family within the order Proboscidea which belongs to the superorder Afrotheria. Their closest extant relatives are the sirenians (dugongs and manatees) and the hyraxes, with which they share the clade Paenungulata within the superorder Afrotheria. Elephants and sirenians are further grouped in the clade Tethytheria.Three species of elephants are recognised; the African bush elephant (Loxodonta africana) and forest elephant (Loxodonta cyclotis) of sub-Saharan Africa, and the Asian elephant (Elephas maximus) of South and Southeast Asia. African elephants have larger ears, a concave back, more wrinkled skin, a sloping abdomen, and two finger-like extensions at the tip of the trunk. Asian elephants have smaller ears, a convex or level back, smoother skin, a horizontal abdomen that occasionally sags in the middle and one extension at the tip of the trunk. The looped ridges on the molars are narrower in the Asian elephant while those of the African are more diamond-shaped. The Asian elephant also has dorsal bumps on its head and some patches of depigmentation on its skin.Among African elephants, forest elephants have smaller and more rounded ears and thinner and straighter tusks than bush elephants and are limited in range to the forested areas of western and Central Africa. Both were traditionally considered a single species, Loxodonta africana, but molecular studies have affirmed their status as separate species. In 2017, DNA sequence analysis showed that L. cyclotis is more closely related to the extinct Palaeoloxodon antiquus, than it is to L. africana, possibly undermining the genus Loxodonta as a whole.",
      "subTopics": [
        {
          "heading": "Evolution and extinct relatives",
          "description":
              "Over 180 extinct members and three major evolutionary radiations of the order Proboscidea have been recorded. The earliest proboscids, the African Eritherium and Phosphatherium of the late Paleocene, heralded the first radiation. The Eocene included Numidotherium, Moeritherium, and Barytherium from Africa. These animals were relatively small and aquatic. Later on, genera such as Phiomia and Palaeomastodon arose; the latter likely inhabited forests and open woodlands. Proboscidean diversity declined during the Oligocene. One notable species of this epoch was Eritreum melakeghebrekristosi of the Horn of Africa, which may have been an ancestor to several later species. The beginning of the Miocene saw the second diversification, with the appearance of the deinotheres and the mammutids. The former were related to Barytherium and lived in Africa and Eurasia, while the latter may have descended from Eritreum and spread to North America.The second radiation was represented by the emergence of the gomphotheres in the Miocene, which likely evolved from Eritreum and originated in Africa, spreading to every continent except Australia and Antarctica. Members of this group included Gomphotherium and Platybelodon. The third radiation started in the late Miocene and led to the arrival of the elephantids, which descended from, and slowly replaced, the gomphotheres. The African Primelephas gomphotheroides gave rise to Loxodonta, Mammuthus, and Elephas. Loxodonta branched off earliest around the Miocene and Pliocene boundary while Mammuthus and Elephas diverged later during the early Pliocene. Loxodonta remained in Africa while Mammuthus and Elephas spread to Eurasia, and the former reached North America. At the same time, the stegodontids, another proboscidean group descended from gomphotheres, spread throughout Asia, including the Indian subcontinent, China, southeast Asia, and Japan. Mammutids continued to evolve into new species, such as the American mastodon.At the beginning of the Pleistocene, elephantids experienced a high rate of speciation. The Pleistocene also saw the arrival of Palaeoloxodon namadicus, the largest terrestrial mammal of all time. Loxodonta atlantica became the most common species in northern and southern Africa but was replaced by Elephas iolensis later in the Pleistocene. Only when Elephas disappeared from Africa did Loxodonta become dominant once again, this time in the form of the modern species. Elephas diversified into new species in Asia, such as E. hysudricus and E. platycephus; the latter the likely ancestor of the modern Asian elephant. Mammuthus evolved into several species, including the well-known woolly mammoth. Interbreeding appears to have been common among elephantid species, which in some cases led to species with three ancestral genetic components, such as the Palaeoloxodon antiquus. In the Late Pleistocene, most proboscidean species vanished during the Quaternary glaciation which killed off 50% of genera weighing over 5 kg (11 lb) worldwide.Proboscideans experienced several evolutionary trends, such as an increase in size, which led to many giant species that stood up to 500 cm (16 ft 5 in) tall. As with other megaherbivores, including the extinct sauropod dinosaurs, the large size of elephants likely developed to allow them to survive on vegetation with low nutritional value. Their limbs grew longer and the feet shorter and broader. The feet were originally plantigrade and developed into a digitigrade stance with cushion pads and the sesamoid bone providing support. Early proboscideans developed longer mandibles and smaller craniums while more derived ones developed shorter mandibles, which shifted the head's centre of gravity. The skull grew larger, especially the cranium, while the neck shortened to provide better support for the skull. The increase in size led to the development and elongation of the mobile trunk to provide reach. The number of premolars, incisors and canines decreased.The cheek teeth (molars and premolars) of proboscideans became larger and more specialized, especially after elephants started to switch from C3-plants to C4-grasses, which caused their teeth to undergo a three-fold increase in teeth height as well as substantial multiplication of lamellae after about five million years ago. Only in the last million years or so did they return to a diet mainly consisting of C3 trees and shrubs. The upper second incisors grew into tusks, which varied in shape from straight, to curved (either upward or downward), to spiralled, depending on the species. Some proboscideans developed tusks from their lower incisors. Elephants retain certain features from their aquatic ancestry, such as their middle ear anatomy.Several species of proboscideans lived on islands and experienced insular dwarfism. This occurred primarily during the Pleistocene when some elephant populations became isolated by fluctuating sea levels, although dwarf elephants did exist earlier in the Pliocene. These elephants likely grew smaller on islands due to a lack of large or viable predator populations and limited resources. By contrast, small mammals such as rodents develop gigantism in these conditions. Dwarf elephants are known to have lived in Indonesia, the Channel Islands of California, and several islands of the Mediterranean.",
          "subTopics": []
        }
      ]
    },
    {
      "heading": "Anatomy and morphology",
      "description":
          "Elephants are the largest living terrestrial animals. African bush elephants are the largest species, with males being 304–336 cm (10 ft 0 in–11 ft 0 in) tall at the shoulder with a body mass of 5.2–6.9 t (5.7–7.6 short tons) and females standing 247–273 cm (8 ft 1 in–8 ft 11 in) tall at the shoulder with a body mass of 2.6–3.5 t (2.9–3.9 short tons). Male Asian elephants are usually about 261–289 cm (8 ft 7 in–9 ft 6 in) tall at the shoulder and 3.5–4.6 t (3.9–5.1 short tons) whereas females are 228–252 cm (7 ft 6 in–8 ft 3 in) tall at the shoulder and 2.3–3.1 t (2.5–3.4 short tons). African forest elephants are the smallest species, with males usually being around 209–231 cm (6 ft 10 in–7 ft 7 in) tall at the shoulder and 1.7–2.3 t (1.9–2.5 short tons). Male African bush elephants are typically 23% taller than females, whereas male Asian elephants are only around 15% taller than females.",
      "subTopics": [
        {
          "heading": "Bones",
          "description":
              "The skeleton of the elephant is made up of 326–351 bones. The vertebrae are connected by tight joints, which limit the backbone's flexibility. African elephants have 21 pairs of ribs, while Asian elephants have 19 or 20 pairs.",
          "subTopics": []
        },
        {
          "heading": "Head",
          "description":
              "An elephant's skull is resilient enough to withstand the forces generated by the leverage of the tusks and head-to-head collisions. The back of the skull is flattened and spread out, creating arches that protect the brain in every direction. The skull contains air cavities (sinuses) that reduce the weight of the skull while maintaining overall strength. These cavities give the inside of the skull a honeycomb-like appearance. The cranium is particularly large and provides enough room for the attachment of muscles to support the entire head. The lower jaw is solid and heavy. Because of the size of the head, the neck is relatively short to provide better support. Lacking a lacrimal apparatus, the eye relies on the harderian gland to keep it moist. A durable nictitating membrane protects the eye globe. The animal's field of vision is compromised by the location and limited mobility of the eyes. Elephants are considered dichromats and they can see well in dim light but not in bright light.",
          "subTopics": []
        },
        {
          "heading": "Ears",
          "description":
              "Elephant ears have thick bases with thin tips. The ear flaps, or pinnae, contain numerous blood vessels called capillaries. Warm blood flows into the capillaries, helping to release excess body heat into the environment. This occurs when the pinnae are still, and the animal can enhance the effect by flapping them. Larger ear surfaces contain more capillaries, and more heat can be released. Of all the elephants, African bush elephants live in the hottest climates, and have the largest ear flaps. Elephants are capable of hearing at low frequencies and are most sensitive at 1 kHz (in close proximity to the Soprano C).",
          "subTopics": []
        },
        {
          "heading": "Trunk",
          "description":
              "The trunk, or proboscis, is a fusion of the nose and upper lip, although in early fetal life, the upper lip and trunk are separated. The trunk is elongated and specialised to become the elephant's most important and versatile appendage. It contains up to 150,000 separate muscle fascicles, with no bone and little fat. These paired muscles consist of two major types: superficial (surface) and internal. The former are divided into dorsals, ventrals, and laterals while the latter are divided into transverse and radiating muscles. The muscles of the trunk connect to a bony opening in the skull. The nasal septum is composed of tiny muscle units that stretch horizontally between the nostrils. Cartilage divides the nostrils at the base. As a muscular hydrostat, the trunk moves by precisely coordinated muscle contractions. The muscles work both with and against each other. A unique proboscis nerve – formed by the maxillary and facial nerves – runs along both sides of the trunk.Elephant trunks have multiple functions, including breathing, olfaction, touching, grasping, and sound production. The animal's sense of smell may be four times as sensitive as that of a bloodhound. The trunk's ability to make powerful twisting and coiling movements allows it to collect food, wrestle with other elephants, and lift up to 350 kg (770 lb). It can be used for delicate tasks, such as wiping an eye and checking an orifice, and is capable of cracking a peanut shell without breaking the seed. With its trunk, an elephant can reach items at heights of up to 7 m (23 ft) and dig for water under mud or sand. Individuals may show lateral preference when grasping with their trunks: some prefer to twist them to the left, others to the right. Elephants are capable of dilating their nostrils at a radius of nearly 30%, increasing the nasal volume by 64%, and can inhale at over 150 m/s (490 ft/s) which is around 30 times the speed of a human sneeze. Elephants can suck up food and water both to spray in the mouth and, in the case of the later, to sprinkle on their bodies. An adult Asian elephant is capable of holding 8.5 L (2.2 US gal) of water in its trunk.  They will also spray dust or grass on themselves. When underwater, the elephant uses its trunk as a snorkel.The African elephant has two finger-like extensions at the tip of the trunk that allow it to grasp and bring food to its mouth. The Asian elephant has only one and relies more on wrapping around a food item and squeezing it into its mouth. Asian elephants have more muscle coordination and can perform more complex tasks. Losing the trunk would be detrimental to an elephant's survival, although in rare cases, individuals have survived with shortened ones. One elephant has been observed to graze by kneeling on its front legs, raising on its hind legs and taking in grass with its lips. Floppy trunk syndrome is a condition of trunk paralysis in African bush elephants caused by the degradation of the peripheral nerves and muscles beginning at the tip.",
          "subTopics": []
        },
        {
          "heading": "Teeth",
          "description":
              "Elephants usually have 26 teeth: the incisors, known as the tusks, 12 deciduous premolars, and 12 molars. Unlike most mammals, which grow baby teeth and then replace them with a single permanent set of adult teeth, elephants are polyphyodonts that have cycles of tooth rotation throughout their lives. The chewing teeth are replaced six times in a typical elephant's lifetime. Teeth are not replaced by new ones emerging from the jaws vertically as in most mammals. Instead, new teeth grow in at the back of the mouth and move forward to push out the old ones. The first chewing tooth on each side of the jaw falls out when the elephant is two to three years old. The second set of chewing teeth falls out at four to six years old. The third set falls out at 9–15 years of age and set four lasts until 18–28 years of age. The fifth set of teeth falls out at the early 40s. The sixth (and usually final) set must last the elephant the rest of its life. Elephant teeth have loop-shaped dental ridges, which are thicker and more diamond-shaped in African elephants.",
          "subTopics": []
        },
        {
          "heading": "Teeth",
          "description":
              "The tusks of an elephant are modified second incisors in the upper jaw. They replace deciduous milk teeth at 6–12 months of age and grow continuously at about 17 cm (7 in) a year. A newly developed tusk has a smooth enamel cap that eventually wears off. The dentine is known as ivory and its cross-section consists of crisscrossing line patterns, known as \"engine turning\", which create diamond-shaped areas. As a piece of living tissue, a tusk is relatively soft; it is as hard as the mineral calcite. Much of the tusk can be seen outside; the rest is in a socket in the skull. At least one-third of the tusk contains the pulp and some have nerves stretching to the tip. Thus it would be difficult to remove it without harming the animal. When removed, ivory begins to dry up and crack if not kept cool and moist. Tusks serve multiple purposes. They are used for digging for water, salt, and roots; debarking or marking trees; and for moving trees and branches when clearing a path. When fighting, they are used to attack and defend, and to protect the trunk.Like humans, who are typically right- or left-handed, elephants are usually right- or left-tusked. The dominant tusk, called the master tusk, is generally more worn down, as it is shorter with a rounder tip. For the African elephants, tusks are present in both males and females, and are around the same length in both sexes, reaching up to 300 cm (9 ft 10 in), but those of males tend to be thicker. In earlier times, elephant tusks weighing over 200 pounds (more than 90 kg) were not uncommon, though it is rare today to see any over 100 pounds (45 kg).In the Asian species, only the males have large tusks. Female Asians have very small tusks, or none at all. Tuskless males exist and are particularly common among Sri Lankan elephants. Asian males can have tusks as long as Africans', but they are usually slimmer and lighter; the largest recorded was 302 cm (9 ft 11 in) long and weighed 39 kg (86 lb). Hunting for elephant ivory in Africa and Asia has led to natural selection for shorter tusks and tusklessness.",
          "subTopics": []
        },
        {
          "heading": "Skin",
          "description":
              "An elephant's skin is generally very tough, at 2.5 cm (1 in) thick on the back and parts of the head. The skin around the mouth, anus, and inside of the ear is considerably thinner. Elephants typically have grey skin, but African elephants look brown or reddish after wallowing in coloured mud. Asian elephants have some patches of depigmentation, particularly on the forehead and ears and the areas around them. Calves have brownish or reddish hair, especially on the head and back. As elephants mature, their hair darkens and becomes sparser, but dense concentrations of hair and bristles remain on the end of the tail as well as the chin, genitals and the areas around the eyes and ear openings. Normally the skin of an Asian elephant is covered with more hair than its African counterpart. Their hair is thought to be for thermoregulation, helping them lose heat in their hot environments.An elephant uses mud as a sunscreen, protecting its skin from ultraviolet light. Although tough, an elephant's skin is very sensitive. Without regular mud baths to protect it from burning, insect bites and moisture loss, an elephant's skin suffers serious damage. After bathing, the elephant will usually use its trunk to blow dust onto its body and this dries into a protective crust. Elephants have difficulty releasing heat through the skin because of their low surface-area-to-volume ratio, which is many times smaller than that of a human. They have even been observed lifting up their legs, presumably in an effort to expose their soles to the air.",
          "subTopics": []
        },
        {
          "heading": "Legs, locomotion, and posture",
          "description":
              "To support the animal's weight, an elephant's limbs are positioned more vertically under the body than in most other mammals. The long bones of the limbs have cancellous bone in place of medullary cavities. This strengthens the bones while still allowing haematopoiesis. Both the front and hind limbs can support an elephant's weight, although 60% is borne by the front. Since the limb bones are placed on top of each other and under the body, an elephant can stand still for long periods of time without using much energy. Elephants are incapable of rotating their front legs, as the ulna and radius are fixed in pronation; the \"palm\" of the manus faces backward. The pronator quadratus and the pronator teres are either reduced or absent. The circular feet of an elephant have soft tissues or \"cushion pads\" beneath the manus or pes, which distribute the weight of the animal. They appear to have a sesamoid, an extra \"toe\" similar in placement to a giant panda's extra \"thumb\", that also helps in weight distribution. As many as five toenails can be found on both the front and hind feet.Elephants can move both forwards and backwards, but cannot trot, jump, or gallop. They use only two gaits when moving on land: the walk and a faster gait similar to running. In walking, the legs act as pendulums, with the hips and shoulders rising and falling while the foot is planted on the ground. With no \"aerial phase\", the fast gait does not meet all the criteria of running, although the elephant uses its legs much like other running animals, with the hips and shoulders falling and then rising while the feet are on the ground. Fast-moving elephants appear to 'run' with their front legs, but 'walk' with their hind legs and can reach a top speed of 25 km/h (16 mph). At this speed, most other quadrupeds are well into a gallop, even accounting for leg length. Spring-like kinetics could explain the difference between the motion of elephants and other animals. During locomotion, the cushion pads expand and contract, and reduce both the pain and noise that would come from a very heavy animal moving. Elephants are capable swimmers. They have been recorded swimming for up to six hours without touching the bottom, and have travelled as far as 48 km (30 mi) at a stretch and at speeds of up to 2.1 km/h (1 mph).",
          "subTopics": []
        },
        {
          "heading": "Organs",
          "description":
              "The brain of an elephant weighs 4.5–5.5 kg (10–12 lb) compared to 1.6 kg (4 lb) for a human brain. While the elephant brain is larger overall, it is proportionally smaller. At birth, an elephant's brain already weighs 30–40% of its adult weight. The cerebrum and cerebellum are well developed, and the temporal lobes are so large that they bulge out laterally. The throat of an elephant appears to contain a pouch where it can store water for later use. The larynx of the elephant is the largest known among mammals. The vocal folds are long and are attached close to the epiglottis base. When comparing an elephant's vocal folds to those of a human, an elephant's are longer, thicker, and have a larger cross-sectional area. In addition, they are tilted at 45 degrees and positioned more anteriorly than a human's vocal folds.The heart of an elephant weighs 12–21 kg (26–46 lb). It has a double-pointed apex, an unusual trait among mammals. In addition, the ventricles separate near the top of the heart, a trait they share with sirenians. When standing, the elephant's heart beats approximately 30 times per minute. Unlike many other animals, the heart rate speeds up by 8 to 10 beats per minute when the elephant is lying down. The blood vessels in most of the body are wide and thick and can withstand high blood pressures. The lungs are attached to the diaphragm, and breathing relies mainly on the diaphragm rather than the expansion of the ribcage. Connective tissue exists in place of the pleural cavity. This may allow the animal to deal with the pressure differences when its body is underwater and its trunk is breaking the surface for air, although this explanation has been questioned. Another possible function for this adaptation is that it helps the animal suck up water through the trunk. Elephants inhale mostly through the trunk, although some air goes through the mouth. They have a hindgut fermentation system, and their large and small intestines together reach 35 m (115 ft) in length. The majority of an elephant's food intake goes undigested despite the process lasting up to a day.A male elephant's testes are located internally near the kidneys. The elephant's penis can reach a length of 100 cm (39 in) and a diameter of 16 cm (6 in) at the base. It is S-shaped when fully erect and has a Y-shaped orifice. The female has a well-developed clitoris at up to 40 cm (16 in). The vulva is located between the hind legs instead of near the tail as in most mammals. Determining pregnancy status can be difficult due to the animal's large abdominal cavity. The female's mammary glands occupy the space between the front legs, which puts the suckling calf within reach of the female's trunk. Elephants have a unique organ, the temporal gland, located in both sides of the head. This organ is associated with sexual behaviour, and males secrete a fluid from it when in musth. Females have also been observed with secretions from the temporal glands.",
          "subTopics": []
        },
        {
          "heading": "Body temperature",
          "description":
              "Elephants are homeotherms, and maintain their average body temperature at ~ 36 °C, with minimum 35.2 °C during cool season, and maximum 38.0 °C during hot dry season. Sweat glands are absent in the elephant's skin, but water diffuses through the skin, allowing cooling by evaporative loss. Other physiological or behavioral features may assist with thermoregulation such as flapping ears, mud bathing, spraying water on the skin, seeking shade, and adopting different walking patterns. In addition, the interconnected crevices in the elephant's skin is thought to impede dehydration and improve thermal regulation over a long period of time.",
          "subTopics": []
        }
      ]
    },
    {
      "heading": "Behaviour and life history",
      "description":
          "The African bush elephant can be found in habitats as diverse as dry savannahs, deserts, marshes, and lake shores, and in elevations from sea level to mountains above the snow line. Forest elephants mainly live in equatorial forests but will enter gallery forests and ecotones between forests and savannahs. Asian elephants prefer areas with a mix of grasses, low woody plants, and trees, primarily inhabiting dry thorn-scrub forests in southern India and Sri Lanka and evergreen forests in Malaya. Elephants are herbivorous and will eat leaves, twigs, fruit, bark, grass and roots. They are born with sterile intestines and require bacteria obtained from their mother's feces to digest vegetation. African elephants are mostly browsers while Asian elephants are mainly grazers. They can consume as much as 150 kg (330 lb) of food and 40 L (11 US gal) of water in a day. Elephants tend to stay near water sources. Major feeding bouts take place in the morning, afternoon and night. At midday, elephants rest under trees and may doze off while standing. Sleeping occurs at night while the animal is lying down. Elephants average 3–4 hours of sleep per day. Both males and family groups typically move 10–20 km (6–12 mi) a day, but distances as far as 90–180 km (56–112 mi) have been recorded in the Etosha region of Namibia. Elephants go on seasonal migrations in search of food, water, minerals, and mates. At Chobe National Park, Botswana, herds travel 325 km (202 mi) to visit the river when the local waterholes dry up.Because of their large size, elephants have a huge impact on their environments and are considered keystone species. Their habit of uprooting trees and undergrowth can transform savannah into grasslands; when they dig for water during drought, they create waterholes that can be used by other animals. They can enlarge waterholes when they bathe and wallow in them. At Mount Elgon, elephants excavate caves that are used by ungulates, hyraxes, bats, birds and insects. Elephants are important seed dispersers; African forest elephants ingest and defecate seeds, with either no effect or a positive effect on germination. The seeds are typically dispersed in large amounts over great distances. In Asian forests, large seeds require giant herbivores like elephants and rhinoceros for transport and dispersal. This ecological niche cannot be filled by the next largest herbivore, the tapir. Because most of the food elephants eat goes undigested, their dung can provide food for other animals, such as dung beetles and monkeys. Elephants can have a negative impact on ecosystems. At Murchison Falls National Park in Uganda, the overabundance of elephants has threatened several species of small birds that depend on woodlands. Their weight can compact the soil, which causes the rain to run off, leading to erosion.Elephants typically coexist peacefully with other herbivores, which will usually stay out of their way. Some aggressive interactions between elephants and rhinoceros have been recorded. At Aberdare National Park, Kenya, a rhino attacked an elephant calf and was killed by the other elephants in the group. At Hluhluwe–Umfolozi Game Reserve, South Africa, introduced young orphan elephants went on a killing spree that claimed the lives of 36 rhinos during the 1990s, but ended with the introduction of older males. The size of adult elephants makes them nearly invulnerable to predators. Calves may be preyed on by lions, spotted hyenas, and wild dogs in Africa and tigers in Asia. The lions of Savuti, Botswana, have adapted to hunting elephants, mostly calves, juveniles or even sub-adults, during the dry season, and a pride of 30 lions has been normally recorded killing juvenile individuals between the ages of four and eleven years, and a young bull of about 15 years in an exceptional case. There are rare reports of adult Asian elephants falling prey to tigers. Elephants appear to distinguish between the growls of larger predators like tigers and smaller predators like leopards (which have not been recorded killing calves); they react to leopards less fearfully and more aggressively. Elephants tend to have high numbers of parasites, particularly nematodes, compared to other herbivores. This is due to lower predation pressures that would otherwise kill off many of the individuals with significant parasite loads.",
      "subTopics": [
        {
          "heading": "Social organisation",
          "description":
              "Female elephants spend their entire lives in tight-knit matrilineal family groups, some of which are made up of more than ten members, including three mothers and their dependent offspring, and are led by the matriarch which is often the eldest female. She remains leader of the group until death or if she no longer has the energy for the role; a study on zoo elephants showed that when the matriarch died, the levels of faecal corticosterone ('stress hormone') dramatically increased in the surviving elephants. When her tenure is over, the matriarch's eldest daughter takes her place; this occurs even if her sister is present. One study found that younger matriarchs are more likely than older ones to under-react to severe danger. Family groups may split after becoming too large for the available resources.The social circle of the female elephant does not necessarily end with the small family unit. In the case of elephants in Amboseli National Park, Kenya, a female's life involves interaction with other families, clans, and subpopulations. Families may associate and bond with each other, forming what are known as bond groups which typically made of two family groups. During the dry season, elephant families may cluster together and form another level of social organisation known as the clan. Groups within these clans do not form strong bonds, but they defend their dry-season ranges against other clans. There are typically nine groups in a clan. The Amboseli elephant population is further divided into the \"central\" and \"peripheral\" subpopulations.Some elephant populations in India and Sri Lanka have similar basic social organisations. There appear to be cohesive family units and loose aggregations. They have been observed to have \"nursing units\" and \"juvenile-care units\". In southern India, elephant populations may contain family groups, bond groups and possibly clans. Family groups tend to be small, consisting of one or two adult females and their offspring. A group containing more than two adult females plus offspring is known as a \"joint family\". Malay elephant populations have even smaller family units and do not have any social organisation higher than a family or bond group. Groups of African forest elephants typically consist of one adult female with one to three offspring. These groups appear to interact with each other, especially at forest clearings.The social life of the adult male is very different. As he matures, a male spends more time at the edge of his group and associates with outside males or even other families. At Amboseli, young males spend over 80% of their time away from their families when they are 14–15. When males permanently leave, they either live alone or with other males. The former is typical of bulls in dense forests. Asian males are usually solitary, but occasionally form groups of two or more individuals; the largest consisted of seven bulls. Larger bull groups consisting of over 10 members occur only among African bush elephants, the largest of which numbered up to 144 individuals. Bulls only return to the herd to breed or to socialize, they do not provide prenatal care to their offspring but rather play a fatherly role to younger bulls to show dominance.Male elephants can be quite sociable when not competing for dominance or mates, and will form long-term relationships. A dominance hierarchy exists among males, whether they range socially or solitarily. Dominance depends on the age, size and sexual condition, and when in groups, males follow the lead of the dominant bull. Young bulls may seek out the company and leadership of older, more experienced males, whose presence appears to control their aggression and prevent them from exhibiting \"deviant\" behaviour. Adult males and females come together for reproduction. Bulls associate with family groups if an oestrous cow is present.",
          "subTopics": []
        },
        {
          "heading": "Sexual behaviour",
          "description":
              "Adult males enter a state of increased testosterone known as musth. In a population in southern India, males first enter musth at the age of 15, but it is not very intense until they are older than 25. At Amboseli, bulls under 24 do not go into musth, while half of those aged 25–35 and all those over 35 do. Young bulls appear to enter musth during the dry season (January–May), while older bulls go through it during the wet season (June–December). The main characteristic of a bull's musth is a fluid secreted from the temporal gland that runs down the side of his face. He may urinate with his penis still in his sheath, which causes the urine to spray on his hind legs. Behaviours associated with musth include walking with the head held high and swinging, picking at the ground with the tusks, marking, rumbling and waving only one ear at a time. This can last from a day to four months.Males become extremely aggressive during musth. Size is the determining factor in agonistic encounters when the individuals have the same condition. In contests between musth and non-musth individuals, musth bulls win the majority of the time, even when the non-musth bull is larger. A male may stop showing signs of musth when he encounters a musth male of higher rank. Those of equal rank tend to avoid each other. Agonistic encounters typically consist of threat displays, chases, and minor sparring with the tusks. Serious fights are rare.",
          "subTopics": []
        },
        {
          "heading": "Sexual behaviour",
          "description":
              "Elephants are polygynous breeders, and copulations are most frequent during the peak of the wet season. A cow in oestrus releases chemical signals (pheromones) in her urine and vaginal secretions to signal her readiness to mate. A bull will follow a potential mate and assess her condition with the flehmen response, which requires the male to collect a chemical sample with his trunk and bring it to the vomeronasal organ. The oestrous cycle of a cow lasts 14–16 weeks with a 4–6-week follicular phase and an 8- to 10-week luteal phase. While most mammals have one surge of luteinizing hormone during the follicular phase, elephants have two. The first (or anovulatory) surge, could signal to males that the female is in oestrus by changing her scent, but ovulation does not occur until the second (or ovulatory) surge. Fertility rates in cows decline around 45–50 years of age.Bulls engage in a behaviour known as mate-guarding, where they follow oestrous females and defend them from other males. Most mate-guarding is done by musth males, and females actively seek to be guarded by them, particularly older ones. Thus these bulls have more reproductive success. Musth appears to signal to females the condition of the male, as weak or injured males do not have normal musths. For young females, the approach of an older bull can be intimidating, so her relatives stay nearby to provide support and reassurance. During copulation, the male lays his trunk over the female's back. The penis is very mobile, being able to move independently of the pelvis. Prior to mounting, it curves forward and upward. Copulation lasts about 45 seconds and does not involve pelvic thrusting or ejaculatory pause. Elephant sperm must swim close to 2 m (6.6 ft) to reach the egg. By comparison, human sperm has to swim around only 76.2 mm (3.00 in).Homosexual behaviour is frequent in both sexes. As in heterosexual interactions, this involves mounting. Male elephants sometimes stimulate each other by playfighting and \"championships\" may form between old bulls and younger males. Female same-sex behaviours have been documented only in captivity where they are known to masturbate one another with their trunks.",
          "subTopics": []
        },
        {
          "heading": "Birth and development",
          "description":
              "Gestation in elephants typically lasts around two years with interbirth intervals usually lasting four to five years. Births tend to take place during the wet season. Calves are born 85 cm (33 in) tall and weigh around 120 kg (260 lb). Typically, only a single young is born, but twins sometimes occur. The relatively long pregnancy is maintained by five corpus luteums (as opposed to one in most mammals) and gives the foetus more time to develop, particularly the brain and trunk. As such, newborn elephants are precocial and quickly stand and walk to follow their mother and family herd. A new calf is usually the centre of attention for herd members. Adults and most of the other young will gather around the newborn, touching and caressing it with their trunks. For the first few days, the mother is intolerant of other herd members near her young. Alloparenting – where a calf is cared for by someone other than its mother – takes place in some family groups. Allomothers are typically two to twelve years old.For the first few days, the newborn is unsteady on its feet and needs the support of its mother. It relies on touch, smell, and hearing, as its eyesight is poor. It has little precise control over its trunk, which wiggles around and may cause it to trip. By its second week of life, the calf can walk more firmly and has more control over its trunk. After its first month, a calf can pick up, hold, and put objects in its mouth, but cannot suck water through the trunk and must drink directly through the mouth. It is still dependent on its mother and keeps close to her.For its first three months, a calf relies entirely on milk from its mother for nutrition, after which it begins to forage for vegetation and can use its trunk to collect water. At the same time, improvements in lip and leg coordination occur. Calves continue to suckle at the same rate as before until their sixth month, after which they become more independent when feeding. By nine months, mouth, trunk and foot coordination is perfected. After a year, a calf's abilities to groom, drink, and feed itself are fully developed. It still needs its mother for nutrition and protection from predators for at least another year. Suckling bouts tend to last 2–4 min/hr for a calf younger than a year and it continues to suckle until it reaches three years of age or older. Suckling after two years may serve to maintain growth rate, body condition and reproductive ability.Play behaviour in calves differs between the sexes; females run or chase each other while males play-fight. The former are sexually mature by the age of nine years while the latter become mature around 14–15 years. Adulthood starts at about 18 years of age in both sexes. Elephants have long lifespans, reaching 60–70 years of age. Lin Wang, a captive male Asian elephant, lived for 86 years.",
          "subTopics": []
        },
        {
          "heading": "Communication",
          "description":
              "Touching is an important form of communication among elephants. Individuals greet each other by stroking or wrapping their trunks; the latter also occurs during mild competition. Older elephants use trunk-slaps, kicks, and shoves to discipline younger ones. Individuals of any age and sex will touch each other's mouths, temporal glands, and genitals, particularly during meetings or when excited. This allows individuals to pick up chemical cues. Touching is especially important for mother–calf communication. When moving, elephant mothers will touch their calves with their trunks or feet when side-by-side or with their tails if the calf is behind them. If a calf wants to rest, it will press against its mother's front legs and when it wants to suckle, it will touch her breast or leg.Visual displays mostly occur in agonistic situations. Elephants will try to appear more threatening by raising their heads and spreading their ears. They may add to the display by shaking their heads and snapping their ears, as well as throwing dust and vegetation. They are usually bluffing when performing these actions. Excited elephants may raise their trunks. Submissive ones will lower their heads and trunks, as well as flatten their ears against their necks, while those that accept a challenge will position their ears in a V shape.Elephants produce several vocalisations, usually through the larynx, though some may be modified by the trunk. These include trumpets, roars, barks, snorts, growls and rumbles which may be produced for either short or long range communication. Elephants may produce infrasonic rumbles. For Asian elephants, these calls have a frequency of 14–24 Hz, with sound pressure levels of 85–90 dB and last 10–15 seconds. For African elephants, calls range from 15 to 35 Hz with sound pressure levels as high as 117 dB, allowing communication for many kilometres, with a possible maximum range of around 10 km (6 mi).Elephants are known to communicate with seismics, vibrations produced by impacts on the earth's surface or acoustical waves that travel through it. An individual running or mock charging can create seismic signals that can be heard at travel distances of up to 32 km (20 mi). Seismic waveforms produced from predator alarm calls travel 16 km (10 mi).",
          "subTopics": []
        },
        {
          "heading": "Intelligence and cognition",
          "description":
              "Elephants exhibit mirror self-recognition, an indication of self-awareness and cognition that has also been demonstrated in some apes and dolphins. One study of a captive female Asian elephant suggested the animal was capable of learning and distinguishing between several visual and some acoustic discrimination pairs. This individual was even able to score a high accuracy rating when re-tested with the same visual pairs a year later. Elephants are among the species known to use tools. An Asian elephant has been observed modifying branches and using them as flyswatters. Tool modification by these animals is not as advanced as that of chimpanzees. Elephants are popularly thought of as having an excellent memory. This could have a factual basis; they possibly have cognitive maps to allow them to remember large-scale spaces over long periods of time. Individuals appear to be able to keep track of the current location of their family members.Scientists debate the extent to which elephants feel emotion. They appear to show interest in the bones of their own kind, regardless of whether they are related. As with chimps and dolphins, a dying or dead elephant may elicit attention and aid from others, including those from other groups. This has been interpreted as expressing \"concern\"; however, others would dispute such an interpretation as being anthropomorphic; the Oxford Companion to Animal Behaviour (1987) advised that \"one is well advised to study the behaviour rather than attempting to get at any underlying emotion\".",
          "subTopics": []
        }
      ]
    },
    {
      "heading": "Conservation",
      "description":
          "African bush elephants were listed as Endangered by the International Union for Conservation of Nature (IUCN) in 2021, and African forest elephants were listed as Critically Endangered in the same year. In 1979, Africa had an estimated minimum population of 1.3 million elephants, with a possible upper limit of 3.0 million. By 1989, the population was estimated to be 609,000; with 277,000 in Central Africa, 110,000 in eastern Africa, 204,000 in southern Africa, and 19,000 in western Africa. About 214,000 elephants were estimated to live in the rainforests, fewer than had previously been thought. From 1977 to 1989, elephant populations declined by 74% in East Africa. After 1987, losses in elephant numbers accelerated, and savannah populations from Cameroon to Somalia experienced a decline of 80%. African forest elephants had a total loss of 43%. Population trends in southern Africa were mixed, with anecdotal reports of losses in Zambia, Mozambique and Angola while populations grew in Botswana and Zimbabwe and were stable in South Africa. Conversely, studies in 2005 and 2007 found populations in eastern and southern Africa were increasing by an average annual rate of 4.0%. The IUCN estimated that total population in Africa is estimated at around to 415,000 individuals for both species combined as of 2016.African elephants receive at least some legal protection in every country where they are found, but 70% of their range exists outside protected areas. Successful conservation efforts in certain areas have led to high population densities. As of 2008, local numbers were controlled by contraception or translocation. Large-scale cullings ceased in 1988 when Zimbabwe abandoned the practice. In 1989, the African elephant was listed under Appendix I by the Convention on International Trade in Endangered Species of Wild Fauna and Flora (CITES), making trade illegal. Appendix II status (which allows restricted trade) was given to elephants in Botswana, Namibia, and Zimbabwe in 1997 and South Africa in 2000. In some countries, sport hunting of the animals is legal; Botswana, Cameroon, Gabon, Mozambique, Namibia, South Africa, Tanzania, Zambia, and Zimbabwe have CITES export quotas for elephant trophies. In June 2016, the First Lady of Kenya, Margaret Kenyatta, helped launch the East Africa Grass-Root Elephant Education Campaign Walk, organised by elephant conservationist Jim Nyamu. The event was conducted to raise awareness of the value of elephants and rhinos, to help mitigate human-elephant conflicts, and to promote anti-poaching activities.In 2020, the IUCN listed the Asian elephant as endangered due to an almost 50% population decline over \"the last three generations\" Asian elephants once ranged from Syria and Iraq (the subspecies Elephas maximus asurus), to China (up to the Yellow River) and Java. It is now extinct in these areas, and the current range of Asian elephants is highly fragmented. The total population of Asian elephants is estimated to be around 40,000–50,000, although this may be a loose estimate. Around 60% of the population is in India. Although Asian elephants are declining in numbers overall, particularly in Southeast Asia, the population in the Western Ghats appears to be increasing.",
      "subTopics": [
        {
          "heading": "Threats",
          "description":
              "The poaching of elephants for their ivory, meat and hides has been one of the major threats to their existence. Historically, numerous cultures made ornaments and other works of art from elephant ivory, and its use rivalled that of gold. The ivory trade contributed to the African elephant population decline in the late 20th century. This prompted international bans on ivory imports, starting with the United States in June 1989, and followed by bans in other North American countries, western European countries, and Japan. Around the same time, Kenya destroyed all its ivory stocks. CITES approved an international ban on ivory that went into effect in January 1990. Following the bans, unemployment rose in India and China, where the ivory industry was important economically. By contrast, Japan and Hong Kong, which were also part of the industry, were able to adapt and were not badly affected. Zimbabwe, Botswana, Namibia, Zambia, and Malawi wanted to continue the ivory trade and were allowed to, since their local elephant populations were healthy, but only if their supplies were from elephants that had been culled or died of natural causes.The ban allowed the elephant to recover in parts of Africa. In January 2012, 650 elephants in Bouba Njida National Park, Cameroon, were killed by Chadian raiders. This has been called \"one of the worst concentrated killings\" since the ivory ban. Asian elephants are potentially less vulnerable to the ivory trade, as females usually lack tusks. Still, members of the species have been killed for their ivory in some areas, such as Periyar National Park in India. China was the biggest market for poached ivory but announced they would phase out the legal domestic manufacture and sale of ivory products in May 2015, and in September 2015, China and the United States said \"they would enact a nearly complete ban on the import and export of ivory\" due to causes of extinction.Other threats to elephants include habitat destruction and fragmentation. The Asian elephant lives in areas with some of the highest human populations and may be confined to small islands of forest among human-dominated landscapes. Elephants commonly trample and consume crops, which contributes to conflicts with humans, and both elephants and humans have died by the hundreds as a result. Mitigating these conflicts is important for conservation. One proposed solution is the protection of wildlife corridors which gave the animals greater space and maintain the long term viability of large populations.",
          "subTopics": []
        }
      ]
    },
    {
      "heading": "Association with humans",
      "description":
          "Elephants have been working animals since at least the Indus Valley Civilization and continue to be used in modern times. There were 13,000–16,500 working elephants employed in Asia in 2000. These animals are typically captured from the wild when they are 10–20 years old when they can be trained quickly and easily, and will have a longer working life. They were traditionally captured with traps and lassos, but since 1950, tranquillisers have been used.Individuals of the Asian species have been often trained as working animals. Asian elephants perform tasks such as hauling loads into remote areas, moving logs to rivers and roads, transporting tourists around national parks, pulling wagons, and leading religious processions. In northern Thailand, the animals are used to digest coffee beans for Black Ivory coffee. They are valued over mechanised tools because they can work in relatively deep water, require relatively little maintenance, need only vegetation and water as fuel and can be trained to memorise specific tasks. Elephants can be trained to respond to over 30 commands. Musth bulls can be difficult and dangerous to work with and are chained and semi-starved until the condition passes. In India, many working elephants are alleged to have been subject to abuse. They and other captive elephants are thus protected under The Prevention of Cruelty to Animals Act of 1960.In both Myanmar and Thailand, deforestation and other economic factors have resulted in sizable populations of unemployed elephants resulting in health problems for the elephants themselves as well as economic and safety problems for the people amongst whom they live.The practice of working elephants has also been attempted in Africa. The taming of African elephants in the Belgian Congo began by decree of Leopold II of Belgium during the 19th century and continues to the present with the Api Elephant Domestication Centre.",
      "subTopics": [
        {
          "heading": "Warfare",
          "description":
              "Historically, elephants were considered formidable instruments of war. They were equipped with armour to protect their sides, and their tusks were given sharp points of iron or brass if they were large enough. War elephants were trained to grasp an enemy soldier and toss him to the person riding on them or to pin the soldier to the ground and impale him.One of the earliest references to war elephants is in the Indian epic Mahabharata (written in the 4th century BC, but said to describe events between the 11th and 8th centuries BC). They were not used as much as horse-drawn chariots by either the Pandavas or Kauravas. During the Magadha Kingdom (which began in the 6th century BC), elephants began to achieve greater cultural importance than horses, and later Indian kingdoms used war elephants extensively; 3,000 of them were used in the Nandas (5th and 4th centuries BC) army while 9,000 may have been used in the Mauryan army (between the 4th and 2nd centuries BC). The Arthashastra (written around 300 BC) advised the Mauryan government to reserve some forests for wild elephants for use in the army, and to execute anyone who killed them. From South Asia, the use of elephants in warfare spread west to Persia and east to Southeast Asia. The Persians used them during the Achaemenid Empire (between the 6th and 4th centuries BC) while Southeast Asian states first used war elephants possibly as early as the 5th century BC and continued to the 20th century.In his 326 B.C. Indian campaign, Alexander the Great confronted elephants for the first time and suffered heavy casualties. Among the reasons for the refusal of the rank-and-file Macedonian soldiers to continue the Indian conquest were rumors of even larger elephant armies in India. Alexander trained his foot soldiers to injure the animals and cause them to panic during wars with both the Persians and Indians. Ptolemy, who was one of Alexander's generals, used corps of Asian elephants during his reign as the ruler of Egypt (which began in 323 BC). His son and successor Ptolemy II (who began his rule in 285 BC) obtained his supply of elephants further south in Nubia. From then on, war elephants were employed in the Mediterranean and North Africa throughout the classical period. The Greek king Pyrrhus used elephants in his attempted invasion of Rome in 280 BC. While they frightened the Roman horses, they were not decisive and Pyrrhus ultimately lost the battle. The Carthaginian general Hannibal took elephants across the Alps during his war with the Romans and reached the Po Valley in 217 BC with all of them alive, but they later succumbed to disease.Overall, elephants owed their initial successes to the element of surprise and to the fear that their great size invoked. With time, strategists devised counter-measures and war elephants turned into an expensive liability and were hardly ever used by Romans and Parthians.",
          "subTopics": []
        },
        {
          "heading": "Zoos and circuses",
          "description":
              "Elephants were historically kept for display in the menageries of Ancient Egypt, China, Greece, and Rome. The Romans in particular pitted them against humans and other animals in gladiator events. In the modern era, elephants have traditionally been a major part of zoos and circuses around the world. In circuses, they are trained to perform tricks. The most famous circus elephant was probably Jumbo (1861 – 15 September 1885), who was a major attraction in the Barnum & Bailey Circus. These animals do not reproduce well in captivity, due to the difficulty of handling musth bulls and limited understanding of female oestrous cycles. Asian elephants were always more common than their African counterparts in modern zoos and circuses. After CITES listed the Asian elephant under Appendix I in 1975, the number of African elephants in zoos increased in the 1980s, although the import of Asians continued. Subsequently, the US received many of its captive African elephants from Zimbabwe, which had an overabundance of the animals.Keeping elephants in zoos has met with some controversy. Proponents of zoos argue that they offer researchers easy access to the animals and provide money and expertise for preserving their natural habitats, as well as safekeeping for the species. Critics claim that the animals in zoos are under physical and mental stress. Elephants have been recorded displaying stereotypical behaviours in the form of swaying back and forth, trunk swaying, or route tracing. This has been observed in 54% of individuals in UK zoos. Elephants in European zoos appear to have shorter lifespans than their wild counterparts at only 17 years, although other studies suggest that zoo elephants live as long those in the wild.The use of elephants in circuses has also been controversial; the Humane Society of the United States has accused circuses of mistreating and distressing their animals. In testimony to a US federal court in 2009, Barnum & Bailey Circus CEO Kenneth Feld acknowledged that circus elephants are struck behind their ears, under their chins and on their legs with metal-tipped prods, called bull hooks or ankus. Feld stated that these practices are necessary to protect circus workers and acknowledged that an elephant trainer was reprimanded for using an electric shock device, known as a hot shot or electric prod, on an elephant. Despite this, he denied that any of these practices harm elephants. Some trainers have tried to train elephants without the use of physical punishment. Ralph Helfer is known to have relied on gentleness and reward when training his animals, including elephants and lions. Ringling Bros. and Barnum and Bailey circus retired its touring elephants in May 2016.",
          "subTopics": []
        },
        {
          "heading": "Attacks",
          "description":
              "Elephants can exhibit bouts of aggressive behaviour and engage in destructive actions against humans. In Africa, groups of adolescent elephants damaged homes in villages after cullings in the 1970s and 1980s. Because of the timing, these attacks have been interpreted as vindictive. In parts of India, male elephants regularly enter villages at night, destroying homes and killing people. Elephants killed around 300 people between 2000 and 2004 in Jharkhand while in Assam, 239 people were reportedly killed between 2001 and 2006.Local people have reported their belief that some elephants were drunk during their attacks, although officials have disputed this explanation. Purportedly drunk elephants attacked an Indian village a second time in December 2002, killing six people, which led to the killing of about 200 elephants by locals.",
          "subTopics": []
        },
        {
          "heading": "Cultural depictions",
          "description":
              "In many cultures, elephants represent strength, power, wisdom, longevity, stamina, leadership, sociability, nurturance and loyalty. Several cultural references emphasise the elephant's size and exotic uniqueness. For instance, a \"white elephant\" is a byword for something expensive, useless, and bizarre. The expression \"elephant in the room\" refers to an obvious truth that is ignored or otherwise unaddressed. The story of the blind men and an elephant teaches that reality can be observed from different perspectives.Elephants have been represented in art since Paleolithic times. Africa, in particular, contains many rock paintings and engravings of the animals, especially in the Sahara and southern Africa. In Asia, the animals are depicted as motifs in Hindu and Buddhist shrines and temples. Elephants were often difficult to portray by people with no first-hand experience of them. The ancient Romans, who kept the animals in captivity, depicted anatomically accurate elephants on mosaics in Tunisia and Sicily. At the beginning of the Middle Ages, when Europeans had little to no access to the animals, elephants were portrayed more like fantasy creatures. They were often depicted with horse- or bovine-like bodies with trumpet-like trunks and tusks like a boar; some were even given hooves. Elephants were commonly featured in motifs by the stonemasons of the Gothic churches. As more elephants began to be sent to European kings as gifts during the 15th century, depictions of them became more accurate, including one made by Leonardo da Vinci. Despite this, some Europeans continued to portray them in a more stylised fashion. Max Ernst's 1921 surrealist painting, The Elephant Celebes, depicts an elephant as a silo with a trunk-like hose protruding from it.Elephants have been the subject of religious beliefs. The Mbuti people of central Africa believe that the souls of their dead ancestors resided in elephants. Similar ideas existed among other African societies, who believed that their chiefs would be reincarnated as elephants. During the 10th century AD, the people of Igbo-Ukwu, near the Niger Delta, buried their leaders with elephant tusks. The animals' religious importance is only totemic in Africa but is much more significant in Asia. In Sumatra, elephants have been associated with lightning. Likewise in Hinduism, they are linked with thunderstorms as Airavata, the father of all elephants, represents both lightning and rainbows. One of the most important Hindu deities, the elephant-headed Ganesha, is ranked equal with the supreme gods Shiva, Vishnu, and Brahma. Ganesha is associated with writers and merchants and it is believed that he can give people success as well as grant them their desires. In Buddhism, Buddha is said to have been a white elephant reincarnated as a human. In Islamic tradition, the year 570 when Muhammad was born is known as the Year of the Elephant. Elephants were thought to be religious themselves by the Romans, who believed that they worshipped the sun and stars.Elephants are ubiquitous in Western popular culture as emblems of the exotic, especially since – as with the giraffe, hippopotamus and rhinoceros – there are no similar animals familiar to Western audiences. The use of the elephant as a symbol of the U.S. Republican Party began with an 1874 cartoon by Thomas Nast. As characters, elephants are most common in children's stories, in which they are generally cast as models of exemplary behaviour. They are typically surrogates for humans with ideal human values. Many stories tell of isolated young elephants returning to a close-knit community, such as \"The Elephant's Child\" from Rudyard Kipling's Just So Stories, Disney's Dumbo, and Kathryn and Byron Jackson's The Saggy Baggy Elephant. Other elephant heroes given human qualities include Jean de Brunhoff's Babar, David McKee's Elmer, and Dr. Seuss's Horton.",
          "subTopics": []
        }
      ]
    }
  ]
};
