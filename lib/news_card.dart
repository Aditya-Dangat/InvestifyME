// import 'package:flutter/material.dart';
// import 'package:investifyme_1/news.dart';

// class NewsCard extends StatelessWidget {
//   final Article article;

//   const NewsCard({Key? key, required this.article}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: const Color(0xff202232),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
          
//           children: [
//             Text(
//               article.title,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               article.description,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(height: 8),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:investifyme_1/news.dart';

class NewsCard extends StatelessWidget {
  final Article article;

  const NewsCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Add outer margin
      child: Card(
        elevation: 4, // Add elevation for a shadow effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Add rounded corners
        ),
        color: const Color(0xff202232),
        child: Padding(
          padding: const EdgeInsets.all(12.0), // Add inner padding for content spacing
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                article.title,
                maxLines: 2, // Limit title to 2 lines
                overflow: TextOverflow.ellipsis, // Truncate long titles
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8), // Add spacing between title and description
              Text(
                article.description,
                maxLines: 3, // Limit description to 3 lines
                overflow: TextOverflow.ellipsis, // Truncate long descriptions
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70, // Reduce opacity for description
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
