import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_imitation/source/get_it_instance.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/query_data_bloc.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/query_data_event.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/query_data_state.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/main_site_header_widget.dart';
import 'package:google_fonts/google_fonts.dart';

const Color BORDERCOLOR = Color.fromARGB(255, 227, 232, 238);
const Color BACKGROUNDCOLOR = Color.fromARGB(255, 248, 248, 248);
const Color DEEPBORDERCOLOR = Color.fromARGB(255, 196, 196, 196);
const Color DEEPBACKGROUND = Color.fromARGB(255, 198, 40, 40);

const String EARLYPAYOUT = 'EARLY PAYOUT';
const String POLECANE = 'POLECANE:';
const String POKAZWSZYSTKIE = 'POKAŻ WSZYSTKIE';
const String DAJNAMCHWILE = 'DAJ NAM CHWILĘ';
const String PRZESZUKUJEMYBAZEDANYCH = 'PRESZUKUJEMY BAZĘ DANYCH';
const String BRAKWYNIKOW = 'BRAK WYNIKÓW';
const String SPROBUJINNEGOZAPYTANIA = 'SPRÓBUJ INNEGO ZAPYTANIA';

const String FIRSTIMAGEPATH = 'assets/images/first_image.png';
const String SECONDIMAGEPATH = 'assets/images/second_image.png';
const String THIRDIMAGEPATH = 'assets/images/third_image.png';
const String FOURTHIMAGEPATH = 'assets/images/fourth_image.png';
const String FIFTHIMAGEPATH = 'assets/images/fifth_image.png';
const String QUICKSEARCHPROGRESSINDICATOR =
    'assets/images/icons/quick_search_progress_indicator.png';
const String NODATAIMAGEPATH = 'assets/images/icons/no_data.png';

class QuerySite extends StatefulWidget {
  const QuerySite({super.key});

  static const routName = '/quick_search';

  @override
  State<QuerySite> createState() => _QuerySiteState();
}

TextEditingController _controller = TextEditingController();

void searchDataBase(BuildContext context) {
  if (_controller.text.length >= 3) {
    BlocProvider.of<QueryDataBloc>(context)
        .add(GetQueryFromRemote(query: _controller.text));
  } else {
    BlocProvider.of<QueryDataBloc>(context).add(ResetQuery());
  }
}

class _QuerySiteState extends State<QuerySite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DEEPBACKGROUND,
      body: BlocProvider(
        create: (context) => injSrv<QueryDataBloc>(),
        child: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            // Main part of site
            Flexible(
              flex: 20,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: BACKGROUNDCOLOR,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 20,
                  ),
                  child: BlocBuilder<QueryDataBloc, QueryState>(
                    builder: (context, state) {
                      if (state is InitialQueryState) {
                        return Column(
                          children: [
                            Expanded(
                              child: QuickSearchTextFieldWidget(
                                controller: _controller,
                                function: searchDataBase,
                              ),
                            ),
                            const Flexible(
                              flex: 3,
                              child: RecomendedViewWidget(),
                            ),
                          ],
                        );
                      } else if (state is LoadingState) {
                        return Column(
                          children: [
                            Expanded(
                              child: QuickSearchTextFieldWidget(
                                controller: _controller,
                                function: searchDataBase,
                              ),
                            ),
                            const Flexible(
                              flex: 2,
                              child: LoadingWidget(),
                            ),
                          ],
                        );
                      } else if (state is QueryLoadedState) {
                        return Column(
                          children: [
                            QuickSearchTextFieldWidget(
                              controller: _controller,
                              function: searchDataBase,
                            ),
                            const SizedBox(height: 30),
                            const ContentTableWidget(),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            Expanded(
                              child: QuickSearchTextFieldWidget(
                                controller: _controller,
                                function: searchDataBase,
                              ),
                            ),
                            const Flexible(
                              flex: 2,
                              child: NoDataWidget(),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecomendedViewWidget extends StatelessWidget {
  const RecomendedViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              POLECANE,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text(
              POKAZWSZYSTKIE,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: DEEPBACKGROUND),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 80,
              child: Image.asset(
                FIRSTIMAGEPATH,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 80,
              child: Image.asset(
                SECONDIMAGEPATH,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 80,
              child: Image.asset(
                THIRDIMAGEPATH,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 80,
              child: Image.asset(
                FOURTHIMAGEPATH,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 80,
              child: Image.asset(
                FIFTHIMAGEPATH,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class QuickSearchTextFieldWidget extends StatelessWidget {
  const QuickSearchTextFieldWidget({
    super.key,
    required this.controller,
    required this.function,
  });

  final TextEditingController controller;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextField(
        onChanged: (_) => function(context),
        controller: controller,
        keyboardType: TextInputType.text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: BORDERCOLOR,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: BORDERCOLOR,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          prefixIcon: const Icon(
            Icons.arrow_back_ios_new,
            color: DEEPBORDERCOLOR,
            size: 13,
          ),
        ),
      ),
    );
  }
}

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with TickerProviderStateMixin {
  double turns = 0;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(
      seconds: 2,
    ),
  );
  late final Animation<double> _animation =
      CurvedAnimation(parent: _animationController, curve: Curves.linear);

  @override
  void initState() {
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          RotationTransition(
            turns: _animation,
            child: SizedBox(
                height: 84,
                width: 84,
                child: Image.asset(QUICKSEARCHPROGRESSINDICATOR)),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: Text(
              DAJNAMCHWILE,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            PRZESZUKUJEMYBAZEDANYCH,
            style: GoogleFonts.montserrat(
              color: DEEPBORDERCOLOR,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class ContentTableWidget extends StatelessWidget {
  const ContentTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 80,
      width: 80,
    );
  }
}

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 5,
            ),
            width: 84,
            height: 84,
            child: Image.asset(NODATAIMAGEPATH),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: Text(
              BRAKWYNIKOW,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            SPROBUJINNEGOZAPYTANIA,
            style: GoogleFonts.montserrat(
              color: DEEPBORDERCOLOR,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
