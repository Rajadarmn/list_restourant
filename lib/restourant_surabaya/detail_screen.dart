import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/tourism_place.dart';

class DetailScreen extends StatelessWidget {
  final TourismPlace place;
  const DetailScreen({required this.place, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, BoxConstraints constraints) {
            if (constraints.maxWidth <= 700) {
              return DetailMobileScreen(place: place);
            } else {
              return DetailWebScreen(place: place);
            }
          },
        ),
      ),
    );
  }
}

class DetailMobileScreen extends StatelessWidget {
  const DetailMobileScreen({required this.place, super.key});
  final TourismPlace place;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onBackground;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            Image.asset(
              place.imageAsset,
              fit: BoxFit.cover,
              height: 250,
              width: double.infinity,
            ),
            Positioned(
              top: 30,
              left: 15,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            place.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildDetailItem(Icons.calendar_today, place.openDays, textColor),
              _buildDetailItem(Icons.access_time, place.openTime, textColor),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildRatingStars(place.rating),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            place.description,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 16, color: textColor),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: place.imageUrls.length,
            itemBuilder: (context, index) {
              final String image = place.imageUrls[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(image, fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

Widget _buildDetailItem(IconData icon, String text, Color textColor) {
  return Row(
    children: [
      Icon(icon, color: Colors.blueGrey),
      const SizedBox(width: 8),
      Text(text, style: TextStyle(color: textColor)),
    ],
  );
}

Widget _buildRatingStars(double rating) {
  final starColor = Colors.amber;
  return Row(
    children: List.generate(5, (index) {
      if (index < rating.floor()) {
        return Icon(Icons.star, color: starColor);
      } else if (index < rating) {
        return Icon(Icons.star_half, color: starColor);
      } else {
        return Icon(Icons.star_border, color: starColor);
      }
    }),
  );
}

class DetailWebScreen extends StatefulWidget {
  final TourismPlace place;
  const DetailWebScreen({required this.place, super.key});

  @override
  _DetailWebScreenState createState() => _DetailWebScreenState();
}

class _DetailWebScreenState extends State<DetailWebScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onBackground;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 32),
      child: Center(
        child: SizedBox(
          width: 1200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.place.name,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            widget.place.imageAsset,
                            fit: BoxFit.cover,
                            height: 400,
                            width: double.infinity,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 180,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.place.imageUrls.length,
                            itemBuilder: (context, index) {
                              final String image = widget.place.imageUrls[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(image, fit: BoxFit.cover),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    flex: 3,
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.place.name,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today, color: Colors.blueGrey),
                                    const SizedBox(width: 8),
                                    Text(widget.place.openDays, style: TextStyle(color: textColor)),
                                  ],
                                ),
                                IconButton(
                                  icon: Icon(
                                    isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: isFavorite ? Colors.red : Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isFavorite = !isFavorite;
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Icons.access_time, color: Colors.blueGrey),
                                const SizedBox(width: 8),
                                Text(widget.place.openTime, style: TextStyle(color: textColor)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            _buildRatingStars(widget.place.rating),
                            const SizedBox(height: 16),
                            Text(
                              widget.place.description,
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 16, color: textColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
