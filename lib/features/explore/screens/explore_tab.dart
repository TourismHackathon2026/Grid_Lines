import 'package:flutter/material.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({Key? key}) : super(key: key);

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  final Color bgDark = const Color(0xFF0A0F1C);
  final Color cardDark = const Color(0xFF171E2E);
  final Color blazeOrange = const Color(0xFFFF5722);

  // 🗺️ EXACT LOCAL ASSET DATA
  final List<Map<String, dynamic>> _explorePlaces = [
    {
      "name": "Rara Lake Expedition",
      "location": "Mugu District, Karnali",
      "rating": 4.9,
      "reviews": 1824,
      "interested": 6420,
      "reviewSnippet": '"The biggest and deepest freshwater lake in the Nepal Himalayas. The pristine blue waters surrounded by pine forests are unmatched."',
      "images": ["assets/images/rara.jpg", "assets/images/rara2.jpg", "assets/images/rara3.jpg"]
    },
    {
      "name": "Khaptad National Park",
      "location": "Far-Western Region",
      "rating": 4.8,
      "reviews": 945,
      "interested": 2100,
      "reviewSnippet": '"A hidden gem! Rolling green meadows and spiritual tranquility. Untouched by heavy commercial trekking."',
      "images": ["assets/images/khaptad1.jpg", "assets/images/khaptad2.jpg"]
    },
    {
      "name": "Lapchi Valley Trail",
      "location": "Dolakha District",
      "rating": 4.9,
      "reviews": 512,
      "interested": 1840,
      "reviewSnippet": '"One of the most sacred Buddhist pilgrimage sites. The meditation caves of Milarepa are profoundly moving."',
      "images": ["assets/images/lapchi vallerry.jpg", "assets/images/lapchi2.webp"]
    },
    {
      "name": "Kathmandu Valley Heritage",
      "location": "Bagmati Province",
      "rating": 4.7,
      "reviews": 8432,
      "interested": 12500,
      "reviewSnippet": '"A mesmerizing blend of Hinduism and Buddhism. The architecture of Durbar Square and the aura of Pashupatinath are unforgettable."',
      "images": ["assets/images/Pashupati.jpg", "assets/images/swyambu.jpg", "assets/images/bkt durabr sqr.jpg"]
    },
    {
      "name": "Annapurna & Fewa",
      "location": "Gandaki Province",
      "rating": 4.9,
      "reviews": 15420,
      "interested": 22100,
      "reviewSnippet": '"Starting from the serene Fewa Lake and climbing up into the massive Annapurna ranges. The ultimate trekking experience."',
      "images": ["assets/images/anapurna circut.jpg", "assets/images/fewa_tal.jpg", "assets/images/lumbbini.jpg"]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgDark,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        physics: const BouncingScrollPhysics(),
        itemCount: _explorePlaces.length,
        itemBuilder: (context, index) {
          return _ExploreCard(
            place: _explorePlaces[index],
            cardDark: cardDark,
            blazeOrange: blazeOrange,
          );
        },
      ),
    );
  }
}

// 🃏 INDIVIDUAL FEED CARD WITH FLOATING COLLAGE UI
class _ExploreCard extends StatefulWidget {
  final Map<String, dynamic> place;
  final Color cardDark;
  final Color blazeOrange;

  const _ExploreCard({
    required this.place,
    required this.cardDark,
    required this.blazeOrange,
  });

  @override
  State<_ExploreCard> createState() => _ExploreCardState();
}

class _ExploreCardState extends State<_ExploreCard> {
  bool _isSaved = false;

  @override
  Widget build(BuildContext context) {
    List<String> images = widget.place["images"];

    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
        color: widget.cardDark,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🖼️ THE FLOATING IMAGE COLLAGE
          SizedBox(
            height: 280,
            width: double.infinity,
            child: Stack(
              children: [
                // 1. Base Main Image (Zoomed and cropped perfectly with BoxFit.cover)
                Container(
                  width: double.infinity,
                  height: 280,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    image: DecorationImage(
                      image: AssetImage(images[0]),
                      fit: BoxFit.cover, // PREVENTS DISTORTION
                    ),
                  ),
                ),
                
                // Gradient Overlay for Depth
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    gradient: LinearGradient(
                      colors: [widget.cardDark, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: const [0.0, 0.4],
                    ),
                  ),
                ),

                // 2. Floating Image (Top Right)
                if (images.length > 1)
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Transform.rotate(
                      angle: 0.08, // Slight tilt for organic feel
                      child: Container(
                        width: 110,
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: widget.cardDark, width: 4),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 15, offset: const Offset(0, 8))],
                          image: DecorationImage(image: AssetImage(images[1]), fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),

                // 3. Floating Image (Bottom Right Overlap)
                if (images.length > 2)
                  Positioned(
                    bottom: 30,
                    right: 70,
                    child: Transform.rotate(
                      angle: -0.06, // Opposite tilt
                      child: Container(
                        width: 120,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: widget.cardDark, width: 4),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 15, offset: const Offset(0, 8))],
                          image: DecorationImage(image: AssetImage(images[2]), fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),

                // Interactive Bookmark Icon
                Positioned(
                  top: 16,
                  left: 16,
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _isSaved = !_isSaved);
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(_isSaved ? "Saved to Travel History" : "Removed from saved places", style: const TextStyle(fontWeight: FontWeight.bold)),
                        backgroundColor: widget.blazeOrange,
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                      ));
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: _isSaved ? widget.blazeOrange : Colors.black54, shape: BoxShape.circle),
                      child: Icon(_isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded, color: Colors.white, size: 22),
                    ),
                  ),
                )
              ],
            ),
          ),

          // 📝 DETAILS & REVIEWS SECTION
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.place["name"],
                        style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: -0.5),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(widget.place["rating"].toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                        Text(" (${widget.place["reviews"]})", style: const TextStyle(color: Colors.white38, fontSize: 12)),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.white54, size: 14),
                    const SizedBox(width: 4),
                    Text(widget.place["location"], style: const TextStyle(color: Colors.white54, fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 20),
                
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.03), borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.format_quote_rounded, color: Colors.white24, size: 20),
                      const SizedBox(width: 10),
                      Expanded(child: Text(widget.place["reviewSnippet"], style: const TextStyle(color: Colors.white70, fontSize: 13, fontStyle: FontStyle.italic, height: 1.5))),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Icon(Icons.local_fire_department_rounded, color: widget.blazeOrange, size: 20),
                    const SizedBox(width: 8),
                    Text("${widget.place["interested"]} trekkers want to go here", style: TextStyle(color: widget.blazeOrange, fontSize: 13, fontWeight: FontWeight.w700)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}