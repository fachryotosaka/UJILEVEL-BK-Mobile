import 'package:flutter/material.dart';

class ex extends StatefulWidget {
  const ex({super.key});

  @override
  State<ex> createState() => _exState();
}

class _exState extends State<ex> {

  bool? page1;
  bool? page2;
  bool? page3;

  Widget getPage() {
    if(page1 != false){
      return Text("Page 1");
    } else if (page2 != false){
      return Text("Page 2");
    } else if (page3 != false){
      return Text("Page 3");
    } else {
      return const CircularProgressIndicator(
        color: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () => setState(() {
                      page1 = true;
                      page2 = false;
                      page3 = false;
                      print("page1" + page1.toString());
                    }),
                    child: Text(
                      'Page 1',
                      style: TextStyle(
                        color: page1 == true ? Colors.black : Colors.blue
                      ),
                    )
                ),
                TextButton(
                    onPressed: () => setState(() {
                      page1 = false;
                      page2 = true;
                      page3 = false;
                      print("page 2" + page2.toString());
                    }),
                    child: Text(
                      'Page 2',
                      style: TextStyle(
                        color: page2 == true ? Colors.black : Colors.blue
                      ),
                    )
                ),
                TextButton(
                    onPressed: () => setState(() {
                      page1 = false;
                      page2 = false;
                      page3 = true;
                      print("page3" + page3.toString());
                    }),
                    child: Text(
                      'Page 3',
                      style: TextStyle(
                        color: page3 == true ? Colors.black : Colors.blue
                      ),
                    )
                ),
              ],
            ),

            getPage()
          ],
        ),
      ),
    );
  }
}
