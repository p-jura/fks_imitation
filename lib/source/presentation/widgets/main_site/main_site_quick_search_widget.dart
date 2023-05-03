import 'package:flutter/material.dart';

class QuickSearchWidget extends StatelessWidget {
  const QuickSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 248, 248, 248),
      ),
      child: InkWell(
        onTap: (){
          Navigator.of(context).pushNamed('/quick_search');
         
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            border: Border.all(
              color: const Color.fromARGB(255, 227, 232, 238),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Row(
            children: const [
              Icon(
                Icons.search_rounded,
                size: 18,
                color: Color.fromARGB(255, 148, 148, 148),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'CZEGO SZUKASZ',
                style: TextStyle(
                  color: Color.fromARGB(255, 148, 148, 148),
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
