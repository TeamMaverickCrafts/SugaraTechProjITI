import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpitiproject/test.dart';

class MyListItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  const MyListItem({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(12.0),
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: Color(0xFF333333).withOpacity(0.1), // Border color
            width: 2.0, // Border width
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF333333).withOpacity(0.1),
              blurRadius: 54,
              spreadRadius: 0,
              offset: Offset(10, 24),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              child: Image.network(
                imageUrl,
                width: 80.0,
                height: 80.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFFFE586A),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> demoData = [
    {
      'imageUrl':
          'https://thumbs.dreamstime.com/b/case-studies-concept-colored-letters-green-chalk-board-234211131.jpg',
      'title': 'Title 1',
      'subtitle': 'Subtitle 1',
      'pdfPath': 'assets/sample.pdf', // Path to PDF file for item 1
    },
    {
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrZV_sBpajsxtGwSG1qe5Hif5hmUfTKpHBFJuqVJqWyGOzFVKY35oqQ0bK5a4hapeDQVE&usqp=CAU',
      'title': 'Title 2',
      'subtitle': 'Subtitle 2',
      'pdfPath': 'assets/sample2.pdf', // Path to PDF file for item 2
    },
    {
      'imageUrl':
          'https://st3.depositphotos.com/7865540/14323/i/450/depositphotos_143233559-stock-photo-businessman-using-computer-in-office.jpg',
      'title': 'Title 3',
      'subtitle': 'Subtitle 3',
      'pdfPath': 'assets/sample3.pdf', // Path to PDF file for item 3
    },
    // Add more data as needed
  ];

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text('Exit'),
              ),
            ],
          ),
        )) ??
        false;
  }

  void _openPdf(String pdfPath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyPdfViewer(pdfPath: pdfPath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFE586A),
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFFFE586A),
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Handle item 1 tap
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Handle item 2 tap
                },
              ),
              // Add more list items as needed
            ],
          ),
        ),
        backgroundColor: Color(0xFFFE586A),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello User",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  Text(
                    "Let's test your knowledge",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0),
                  ),
                ),
                child: ListView.builder(
                  itemCount: demoData.length,
                  itemBuilder: (context, index) {
                    return MyListItem(
                      imageUrl: demoData[index]['imageUrl']!,
                      title: demoData[index]['title']!,
                      subtitle: demoData[index]['subtitle']!,
                      onPressed: () {
                        _openPdf(demoData[index]['pdfPath']!);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
