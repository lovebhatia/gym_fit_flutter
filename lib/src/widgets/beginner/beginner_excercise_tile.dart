import '../../resources/app_colors.dart';
import 'beg_exc_description.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GifApi {
  static Future<String> fetchGif() async {
    final response = await http.get(Uri.parse('YOUR_BACKEND_URL'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final gifUrl = jsonData['gif_url'];

      return gifUrl;
    } else {
      throw Exception('Failed to load GIF');
    }
  }
}

class ExcerciseTile extends StatelessWidget {
  final String name_of_exercise;
  final String sets;
  final String gif;
  final String description;

  ExcerciseTile({
    required this.name_of_exercise,
    required this.sets,
    required this.gif,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 8),
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.LIGHT_BLACK,
        ),
        child: FutureBuilder(
          future: GifApi.fetchGif(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error fetching GIF'));
            } else {
              final gifUrl = snapshot.data;
              return ListTile(
                onTap: () {
                  showModalBottomSheet<dynamic>(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    context: context,
                    builder: (BuildContext context) {
                      return BegModalSheet(
                        gif: gif, // Use fetched GIF URL
                        sets: sets,
                        name_of_exercise: name_of_exercise,
                        description:
                            description, // Assuming description is defined somewhere
                      );
                    },
                  );
                },
                title: Text(
                  name_of_exercise,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'sets: ${sets}',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                trailing: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    gif, // Use fetched GIF URL
                    fit: BoxFit.cover,
                    width: 50, // Adjust width as needed
                    height: 50, // Adjust height as needed
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
