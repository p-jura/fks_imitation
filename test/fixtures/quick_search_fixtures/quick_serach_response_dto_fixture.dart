import 'package:fuksiarz_imitation/source/data/models.dart';

const QuickSearchResponseDto quickSearchResposnseDtoFixtures =
    QuickSearchResponseDto(
  code: 200,
  description: 'description',
  data: [
    QuickSearchResponseData(
      area: 1,
      name: 'name',
      id: 1,
      score: 1.0,
      modelExtras: {},
    ),
  ],
);

const QuickSearchResponseDto quickSearchResposnseDtoFixtureWithError =
    QuickSearchResponseDto(
  code: 500,
  description: 'description',
  data: null,
);
