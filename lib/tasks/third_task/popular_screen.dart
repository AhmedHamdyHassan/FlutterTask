import 'package:flutter/material.dart';
import 'package:hackathon_fatura/tasks/third_task/movies_model.dart';
import 'package:provider/provider.dart';

class PopularScreen extends StatefulWidget {
  PopularScreen() {
    MoviesProvider().getMovies();
  }

  @override
  _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    MoviesProvider().getMovies().then((value) => setState(() {
          isLoading = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Consumer<MoviesProvider>(
              builder: (context, data, child) => GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                children: [...data.getDesign()],
              ),
            ),
    );
  }
}
