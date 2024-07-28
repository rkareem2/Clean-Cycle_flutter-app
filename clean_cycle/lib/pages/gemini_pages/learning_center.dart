import 'package:clean_cycle/pages/gemini_pages/learning_center_pages/article.dart';
import 'package:flutter/material.dart';

class LearningCenter extends StatelessWidget {
  final List<GridItem> items = [
    GridItem('Articles', Icons.book, GeminiArticle()),
    GridItem('Games', Icons.gamepad_outlined, const TopicPage(title: 'Games')),
    GridItem('Tips', Icons.lightbulb_outline, const TopicPage(title: 'Tips')),
    GridItem('Forums', Icons.people_alt_outlined, const TopicPage(title: 'Forums')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learning Center'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GridItemWidget(item: items[index]);
          },
        ),
      ),
    );
  }
}

class GridItem {
  final String title;
  final IconData icon;
  final Widget page;

  GridItem(this.title, this.icon, this.page);
}

class GridItemWidget extends StatelessWidget {
  final GridItem item;

  const GridItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => item.page),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, size: 50, color: Colors.white),
            SizedBox(height: 10),
            Text(
              item.title,
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class TopicPage extends StatelessWidget {
  final String title;

  const TopicPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Content for $title', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
