import 'package:basic/Provider/MyProvider.dart';
import 'package:basic/style/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class AppBarScreen extends StatefulWidget implements PreferredSizeWidget {
  const AppBarScreen({Key? key}) : super(key: key);

  @override
  _AppBarScreenState createState() => _AppBarScreenState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarScreenState extends State<AppBarScreen> {
  String temperature = '';
  String city = '';
  late DateTime selectedDate; // Tambahkan variabel selectedDate
  DateTime sekarang = DateTime.now();

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedDate = sekarang;
    });

    fetchData();
  }

  void imagepicker() async {
    final provTugas2 = context.watch<DataProfileProvider>();
    var res = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Gunakan selectedDate
      firstDate: DateTime(2000),
      lastDate: DateTime(2500),
    );

    if (res != null) {
      setState(() {
        selectedDate = res; // Perbarui selectedDate
        provTugas2.setdate = res;
      });
    }
  }

  Future<void> fetchData() async {
    try {
      final response = await Dio().get(
          'https://openweathermap.org/data/2.5/weather?id=1214520&appid=439d4b804bc8187953eb36d2a8c26a02');
      if (response.statusCode == 200) {
        final temperatureValue =
            response.data['main']['temp'].toStringAsFixed(1);
        final cityValue = response.data['name'];
        setState(() {
          temperature = '$temperatureValue °C';
          city = '$cityValue';
        });
      } else {
        print('Failed to load weather data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final provTugas2 = context.watch<DataProfileProvider>();
    var date = provTugas2.dataCurrentdate;
    var dateFormat = DateFormat("EEEE, dd MMMM yyyy").format(date);

    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      toolbarHeight: 70,
      backgroundColor: appbarcolor,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Temperature at $city $temperature",
            style: const TextStyle(color: Colors.white38, fontSize: 18),
          ),
          Text(
            dateFormat,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () async {
            var res = await showDatePicker(
              context: context,
              initialDate: selectedDate, // Gunakan selectedDate
              firstDate: DateTime(2000),
              lastDate: DateTime(2500),
            );

            if (res != null) {
              setState(() {
                selectedDate = res; // Perbarui selectedDate
                provTugas2.setdate = res;
              });
            }
          },
          icon: const Icon(
            Icons.date_range,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
