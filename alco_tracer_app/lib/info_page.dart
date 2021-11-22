import 'package:flutter/material.dart';
import 'package:alco_tracer_app/main.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('AlcoTracer'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              print('Clicked on Back');
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Info",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 30,
                  ),
                ),
              ),
              const Divider(
                height: 10,
                thickness: 3,
              ),
              RichText(
                text: TextSpan(
                    text:
                    "Blood Alcohol Content, or BAC, refers to the percentage of alcohol in a person's bloodstream, "
                        "and can be measured within 30 minutes after drinking. Contrary to popular belief, "
                        "nothing can lower BAC except time. This calculator can give you an approximate BAC level, "
                        "but do not rely upon it to determine if you're fit to drive or work. In all states, the legal limit to "
                        "drive is any number above 0.08%, granted you are of legal age to drink. If you are under the legal"
                        " age to drink, it is illegal to have any alcohol in your system while driving.\n\nIn the simple "
                        "calculator, BAC is determined by a standard drink. A standard drink is equal to 14 grams"
                        " (0.6 ounces) of pure alcohol. Generally, this amount of alcohol is found in:\n\n"
                        "12 ounces of beer (5% ABV)\n8 ounces of malt liquor (7% ABV)\n5 ounces of wine (12% ABV)\n"
                        "1.5 ounces of 80-proof spirits or liquor (40% ABV)\n\nIn the advanced calculator, users can"
                        " input the amount of ounces and ABV percentage to get a more accurate result based upon "
                        "the alcohol they have consumed. Users can also input how long it has been since their first"
                        " drink in order to estimate how much time has affected their BAC levels.\n\nIndividuals "
                        "typically lose about 0.015% of BAC each hour.\n\n",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "BAC % affects",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 30,
                  ),
                ),
              ),
              const Divider(
                height: 10,
                thickness: 3,
              ),

              RichText(
                text: TextSpan(
                  text:
                  "0.02% ~ Some loss of judgment, relaxation, slight body warmth, altered mood\n\n"
                      "0.05% ~ Exaggerated behavior, loss of small-muscle control (e.g., focusing your eyes), "
                      "impaired judgment, lowered alertness, release of inhibition\n\n"
                      "0.08% ~ Poor muscle coordination (e.g., balance, speech, vision, reaction time, hearing), "
                      "difficulty detecting danger, impaired judgment, self-control, reasoning, and memory\n\n"
                      "0.10% ~ Clear deterioration of reaction time and control, slurred speech, poor coordination, "
                      "slowed thinking\n\n"
                      "0.15% ~ Far less muscle control than normal, potential for vomiting, major loss of balance\n\n"
                      "0.40% ~ An individual with this blood alcohol level may be at risk for coma or death.\n",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Disclaimer",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 30,
                  ),
                ),
              ),
              const Divider(
                height: 10,
                thickness: 3,
              ),
              RichText(
                text: TextSpan(
                    text:
                        "This Blood Alcohol Content (BAC) calculator is meant for educational purposes only. The "
                        "BAC calculator is not intended to replace the medical advice of your doctor or health "
                        "care provider and should not be relied upon. There is no blood alcohol calculator that "
                        "is 100% accurate as there are numerous factors relating to alcohol consumption that can "
                        "affect blood alcohol content. In addition to gender, body weight, and amount of "
                        "alcohol consumed in a time period, blood alcohol content of any individual person is "
                        "influenced by that person’s metabolism, health issues, medications taken, history of alcohol "
                        "consumption and the amount of food and non-alcoholic beverages eaten before or during "
                        "alcohol consumption. The best that can be done is a rough estimation "
                        "of the BAC level based on these known inputs. ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    children: [
                      TextSpan(
                        text:
                            "If you’ve been drinking, please let someone who hasn’t "
                            "been drive.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
              ),
            ]),
          ),
        )
    );
  }
}
