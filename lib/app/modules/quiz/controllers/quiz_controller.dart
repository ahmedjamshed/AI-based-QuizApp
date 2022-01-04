import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:get/get.dart';
import 'package:quizapp/app/data/api_helper.dart';

class Question {
  final String question;
  final String answer;
  final String correct;
  final String context;
  final List<String> options;

  Question(
      this.question, this.answer, this.context, this.correct, this.options);
  factory Question.fromMap(dynamic json) {
    final correct = json['correct'] ?? 'No Answer';
    final List<String> options = []; // json['options'].cast<String>()
    // ..add(correct)
    // ..shuffle();
    for (final option in json['options']) {
      options.add(option);
    }
    options
      ..add(correct)
      ..shuffle();
    return Question(
        json['question'], json['answer'], json['context'], correct, options);
  }
}

class QuizController extends GetxController {
  final ApiHelper _apiHelper = Get.find();

  final RxList<Question> _dataList = RxList();
  List<Question> get quizList => _dataList;
  set quizList(List<Question> quizList) => _dataList.addAll(quizList);

  final RxMap<int, String> _questionMap = RxMap();

  final RxBool _isLoading = true.obs;
  dynamic get isLoading => _isLoading;

  final pageController = IndexController();

  void generateQuestions(String content) {
    _isLoading.value = true;
    _apiHelper.generateQuestions(content).futureValue((dynamic value) {
      quizList = value['questions']
          .map<Question>((val) => Question.fromMap(val))
          .toList();
      _isLoading.value = false;
    });
  }

  void markAnswer(int position, String selectedAnswer) {
    _questionMap.putIfAbsent(position, () => selectedAnswer);
  }

  bool isSelected(int position, String answer) {
    return _questionMap[position] == answer;
  }

  double calulateResult() {
    final total = _dataList.length;
    int rights = 0;
    _questionMap.forEach((key, val) {
      if (quizList[key].correct == val) rights++;
    });
    return rights / total;
  }

  @override
  void onReady() {
    super.onReady();
    final content = Get.arguments ?? "";
    generateQuestions(content);
  }
}

const dynamic value = {
  "questions": [
    {
      "answer": "________",
      "correct": "Elephants",
      "options": [
        "hippos",
        "giraffes",
        "crocodiles",
        "tigers",
        "big cats",
        "cheetahs",
        "ostriches",
        "leopards",
        "otters",
        "pigeons",
        "horses",
        "gorillas",
        "birds",
        "koalas",
        "snakes",
        "gazelles",
        "mammoths",
        "antelopes",
        "porcupines"
      ],
      "question": "What are the largest existing land animals?",
      "context": "Elephants are the largest existing land animals."
    },
    {
      "answer": "________",
      "correct": "Three",
      "options": [
        "two",
        "four",
        "six",
        "eight",
        "Twelve",
        "Five",
        "Seven",
        "Ten",
        "Fifteen",
        "Fourteen",
        "nine",
        "Thirty"
      ],
      "question": "How many living species are elephants currently recognised?",
      "context":
          "Three living species are currently recognised: the African bush elephant, the African forest elephant, and the Asian elephant."
    },
    {
      "answer": "________",
      "correct": "Elephantidae",
      "options": [
        "Ailuropodidae",
        "family Ailuropodidae",
        "Antilocapridae",
        "family Antilocapridae",
        "Aplodontiidae",
        "family Aplodontiidae",
        "Balaenidae",
        "family Balaenidae",
        "Balaenopteridae",
        "family Balaenopteridae",
        "Bassariscidae"
      ],
      "question": "What is the only surviving family of proboscideans?",
      "context":
          "They are an informal grouping within the proboscidean family Elephantidae."
    },
    // {
    //   "answer": "________",
    //   "correct": "mastodons",
    //   "options": [
    //     "Mammoths",
    //     "humanoids",
    //     "megafauna",
    //     "great beasts",
    //     "gnolls",
    //     "orcs",
    //     "mythical creatures",
    //     "shoggoths",
    //     "centaurs",
    //     "many other creatures",
    //     "Humans",
    //     "Elder Dragons",
    //     "mummies",
    //     "woolly mammoths",
    //     "werewolves",
    //     "dwarves",
    //     "elves"
    //   ],
    //   "question": "What are the extinct members of the proboscidean family?",
    //   "context":
    //       "Elephantidae is the only surviving family of proboscideans; extinct members include the mastodons."
    // },
    // {
    //   "answer": "mammoths and ________-tusked elephants",
    //   "correct": "straight",
    //   "options": [
    //     "up",
    //     "right",
    //     "down",
    //     "back",
    //     "strait",
    //     "off",
    //     "out",
    //     "then",
    //     "away",
    //     "just",
    //     "thru",
    //     "in"
    //   ],
    //   "question": "What are the extinct groups of elephantidae?",
    //   "context":
    //       "Elephantidae also contains several extinct groups, including the mammoths and straight-tusked elephants."
    // },
    // {
    //   "answer": "larger ________ and concave backs",
    //   "correct": "ears",
    //   "options": [
    //     "vocal cords",
    //     "eardrums",
    //     "earlobes",
    //     "eye lids",
    //     "nose",
    //     "vocal chords",
    //     "nose holes",
    //     "muffled screams"
    //   ],
    //   "question": "What types of backs do African elephants have?",
    //   "context":
    //       "African elephants have larger ears and concave backs, whereas Asian elephants have smaller ears, and convex or level backs."
    // },
    // {
    //   "answer":
    //       "a trunk, tusks, large ear ________, massive legs, and tough but sensitive skin",
    //   "correct": "flaps",
    //   "options": [
    //     "flutter",
    //     "wiggles",
    //     "tail",
    //     "claws",
    //     "majestically",
    //     "cradles",
    //     "wriggles",
    //     "flails",
    //     "flies",
    //     "squeals",
    //     "writhes",
    //     "beak",
    //     "swallows"
    //   ],
    //   "question": "What are the distinct features of all elephants?",
    //   "context":
    //       "Distinctive features of all elephants include a long proboscis called a trunk, tusks, large ear flaps, massive legs, and tough but sensitive skin."
    // },
    // {
    //   "answer":
    //       "breathing, ________ food and water to the mouth, and grasping objects",
    //   "correct": "bringing",
    //   "options": [
    //     "brining",
    //     "brought",
    //     "putting",
    //     "comes",
    //     "making",
    //     "leaving",
    //     "giving",
    //     "returning",
    //     "letting",
    //     "keeping",
    //     "helping",
    //     "tossing",
    //     "springing",
    //     "having"
    //   ],
    //   "question": "What is the trunk used for?",
    //   "context":
    //       "The trunk is used for breathing, bringing food and water to the mouth, and grasping objects."
    // },
    // {
    //   "answer": "________",
    //   "correct": "Tusks",
    //   "options": [
    //     "Axe",
    //     "Talons",
    //     "Beaks",
    //     "Slime",
    //     "Dragonslayer",
    //     "Frost",
    //     "Manikin",
    //     "Tempered",
    //     "Striders",
    //     "Boars",
    //     "Locusts",
    //     "spears",
    //     "Traps",
    //     "Bloodied",
    //     "Tyr",
    //     "Summoners",
    //     "Scales"
    //   ],
    //   "question": "What is derived from the incisor teeth?",
    //   "context":
    //       "Tusks, which are derived from the incisor teeth, serve both as weapons and as tools for moving objects and digging."
    // },
    // {
    //   "answer": "The large ________ flaps",
    //   "correct": "ear",
    //   "options": [
    //     "earlobe",
    //     "earbud",
    //     "tongue",
    //     "neck",
    //     "vocal cords",
    //     "eardrum",
    //     "whispering"
    //   ],
    //   "question": "What assist in maintaining a constant body temperature?",
    //   "context":
    //       "The large ear flaps assist in maintaining a constant body temperature as well as in communication."
    // },
    // {
    //   "answer": "The pillar-________ legs",
    //   "correct": "like",
    //   "options": [
    //     "whatnot",
    //     "whathaveyou",
    //     "etc",
    //     "ect",
    //     "occasional",
    //     "unlike",
    //     "ie",
    //     "i.e",
    //     "type stuff",
    //     "even something",
    //     "Especially",
    //     "similar",
    //     "and",
    //     "I.e."
    //   ],
    //   "question": "What type of legs carry their great weight?",
    //   "context": "The pillar-like legs carry their great weight."
    // },
    // {
    //   "answer": "sub-Saharan Africa, ________, and Southeast Asia",
    //   "correct": "South Asia",
    //   "options": [
    //     "east Asia",
    //     "Indian subcontinent",
    //     "southeast Asia",
    //     "Central Asia",
    //     "Eastern Asia",
    //     "Latin America",
    //     "West Africa",
    //     "East Africa",
    //     "South-East Asia",
    //     "subcontinent",
    //     "southern Asia",
    //     "sub-Saharan Africa",
    //     "South East Asia",
    //     "India",
    //     "Africa"
    //   ],
    //   "question": "Where are elephants scattered?",
    //   "context":
    //       "Elephants are scattered throughout sub-Saharan Africa, South Asia, and Southeast Asia and are found in different habitats, including savannahs, forests, deserts, and marshes."
    // },
    // {
    //   "answer": "________",
    //   "correct": "herbivorous",
    //   "options": [
    //     "carnivore",
    //     "omnivores",
    //     "mammal",
    //     "invertebrates",
    //     "domestic cats",
    //     "larger species",
    //     "domesticated",
    //     "crustaceans",
    //     "insectivores",
    //     "vertebrates",
    //     "most species",
    //     "arboreal",
    //     "insects",
    //     "certain species",
    //     "natural diet"
    //   ],
    //   "question":
    //       "What type of species are elephants found in savannahs, forests, deserts, and marshes?",
    //   "context":
    //       "They are herbivorous, and they stay near water when it is accessible."
    // },
    // {
    //   "answer": "their impact on their ________",
    //   "correct": "environments",
    //   "options": [
    //     "enviroment",
    //     "unique ways",
    //     "game world",
    //     "many systems",
    //     "aspects",
    //     "systems"
    //   ],
    //   "question": "Why are elephants considered to be keystone species?",
    //   "context":
    //       "They are considered to be keystone species, due to their impact on their environments."
    // },
    // {
    //   "answer": "fission–fusion ________",
    //   "correct": "society",
    //   "options": ["societal level", "societal structure", "social system"],
    //   "question": "What type of society does elephants have?",
    //   "context":
    //       "Elephants have a fission–fusion society, in which multiple family groups come together to socialise."
    // },
    // {
    //   "answer": "Females (________)",
    //   "correct": "cows",
    //   "options": [
    //     "chickens",
    //     "cattle",
    //     "pigs",
    //     "goats",
    //     "other farm animals",
    //     "livestock",
    //     "farm animals",
    //     "free range chickens",
    //     "rabbits",
    //     "other livestock",
    //     "turkeys",
    //     "animals",
    //     "pasture",
    //     "domesticated animals",
    //     "herds"
    //   ],
    //   "question": "What group of females tend to live in family groups?",
    //   "context":
    //       "Females (cows) tend to live in family groups, which can consist of one female with her calves or several related females with offspring."
    // },
    // {
    //   "answer": "________",
    //   "correct": "matriarch",
    //   "options": [
    //     "patriarch",
    //     "sired",
    //     "matron",
    //     "eldest son",
    //     "orphan",
    //     "only daughter",
    //     "sons",
    //     "noble family",
    //     "grandson",
    //     "noblewoman",
    //     "tribe",
    //     "queen",
    //     "eldest",
    //     "princess",
    //     "elder brother",
    //     "concubine",
    //     "commoner",
    //     "dearest",
    //     "eldest daughter",
    //     "youngest daughter"
    //   ],
    //   "question": "What is the oldest cow called?",
    //   "context":
    //       "The groups, which do not include bulls, are usually led by the oldest cow, known as the matriarch."
    // },
    // {
    //   "answer": "________ (bulls)",
    //   "correct": "Males",
    //   "options": [
    //     "Females",
    //     "women",
    //     "many females",
    //     "sexes",
    //     "most females",
    //     "adult women",
    //     "female ones",
    //     "female sex",
    //     "homosexual men",
    //     "men/women",
    //     "heterosexual men"
    //   ],
    //   "question": "Who leaves their family groups when they reach puberty?",
    //   "context":
    //       "Males (bulls) leave their family groups when they reach puberty and may live alone or with other males."
    // },
    // {
    //   "answer": "________ bulls",
    //   "correct": "Adult",
    //   "options": [
    //     "adolescent",
    //     "child",
    //     "parent",
    //     "grown woman",
    //     "grownup",
    //     "young child",
    //     "older person"
    //   ],
    //   "question": "Who interacts with family groups when looking for a mate?",
    //   "context":
    //       "Adult bulls mostly interact with family groups when looking for a mate."
    // },
    // {
    //   "answer": "________",
    //   "correct": "musth",
    //   "options": [
    //     "aggressive behavior",
    //     "aggressive behaviour",
    //     "estrus",
    //     "mating season",
    //     "domestic dog",
    //     "predators",
    //     "captivity",
    //     "breeding age",
    //     "domestic cats",
    //     "bull elephant",
    //     "aggressive tendencies",
    //     "most other breeds",
    //     "other elephants",
    //     "many animals",
    //     "such animals",
    //     "mixed breed dogs",
    //     "wild animal",
    //     "wild dog"
    //   ],
    //   "question":
    //       "What is a state of increased testosterone and aggression known as?",
    //   "context":
    //       "They enter a state of increased testosterone and aggression known as musth, which helps them gain dominance over other males as well as reproductive success."
    // },
    // {
    //   "answer": "________",
    //   "correct": "Calves",
    //   "options": [
    //     "forearms",
    //     "thighs",
    //     "pecs",
    //     "biceps",
    //     "upper body",
    //     "leg muscles",
    //     "legs",
    //     "hammies",
    //     "upper legs",
    //     "abs",
    //     "lower legs",
    //     "hamstrings",
    //     "adductors",
    //     "lower body",
    //     "glutes",
    //     "hips"
    //   ],
    //   "question": "What is the centre of the family of elephants?",
    //   "context":
    //       "Calves are the centre of attention in their family groups and rely on their mothers for as long as three years."
    // }
  ]
};
