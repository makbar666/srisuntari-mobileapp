import 'package:flutter/material.dart';
import 'package:srisuntari_mobileapp/models/database_helper.dart';
import 'package:srisuntari_mobileapp/models/quiz_result.dart';
import 'package:srisuntari_mobileapp/register/register_page.dart';

class RiwayatQuiz extends StatefulWidget {
  const RiwayatQuiz({Key? key}) : super(key: key);

  @override
  State<RiwayatQuiz> createState() => _RiwayatQuizState();
}

class _RiwayatQuizState extends State<RiwayatQuiz> {
  List<QuizResult> quizResults = [];

  @override
  void initState() {
    super.initState();
    loadQuizResults();
  }

  Future<void> loadQuizResults() async {
    List<QuizResult> results = await DatabaseHelper().getAllQuizResults();
    print("Quiz Results");
    print(quizResults);
    setState(() {
      quizResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF6B81DE),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Color(0xFF6B81DE),
              expandedHeight: 50,
              floating: true,
              pinned: true,
              collapsedHeight: 80,
              flexibleSpace: FlexibleSpaceBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Riwayat Quis',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                titlePadding: EdgeInsets.only(left: 30, bottom: 20, top: 33),
                centerTitle: false,
                expandedTitleScale: 1.3,
                collapseMode: CollapseMode.parallax,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    height: 700,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 20,
                            bottom: 20,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: quizResults.length,
                            itemBuilder: (context, index) {
                              return buildQuizResultItem(quizResults[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildQuizResultItem(QuizResult quizResult) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Quis #${quizResult.id}",
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Tanggal: ${quizResult.date}",
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Status: ${quizResult.status}",
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle the button click event
            },
            child: Text(
              "Info",
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
