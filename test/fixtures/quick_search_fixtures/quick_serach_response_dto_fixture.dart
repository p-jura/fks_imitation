import 'package:fuksiarz_imitation/source/data/models.dart';

QuickSearchResponseDto quickSearchResposnseDtoFixtures = QuickSearchResponseDto(
  code: 200,
  description: 'description',
  data: [
    QuickSearchResponseData(
      area: '1',
      name: 'name',
      id: 1,
      score: 1.0,
      modelExtras: const {},
      modelEventStart: DateTime.fromMillisecondsSinceEpoch(1683383400000),
    ),
  ],
);

const QuickSearchResponseDto quickSearchResposnseDtoFixtureWithError =
    QuickSearchResponseDto(
  code: 500,
  description: 'description',
  data: null,
);
