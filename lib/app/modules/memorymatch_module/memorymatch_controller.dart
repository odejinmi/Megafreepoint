import 'package:get/get.dart';

import '../../provider/adsProvider.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class memorymatchController extends GetxController{

  final _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;

  final _cards = [
    '🐱', '🐱', '🐶', '🐶', '🐻', '🐻', '🐰', '🐰', '🐼', '🐼', '🐨', '🐨', '🐯', '🐯', '🦁', '🦁'
  ].obs;
  set cards(value) => _cards.value = value;
  get cards => _cards.value;

  final _cardFlips= <bool>[].obs;
  set cardFlips(value) => _cardFlips.value = value;
  List<bool> get cardFlips => _cardFlips.value;

  final _prevCardIndex = 0.obs;
  set prevCardIndex(value) => _prevCardIndex.value = value;
  get prevCardIndex => _prevCardIndex.value;

  final _pairsFound = 0.obs;
  set pairsFound(value) => _pairsFound.value = value;
  get pairsFound => _pairsFound.value;

  final _attempts = 0.obs;
  set attempts(value) => _attempts.value = value;
  get attempts => _attempts.value;

  final _isGameOver = false.obs;
  set isGameOver(value) => _isGameOver.value = value;
  get isGameOver => _isGameOver.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initializeGame();
    Get.find<AdsProvider>().loadinterrtitialad();
    Get.find<AdsProvider>().loadrewardedad();
    Get.find<AdsProvider>().loadrewardedinterstitialad();
  }

  void initializeGame() {
    cards.shuffle();
    cardFlips = List.generate(cards.length, (index) => false);
    prevCardIndex = -1;
    pairsFound = 0;
    attempts = 0;
    isGameOver = false;
  }

  void flipCard(int index) {
    if (!isGameOver && !cardFlips[index]) {
        cardFlips[index] = true;
        if (prevCardIndex == -1) {
          prevCardIndex = index;
        } else {
          // Check if the two flipped cards match
          if (cards[index] != cards[prevCardIndex]) {
            Future.delayed(Duration(seconds: 1), () {
              // If not a match, flip them back over after a delay
                cardFlips[index] = false;
                cardFlips[prevCardIndex] = false;
                prevCardIndex = -1;
            });
          } else {
            // If they match, keep them face-up
            pairsFound++;
            prevCardIndex = -1;
          }
          attempts++;
        }
        if (pairsFound == cards.length ~/ 2) {
          // All pairs have been found
          isGameOver = true;
        }
        if(attempts >= 50){
          isGameOver = true;
        }
    }
  }

  Future<void> restartGame() async {
    var value = await Get.find<AdsProvider>().showads();
    var value2 = await Get.find<AdsProvider>().showreawardads(initializeGame);
    if(value.status) {
        initializeGame();
    }
  }
}
