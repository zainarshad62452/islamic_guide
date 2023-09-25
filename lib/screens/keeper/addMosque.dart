import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:islamic_guide/Services/Authentication.dart';
import 'package:islamic_guide/Services/mosqueServices.dart';
import 'package:islamic_guide/models/prayerTimingModel.dart';
import 'package:islamic_guide/screens/auth/register.dart';
import 'package:islamic_guide/screens/widgets/loading.dart';
import 'package:islamic_guide/screens/widgets/snackbar.dart';
import 'package:islamic_guide/services/Reception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic_guide/screens/auth/signIn.dart';

import '../../Controllers/loading.dart';

class RegisterMosque extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterMosque> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController openHour = TextEditingController();
  final TextEditingController closeHour = TextEditingController();
  final TextEditingController speciality = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController _passwordConfirmController =
  TextEditingController();
  String image = "";

  FocusNode f1 = new FocusNode();
  FocusNode f2 = new FocusNode();
  FocusNode f3 = new FocusNode();
  FocusNode f4 = new FocusNode();
  FocusNode f5 = new FocusNode();
  FocusNode f6 = new FocusNode();
  FocusNode f7 = new FocusNode();
  FocusNode f8 = new FocusNode();
  FocusNode f9 = new FocusNode();
  String selectedMosqueType='Jamai Mosque';
  Map<String, TimeOfDay> prayerTimes = {
    'Fajr': TimeOfDay(hour: 5, minute: 0),
    'Dhuhr': TimeOfDay(hour: 12, minute: 30),
    'Asr': TimeOfDay(hour: 15, minute: 45),
    'Maghrib': TimeOfDay(hour: 18, minute: 20),
    'Isha': TimeOfDay(hour: 20, minute: 0),
    'Jumma': TimeOfDay(hour: 13, minute: 0),
  };
  double latitude = 0.0;
  double longitude = 0.0;

  List<String> mosqueTypes = ['Jamai Mosque', 'Madrasa', 'Regular Mosque'];
  late bool _isSuccess;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
      children: [
        !loading()
            ?
        Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Center(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowGlow();
                  return true;
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
                        child: _signUp(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
            :LoadingWidget(),
        LoadingWidget(),
      ],
    ));
  }

  Widget _signUp() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(bottom: 50),
              child: Text(
                'Add Mosque',
                style: GoogleFonts.lato(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextFormField(
              focusNode: f1,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.emailAddress,
              controller: _displayName,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: 'Mosque Name',
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                f1.unfocus();
                FocusScope.of(context).requestFocus(f2);
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) return 'Please enter the Name';
                return null;
              },
            ),
            SizedBox(
              height: 25.0,
            ),
            TextFormField(
              focusNode: f5,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.emailAddress,
              controller: city,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: 'Address',
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                f5.unfocus();
                FocusScope.of(context).requestFocus(f6);
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) return 'Please enter the City';
                return null;
              },
            ),
            SizedBox(
              height: 25.0,
            ),
            Column(
              children: [
                DropdownButtonFormField<String>(
                  value: selectedMosqueType,
                  onChanged: (value) {
                    setState(() {
                      selectedMosqueType = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Select Mosque Type',
                    border: OutlineInputBorder(),
                  ),
                  items: mosqueTypes.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20.0),
                Column(
                  children: prayerTimes.entries.map((entry) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${entry.key} Time:'),
                        TimePicker(
                          initialTime: entry.value,
                          onTimeChanged: (time) {
                            setState(() {
                              prayerTimes[entry.key] = time;
                            });
                          },
                        ),
                      ],
                    );
                  }).toList(),

                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Give Location"),
                    MaterialButton(
                      color: Colors.tealAccent.shade700,
                      onPressed: () async {
                        showDialog(context: context, builder: (ctx)=>const AlertDialog(content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("Getting Location...."),CircularProgressIndicator()],),));
                      await Geolocator.requestPermission();
                      if(await Geolocator.isLocationServiceEnabled()){
                        final location = await Geolocator.getCurrentPosition();
                        latitude = location.latitude;
                        longitude = location.longitude;
                        Get.back();
                        snackbar("Done", "Location done successfully");
                        print(latitude);
                        print(longitude);
                      }else{
                        Get.back();
                        alertSnackbar("Can't get Location");
                      }
                    },child: Text("Location",style: TextStyle(color: Colors.white),),),
                  ],
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 25.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  child: Text(
                    "Register",
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      showLoaderDialog(context);
                      _registerAccount();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    // primary: Colors.indigo[900],
                    primary: Colors.tealAccent.shade700,
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 15), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  bool emailValidate(String email) {
    if (RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }

  void _registerAccount() async {
    try{

      PrayerTimingModel model = PrayerTimingModel(
        fajar: getTimeStringFromTimeOfDay(prayerTimes['Fajr']!),
        zuhur: getTimeStringFromTimeOfDay(prayerTimes['Dhuhr']!),
        asar: getTimeStringFromTimeOfDay(prayerTimes['Asr']!),
        maghrib: getTimeStringFromTimeOfDay(prayerTimes['Maghrib']!),
        jummah: getTimeStringFromTimeOfDay(prayerTimes['Jumma']!),
        isha: getTimeStringFromTimeOfDay(prayerTimes['Isha']!)
      );

      MosqueServices().registerMosque(name: _displayName.text,prayerTiming: model,latitude: latitude,longitude: longitude,mosqueType: selectedMosqueType,location: city.text);
    } catch (error) {
      alertSnackbar("$error");
    }
  }
  String getTimeStringFromTimeOfDay(TimeOfDay timeOfDay) {
    String hour = timeOfDay.hour.toString().padLeft(2, '0');
    String minute = timeOfDay.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

}
class TimePicker extends StatelessWidget {
  final TimeOfDay initialTime;
  final ValueChanged<TimeOfDay> onTimeChanged;

  TimePicker({required this.initialTime, required this.onTimeChanged});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        final selectedTime = await showTimePicker(
          context: context,
          initialTime: initialTime,
        );

        if (selectedTime != null && onTimeChanged != null) {
          onTimeChanged(selectedTime);
        }
      },
      child: Text(
        '${initialTime.format(context)}',
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}
