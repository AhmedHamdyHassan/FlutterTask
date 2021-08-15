import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Movie {
  final String title, imagePath;
  Movie({required this.title, required this.imagePath});
}

class MoviesProvider extends ChangeNotifier {
  List<Movie> listOfMovies = [];
  Future<void> getMovies() async {
    final String url =
        'https://api.themoviedb.org/3/movie/popular?api_key=381b8c0be715e4249021621d8c95ed62&language=en-US&page=1';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      final listOfResult = jsonResponse['results'] as List<dynamic>;
      for (int i = 0; i < listOfResult.length; i++) {
        listOfMovies.add(Movie(
            title: listOfResult[i]['title'],
            imagePath: listOfResult[i]['title']));
      }
      notifyListeners();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  List<Widget> getDesign() {
    print(listOfMovies.length);
    List<Widget> result = [];
    for (int i = 0; i < listOfMovies.length; i++) {
      result.add(Container(
        child: Column(
          children: [
            Image.network(
                'https://image.tmdb.org/t/p/w500${listOfMovies[i].imagePath}'),
            Row(
              children: [
                Text('${listOfMovies[i].title}'),
                IconButton(onPressed: () {}, icon: Icon(Icons.favorite))
              ],
            )
          ],
        ),
      ));
    }
    return result;
  }
}
