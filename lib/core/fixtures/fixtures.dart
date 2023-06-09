// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const Map<int, String> MAP_OF_CATEGORIES = {
  1: 'PIŁKA NOŻNA',
  2: 'KOSZYKÓWKA',
  3: 'BASEBALL',
  4: 'HOKEJ NA LODZIE',
  5: 'TENIS',
  6: 'PIŁKA RĘCZNA',
  10: 'SIATKÓWKA',
};

const Map<String, String> MAP_OF_CALLENDER_WIDGET_STRINGS = {
  'offer': 'OFERTA',
  'my': 'MOJE',
  'live': 'LIVE',
  'hot': 'HOT',
  'cashback': 'CASHBACK',
};
// const String: failure messages
const NO_DATA_FOUND_FAILURE_MESSAGE = 'No data found';
const NO_DATA_FOUND_FAILURE_CACHE_MESSAGE = 'No data found in cached file';
const GET_LOCAL_FAILED_MESSAGE =
    'getLocalData failed: no file found in directory ';
const GET_LOCAL_FAILED_WITH_PARAM_MESSAGE =
    'getLocalData failed: no file with givent';

// const String:
const String EARLY_PAYOUT = 'EARLY PAYOUT';
const String RECOMENDED = 'POLECANE:';
const String SHOW_ALL = 'POKAŻ WSZYSTKIE';
const String GIVE_US_A_MOMENT = 'DAJ NAM CHWILĘ';
const String SEACKING_THROU_DATABASE = 'PRESZUKUJEMY BAZĘ DANYCH';
const String NO_RESULTS = 'BRAK WYNIKÓW';
const String TRY_ANOTHER_QUERY = 'SPRÓBUJ INNEGO ZAPYTANIA';
const String WHAT_ARE_YOU_LOOKING_FOR = 'CZEGO SZUKASZ';
const String PRICE = '21,37 zł';
const String RELOAD_APPLICATION = 'No data found: Reload application';
const String HOT = 'HOT';

// const String: path
const String LOGO_IMAGE_PATH = 'assets/images/logo.png';
const String FIRST_IMAGE_PATH = 'assets/images/first_image.png';
const String SECOND_IMAGE_PATH = 'assets/images/second_image.png';
const String THIRD_IMAGE_PATH = 'assets/images/third_image.png';
const String FOURTH_IMAGE_PATH = 'assets/images/fourth_image.png';
const String FIFTH_IMAGE_PATH = 'assets/images/fifth_image.png';
const String QUICKSEARCH_PROGRESS_INDICATOR =
    'assets/images/icons/quick_search_progress_indicator.png';
const String NO_DATA_IMAGE_PATH = 'assets/images/icons/no_data.png';
const String TV_FULL_IMAGE_PATH = 'assets/images/icons/tv_full.png';
const String HOT_ICON_IMAGE_PATH = 'assets/images/icons/hot.png';
const String FILTER_ICON_IMAGE_PATH = 'assets/images/icons/filter.png';
const String CALLENDER_ICON_IMAGE_PATH = 'assets/images/icons/callender.png';
// URL
const API_URL_PREFIX = 'https://fuksiarz.pl/rest';
const API_URL_QUICK_SEARCH_SUFFIX = 'search/events/quick-search';
const API_URL_EVENTS_SUFFIX = 'market/categories/multi';
const REQUEST_HEADER = {
  'Content-Type': 'application/json',
  'Request-Language': 'pl',
};

// colors
const Color BORDER_COLOR = Color.fromARGB(255, 227, 232, 238);
const Color BACKGROUND_COLOR = Color.fromARGB(255, 248, 248, 248);
const Color DEEP_BORDER_COLOR = Color.fromARGB(255, 196, 196, 196);
const Color DEEP_BACKGROUND_COLOR = Color.fromARGB(255, 198, 40, 40);
const Color WHITE_COLOR = Color.fromARGB(255, 255, 255, 255);
const Color SEARCH_ICON_COLOR = Color.fromARGB(255, 148, 148, 148);
const Color ACTIVE_COMPONENT_COLOR = Color.fromARGB(255, 224, 230, 237);
const Color ISACTIVE_COMPONENT_COLOR = Color.fromARGB(255, 156, 179, 202);
const Color MATCH_ACTIVE_STATUS_BAR_COLOR = Color.fromARGB(255, 76, 175, 80);
