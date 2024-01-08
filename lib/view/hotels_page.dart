import 'package:edirne_gezgini_ui/view/place_details_page.dart';
import 'package:flutter/material.dart';

import '../database/temporary_database.dart';
import '../model/accommodation.dart';
import '../widget/place_card.dart';


class HotelsPage extends StatefulWidget {
  const HotelsPage({super.key});

  @override
  State<StatefulWidget> createState() => _HotelsPageState();
}

class _HotelsPageState extends State<HotelsPage> {
  @override
  Widget build(BuildContext context) {
    List<Accommodation> hotels = TemporaryDatabase().hotels;
    double width = MediaQuery.of(context).size.width / 100;
    double height = MediaQuery.of(context).size.height / 100;
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Oteller",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        body: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            //list hotels
            SizedBox(
              width: width * 100,
              height: height * 80,
              child: hotelsListView(hotels),
            )
          ],
        ));
  }

  Widget hotelsListView(List<Accommodation> hotels) {
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: hotels.length,
        itemBuilder: (BuildContext context, int index) {
          var currentHotel = hotels[index];

          return GestureDetector(
            child:
                PlaceCard(title: currentHotel.title, image: currentHotel.image),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> PlaceDetailsPage(accommodation: currentHotel)));
            },
          );
        });
  }
}
