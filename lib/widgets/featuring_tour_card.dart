import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FeaturingTourCard extends StatefulWidget {
  final String photoUrl;
  final String tourName;
  final String description;
  final double cost;

  const FeaturingTourCard({
    super.key,
    required this.photoUrl,
    required this.tourName,
    required this.description,
    required this.cost,
  });

  @override
  State<FeaturingTourCard> createState() => _FeaturingTourCardState();
}

class _FeaturingTourCardState extends State<FeaturingTourCard> {
  bool saved = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: widget.photoUrl,
              placeholder: (context, url) => const SizedBox(
                height: 250,
                child: Center(
                  child: CircularProgressIndicator(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.tourName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.description,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${widget.cost}\$",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                Spacer(),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {},
                  child: Text("Book now"),
                ),
                IconButton(
                  color: Colors.black,
                  onPressed: () {
                    setState(() {
                      saved = !saved;
                    });
                  },
                  icon: !saved
                      ? Icon(Icons.bookmark_border_rounded)
                      : Icon(Icons.bookmark_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
