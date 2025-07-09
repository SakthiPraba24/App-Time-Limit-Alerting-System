



// //claude new at  1.00pm  Ui good blocking code and app usage also correct 

// import 'package:flutter/material.dart';
// import 'dart:math';

// import 'package:device_apps/device_apps.dart';
// import 'package:android_intent_plus/android_intent.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'dart:async';

// import 'package:flutter_tts/flutter_tts.dart';

// void main() {
//   runApp(MyApp());
// }

// enum AppState { settingTotalLimit, editingAppLimits, trackingUsage }

// class AppLimit {
//   final String packageName;
//   final String appName;
//   Duration usage;
//   Duration limit;

//   AppLimit({
//     required this.packageName,
//     required this.appName,
//     required this.usage,
//     required this.limit,
//   });
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Digital Wellbeing',
//       theme: ThemeData(
//         brightness: Brightness.dark,
//         scaffoldBackgroundColor: Colors.black,
//         cardColor: Color(0xFF1C1C1E),
//         primaryColor: Colors.pinkAccent,
//         sliderTheme: SliderThemeData(
//           activeTrackColor: Colors.pinkAccent,
//           inactiveTrackColor: Colors.grey.withOpacity(0.3),
//           thumbColor: Colors.pinkAccent,
//           overlayColor: Colors.pinkAccent.withOpacity(0.2),
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.pinkAccent,
//             foregroundColor: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(30), // Rounded button
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//           ),
//         ),
//         inputDecorationTheme: InputDecorationTheme(
//           filled: true,
//           fillColor: Colors.black.withOpacity(0.1),
//           hintStyle: TextStyle(color: Colors.white54),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide.none,
//           ),
//           prefixIconColor: Colors.pinkAccent,
//         ),
//         appBarTheme: AppBarTheme(
//           backgroundColor: Colors.black,
//           foregroundColor: Colors.white,
//           elevation: 0,
//         ),
//         textTheme: TextTheme(
//           bodyMedium: TextStyle(color: Colors.white),
//         ),
//       ),
//       home: HomeScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {

//   List<AppLimit> appLimits = [];
//   int totalLimitInHours = 4; // Default to 4 hours as in the image
//   AppState appState = AppState.settingTotalLimit;
//   Timer? usageRefreshTimer;
//   static const platform = MethodChannel('app.usage/limits');
//   bool showChart = false;
//   String searchQuery = '';
//   late FlutterTts tts;
//   Set<String> warnedApps = {};



//   static const MethodChannel ownerChannel = MethodChannel('device.owner/admin');

//  final FlutterTts flutterTts = FlutterTts();
// Map<String, bool> appWarned = {};
  
//   // App color mapping to match the UI shown in your images
//   Map<String, Color> appColors = {
//     'instagram': const Color.fromRGBO(238,42,123,1),
//     'youtube': Color(0xFFFF0000),
//     'X': Color(0xFF141619),
//     'whatsapp': Color(0xFF228B22),
//     'spotify': Color(0xFF1DB954),
//     'gmail': Color(0xFFF2F6F3),
//     'telegram': Color(0xFF42A5F5),
//     'hotstar': Color(0xFF7E38E9),
//     'prime': Color(0xFF42A5F5),
//     'other': Colors.green.shade300,
//   };

//     @override
//   void initState() {
//     scheduleMidnightReset();
//     tts = FlutterTts();
//     super.initState();
//     _checkFirstRun();
//     if (appState == AppState.trackingUsage) {
//       fetchApps();
//       usageRefreshTimer = Timer.periodic(Duration(seconds: 60), (timer) {
//         fetchApps();
//       });
//     }
//   }


//   Future<void> speakWarning(String message) async {
//     await flutterTts.setLanguage("en-US");
//     await flutterTts.setPitch(1);
//     await flutterTts.setSpeechRate(0.5);
//     await flutterTts.speak(message);
//   }

//   @override
  
//   void scheduleMidnightReset() {
//     final now = DateTime.now();
//     final nextMidnight = DateTime(now.year, now.month, now.day + 1);
//     final durationUntilMidnight = nextMidnight.difference(now);
//     Timer(durationUntilMidnight, () {
//       resetUsageData();
//       scheduleMidnightReset();
//     });
//   }

//   void resetUsageData() {
//     setState(() {
//       for (var app in appLimits) {
//         app.usage = Duration.zero;
//       }
//       warnedApps.clear();
//     });
//     try {
//     platform.invokeMethod('removeDeviceAdmin');
//   } catch (e) {
//     print("Error removing Device Admin: $e");
//   }
//   }



//  void checkAndWarn(AppLimit app) {
//   if (app.usage >= app.limit && !warnedApps.contains(app.packageName)) {
//     tts.speak("${app.appName} usage limit exceeded");
//     warnedApps.add(app.packageName);
//   }
// }



// @override
//   void dispose() {
//     usageRefreshTimer?.cancel();
//     super.dispose();
//   }



//   Future<void> _checkFirstRun() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isFirstRun = prefs.getBool('first_run') ?? true;

//     if (isFirstRun) {
//       openAccessibilitySettings();
//       await prefs.setBool('first_run', false);
//     }
//   }

//   Future<Map<String, Duration>> getAccurateUsage() async {
//     try {
//       final now = DateTime.now();
//       final startOfDay = DateTime(now.year, now.month, now.day);
//       final Map result = await platform.invokeMethod("getAccurateUsage", {
//         "from": startOfDay.millisecondsSinceEpoch,
//         "to": now.millisecondsSinceEpoch,
//       });

//       return result.map((pkg, millis) => MapEntry(pkg.toString(), Duration(milliseconds: millis)));
//     } catch (e) {
//       print("Failed to get accurate usage: $e");
//       return {};
//     }
//   }


// Future<void> fetchApps() async {
//   List<Application> apps = await DeviceApps.getInstalledApplications(
//     includeAppIcons: true,
//     includeSystemApps: true,
//   );

//   final keywords = [
//     'whatsapp', 'instagram', 'facebook', 'youtube', 'snapchat', 'X',
//     'tiktok', 'zoom', 'meet', 'teams', 'telegram', 'messenger', 'reddit','sharechat',
//     'netflix', 'prime', 'hotstar', 'spotify', 'mxplayer', 'vlc', 'game',
//   ];

//   const allowedSystemPackages = [
//     'com.google.android.youtube',
//   ];

//   Map<String, Duration> usageMap = await getAccurateUsage();
//   List<AppLimit> tempLimits = [];

//   for (Application app in apps) {
//     final nameLower = app.appName.toLowerCase();
//     final pkgLower = app.packageName.toLowerCase();
//     final isAllowedSystemApp = allowedSystemPackages.contains(app.packageName);

//     if ((!app.systemApp || isAllowedSystemApp) &&
//         keywords.any((kw) => nameLower.contains(kw) || pkgLower.contains(kw))) {
//       try {
//         Duration appUsageDuration = usageMap[app.packageName] ?? Duration.zero;

//         AppLimit existing = appLimits.firstWhere(
//           (e) => e.packageName == app.packageName,
//           orElse: () => AppLimit(
//             packageName: app.packageName,
//             appName: app.appName,
//             usage: Duration.zero,
//             limit: Duration(minutes: 10),
//           ),
//         );

//         Duration appLimit = existing.limit;

//         // 🗣️ Voice Assistant Logic
//         int usedMinutes = appUsageDuration.inMinutes;
//         int limitMinutes = appLimit.inMinutes;
//         double usagePercent = usedMinutes / (limitMinutes == 0 ? 1 : limitMinutes);

//         if (usagePercent >= 0.9 && usagePercent < 1.0 && appWarned[app.packageName] != true) {
//           await speakWarning("Warning! You're about to reach your limit on ${app.appName}.");
//           appWarned[app.packageName] = true;
//         }

//         if (usedMinutes >= limitMinutes) {
//           await speakWarning("Time's up! You've reached your limit on ${app.appName}.");
//         }

//         tempLimits.add(AppLimit(
//           packageName: app.packageName,
//           appName: app.appName,
//           usage: appUsageDuration,
//           limit: appLimit,
//         ));
//       } catch (e) {
//         print("Error reading usage for ${app.packageName}: $e");
//       }
//     }
//   }

//   tempLimits.sort((a, b) => b.usage.compareTo(a.usage));

//   setState(() {
//     appLimits = tempLimits;
//   });

//   sendUsageLimits(tempLimits);
// }

//   Future<void> sendUsageLimits(List<AppLimit> limits) async {
//     final data = limits
//         .where((e) => e.usage >= e.limit)
//         .map((e) => {
//               'package': e.packageName,
//               'limitMinutes': e.limit.inMinutes,
//             })
//         .toList();

//     try {
//       await platform.invokeMethod('updateLimits', data);
//     } catch (e) {
//       print("Failed to send limits to native code: $e");
//     }
//   }

//   void setTotalLimit(int hours) {
//     int minutesPerApp = (hours * 60 ~/ appLimits.length);
//     setState(() {
//       totalLimitInHours = hours;
//       for (var app in appLimits) {
//         app.limit = Duration(minutes: minutesPerApp);
//       }
//       appState = AppState.editingAppLimits;
//     });
//   }

//   void updateLimit(AppLimit app, int minutes) {
//     int totalMinutes = appLimits.fold(0, (sum, a) => sum + a.limit.inMinutes);
//     int newTotal = totalMinutes - app.limit.inMinutes + minutes;

//     if (newTotal <= totalLimitInHours * 60) {
//       setState(() {
//         app.limit = Duration(minutes: minutes);
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text("Invalid time distribution: exceeds total limit."),
//       ));
//     }
//   }

//   void applyAndStart() async {
//     setState(() {
//       appState = AppState.trackingUsage;
//     });
//     fetchApps();
//     usageRefreshTimer = Timer.periodic(Duration(seconds: 60), (timer) {
//       fetchApps();
//     });

//     try {
//     await ownerChannel.invokeMethod("blockUninstall", {"block": true});
//   } catch (e) {
//     print("Failed to block uninstall: $e");
//   }
//   }

//   void openAccessibilitySettings() {
//     const intent = AndroidIntent(action: 'android.settings.ACCESSIBILITY_SETTINGS');
//     intent.launch();
//   }

//   // Get color for an app based on its name
//   Color getAppColor(String appName) {
//     String nameLower = appName.toLowerCase();
//     for (var key in appColors.keys) {
//       if (nameLower.contains(key)) {
//         return appColors[key]!;
//       }
//     }
//     // Default color if no match found
//     return Colors.grey;
//   }

//   Widget buildImprovedPieChart() {
//     List<AppLimit> appsWithUsage = appLimits.where((a) => a.usage.inMinutes > 0).toList();
//     int totalUsageMinutes = appsWithUsage.fold(0, (sum, app) => sum + app.usage.inMinutes);
    
//     if (appsWithUsage.isEmpty) {
//       // If there's no usage data yet, return placeholder text
//       return Center(
//         child: Text(
//           'No usage data available yet',
//           style: TextStyle(color: Colors.white70),
//         ),
//       );
//     }

//     // Create pie chart sections
//     List<PieChartSectionData> sections = [];
//     for (int i = 0; i < appsWithUsage.length; i++) {
//       final app = appsWithUsage[i];
//       final percentage = app.usage.inMinutes / totalUsageMinutes;
      
//       sections.add(
//         PieChartSectionData(
//           color: getAppColor(app.appName),
//           value: app.usage.inMinutes.toDouble(),
//           title: '',
//           radius: 85,
//           titlePositionPercentageOffset: 0.6,
//           borderSide: BorderSide(width: 1, color: Colors.black),
//         ),
//       );
//     }

//     return Container(
//       height: 320,
//       width: double.infinity,
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Color(0xFF1C1C1E),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         children: [
//           Text(
//             "App Usage Overview",
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(height: 16),
//           Expanded(
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 // Outer shadow for depth
//                 Container(
//                   width: 190,
//                   height: 190,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.3),
//                         blurRadius: 20,
//                         spreadRadius: 2,
//                       ),
//                     ],
//                   ),
//                 ),
//                 // The pie chart
//                 PieChart(
//                   PieChartData(
//                     sectionsSpace: 1,
//                     centerSpaceRadius: 60,
//                     sections: sections,
//                     startDegreeOffset: 270, // Start from the top
//                     pieTouchData: PieTouchData(enabled: false),
//                     borderData: FlBorderData(show: false),
//                   ),
//                 ),
//                 // Inner circle with total time
//                 Container(
//                   width: 120,
//                   height: 120,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.black,
//                     border: Border.all(
//                       color: Colors.white.withOpacity(0.1),
//                       width: 2,
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.5),
//                         blurRadius: 10,
//                         spreadRadius: 1,
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'TODAY',
//                         style: TextStyle(
//                           color: Colors.yellow,
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: 1.2,
//                         ),
//                       ),
//                       SizedBox(height: 6),
//                       Text(
//                         '$totalUsageMinutes',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 26,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         'minutes',
//                         style: TextStyle(
//                           color: Colors.white70,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 16),
//           // Legend for the pie chart
//           SizedBox(
//             height: 80,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: appsWithUsage.length,
//               itemBuilder: (context, index) {
//                 final app = appsWithUsage[index];
//                 final color = getAppColor(app.appName);
//                 return Container(
//                   margin: EdgeInsets.only(right: 12),
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 15,
//                         height: 15,
//                         decoration: BoxDecoration(
//                           color: color,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       SizedBox(width: 6),
//                       Text(
//                         app.appName,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12,
//                         ),
//                       ),
//                       SizedBox(width: 4),
//                       Text(
//                         '(${app.usage.inMinutes}m)',
//                         style: TextStyle(
//                           color: Colors.white70,
//                           fontSize: 11,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final filteredApps = appLimits.where((app) {
//       return app.appName.toLowerCase().contains(searchQuery.toLowerCase());
//     }).toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Good morning, Aarthi 🌞'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.pie_chart),
//             onPressed: () => setState(() => showChart = !showChart),
//           ),
//           IconButton(
//             icon: Icon(Icons.settings_accessibility),
//             onPressed: openAccessibilitySettings,
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.black, Color(0xFF121212)],
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (showChart) ...[
//                 buildImprovedPieChart(),
//                 SizedBox(height: 20),
//               ],
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: "Search apps...",
//                     prefixIcon: Icon(Icons.search, color: Colors.black),
//                     border: InputBorder.none,
//                     contentPadding: EdgeInsets.symmetric(vertical: 15),
//                   ),
//                   onChanged: (val) => setState(() => searchQuery = val),
//                 ),
//               ),
//               SizedBox(height: 16),
//               if (appState == AppState.settingTotalLimit) ...[
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Color(0xFF1C1C1E),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Set Daily Time Limit",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white
//                         ),
//                       ),
//                       SizedBox(height: 12),
//                       Slider(
//                         min: 1,
//                         max: 8,
//                         divisions: 7,
//                         value: totalLimitInHours.toDouble(),
//                         label: "$totalLimitInHours hours per day",
//                         onChanged: (value) => setState(() => totalLimitInHours = value.toInt()),
//                       ),
//                       Text(
//                         "$totalLimitInHours hours per day",
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 13,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 16),
//                       Center(
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             await fetchApps();
//                             if (appLimits.isNotEmpty) {
//                               int minutesPerApp = (totalLimitInHours * 60) ~/ appLimits.length;
//                               setState(() {
//                                 for (var app in appLimits) {
//                                   app.limit = Duration(minutes: minutesPerApp);
//                                 }
//                                 appState = AppState.editingAppLimits;
//                               });
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             minimumSize: Size(150, 45),
//                             shape: StadiumBorder(),
//                           ),
//                           child: Text("Apply Limit"),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: filteredApps.length,
//                     itemBuilder: (context, index) {
//                       final app = filteredApps[index];
//                       final appColor = getAppColor(app.appName);
                      
//                       return Container(
//                         margin: EdgeInsets.only(bottom: 10),
//                         decoration: BoxDecoration(
//                           color: Color(0xFF1C1C1E),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: ListTile(
//                           leading: Container(
//                             width: 30,
//                             height: 30,
//                             decoration: BoxDecoration(
//                               color: appColor,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Icon(Icons.apps, color: Colors.white, size: 18),
//                           ),
//                           title: Text(
//                             app.appName,
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           subtitle: LinearProgressIndicator(
//                             value: app.usage.inMinutes / 60, // Just for visualization
//                             backgroundColor: Colors.grey.withOpacity(0.2),
//                             valueColor: AlwaysStoppedAnimation<Color>(appColor),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ] else if (appState == AppState.editingAppLimits) ...[
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Color(0xFF1C1C1E),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Set Daily Time Limit",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Slider(
//                         min: 1,
//                         max: 8,
//                         divisions: 7,
//                         value: totalLimitInHours.toDouble(),
//                         label: "$totalLimitInHours hours per day",
//                         onChanged: (value) => setState(() => totalLimitInHours = value.toInt()),
//                       ),
//                       Text(
//                         "$totalLimitInHours hours per day",
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 13,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         "Set time limit for each app (minutes):",
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 13,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: filteredApps.length,
//                     itemBuilder: (context, index) {
//                       final app = filteredApps[index];
//                       final appColor = getAppColor(app.appName);
                      
//                       return Container(
//                         margin: EdgeInsets.only(bottom: 10),
//                         decoration: BoxDecoration(
//                           color: Color(0xFF1C1C1E),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: ListTile(
//                           leading: Container(
//                             width: 30,
//                             height: 30,
//                             decoration: BoxDecoration(
//                               color: appColor,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Icon(Icons.apps, color: Colors.white, size: 18),
//                           ),
//                           title: Text(
//                             app.appName,
//                             style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
//                           ),
//                           trailing: Container(
//                             width: 60,
//                             height: 40,
//                             decoration: BoxDecoration(
//                               color: Colors.white10,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Center(
//                               child: TextField(
//                                 keyboardType: TextInputType.number,
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(color: Colors.black),
//                                 decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: app.limit.inMinutes.toString(),
//                                   hintStyle: TextStyle(color: Colors.black),
//                                   contentPadding: EdgeInsets.zero,
//                                 ),
//                                 onSubmitted: (val) {
//                                   int? min = int.tryParse(val);
//                                   if (min != null) updateLimit(app, min);
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 16.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       TextButton(
//                         onPressed: () {
//                           setState(() {
//                             appState = AppState.settingTotalLimit;
//                           });
//                         },
//                         child: Text('Cancel', style: TextStyle(color: Colors.grey)),
//                       ),
//                       ElevatedButton(
//                         onPressed: applyAndStart,
//                         style: ElevatedButton.styleFrom(
//                           minimumSize: Size(150, 45),
//                           shape: StadiumBorder(),
//                         ),
//                         child: Text("Apply & Start"),
//                       ),
//                     ],
//                   ),
//                 ),
//               ] else ...[
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: filteredApps.length,
//                     itemBuilder: (context, index) {
//                       final app = filteredApps[index];
//                       final overLimit = app.usage > app.limit;
//                       final appColor = getAppColor(app.appName);
                      
//                       return Container(
//                         margin: EdgeInsets.only(bottom: 10),
//                         decoration: BoxDecoration(
//                           color: overLimit 
//                               ? Colors.pink.withOpacity(0.25) 
//                               : Color(0xFF1C1C1E),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: ListTile(
//                           leading: Container(
//                             width: 30,
//                             height: 30,
//                             decoration: BoxDecoration(
//                               color: appColor,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Icon(Icons.apps, color: Colors.white, size: 18),
//                           ),
//                           title: Text(
//                             app.appName,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(height: 4),
//                               Text(
//                                 "Used: ${app.usage.inMinutes} min / Limit: ${app.limit.inMinutes} min",
//                                 style: TextStyle(color: Colors.white70),
//                               ),
//                               SizedBox(height: 4),
//                               LinearProgressIndicator(
//                                 value: app.usage.inMinutes / app.limit.inMinutes,
//                                 backgroundColor: Colors.grey.withOpacity(0.2),
//                                 valueColor: AlwaysStoppedAnimation<Color>(
//                                   overLimit ? Colors.pinkAccent : appColor,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           trailing: overLimit
//                               ? Icon(Icons.warning_amber_rounded, color: Colors.pinkAccent)
//                               : null,
//                         ),
//                       );
//                     },
//                   ),
//                 )
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }







//claude new at  1.00pm  Ui good blocking code and app usage also correct 

// import 'package:flutter/material.dart';
// import 'dart:math';

// import 'package:device_apps/device_apps.dart';
// import 'package:android_intent_plus/android_intent.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'dart:async';

// import 'package:flutter_tts/flutter_tts.dart';

// void main() {
//   runApp(MyApp());
// }

// enum AppState { settingTotalLimit, editingAppLimits, trackingUsage }

// class AppLimit {
//   final String packageName;
//   final String appName;
//   Duration usage;
//   Duration limit;

//   AppLimit({
//     required this.packageName,
//     required this.appName,
//     required this.usage,
//     required this.limit,
//   });
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Digital Wellbeing',
//       theme: ThemeData(
//         brightness: Brightness.dark,
//         scaffoldBackgroundColor: Colors.black,
//         cardColor: Color(0xFF1C1C1E),
//         primaryColor: Colors.pinkAccent,
//         sliderTheme: SliderThemeData(
//           activeTrackColor: Colors.pinkAccent,
//           inactiveTrackColor: Colors.grey.withOpacity(0.3),
//           thumbColor: Colors.pinkAccent,
//           overlayColor: Colors.pinkAccent.withOpacity(0.2),
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.pinkAccent,
//             foregroundColor: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(30), // Rounded button
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//           ),
//         ),
//         inputDecorationTheme: InputDecorationTheme(
//           filled: true,
//           fillColor: Colors.black.withOpacity(0.1),
//           hintStyle: TextStyle(color: Colors.white54),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide.none,
//           ),
//           prefixIconColor: Colors.pinkAccent,
//         ),
//         appBarTheme: AppBarTheme(
//           backgroundColor: Colors.black,
//           foregroundColor: Colors.white,
//           elevation: 0,
//         ),
//         textTheme: TextTheme(
//           bodyMedium: TextStyle(color: Colors.white),
//         ),
//       ),
//       home: HomeScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _openAccessibilityAndUsageSettings();
//     scheduleMidnightReset();
//     tts = FlutterTts();
//     super.initState();
//     _checkFirstRun();
//     if (appState == AppState.trackingUsage) {
//       fetchApps();
//       usageRefreshTimer = Timer.periodic(Duration(seconds: 60), (timer) {
//         fetchApps();
//       });
//     }
//   }

//   void _openAccessibilityAndUsageSettings() async {
//     final usageIntent = AndroidIntent(
//       action: 'android.settings.USAGE_ACCESS_SETTINGS',
//     );
//     await usageIntent.launch();

//     final accessibilityIntent = AndroidIntent(
//       action: 'android.settings.ACCESSIBILITY_SETTINGS',
//     );
//     await accessibilityIntent.launch();
//   }


//   List<AppLimit> appLimits = [];
//   int totalLimitInHours = 4; // Default to 4 hours as in the image
//   AppState appState = AppState.settingTotalLimit;
//   Timer? usageRefreshTimer;
//   static const platform = MethodChannel('app.usage/limits');
//   bool showChart = false;
//   String searchQuery = '';
//   late FlutterTts tts;
//   Set<String> warnedApps = {};



//   static const MethodChannel ownerChannel = MethodChannel('device.owner/admin');

//  final FlutterTts flutterTts = FlutterTts();
// Map<String, bool> appWarned = {};
  
//   // App color mapping to match the UI shown in your images
//   Map<String, Color> appColors = {
//     'instagram': const Color.fromRGBO(238,42,123,1),
//     'youtube': Color(0xFFFF0000),
//     'X': Color(0xFF141619),
//     'whatsapp': Color(0xFF228B22),
//     'spotify': Color(0xFF1DB954),
//     'gmail': Color(0xFFF2F6F3),
//     'telegram': Color(0xFF42A5F5),
//     'hotstar': Color(0xFF7E38E9),
//     'prime': Color(0xFF42A5F5),
//     'other': Colors.green.shade300,
//   };

   


//   Future<void> speakWarning(String message) async {
//     await flutterTts.setLanguage("en-US");
//     await flutterTts.setPitch(1);
//     await flutterTts.setSpeechRate(0.5);
//     await flutterTts.speak(message);
//   }

//   @override
  
//   void scheduleMidnightReset() {
//     final now = DateTime.now();
//     final nextMidnight = DateTime(now.year, now.month, now.day + 1);
//     final durationUntilMidnight = nextMidnight.difference(now);
//     Timer(durationUntilMidnight, () {
//       resetUsageData();
//       scheduleMidnightReset();
//     });
//   }

//   void resetUsageData() {
//     setState(() {
//       for (var app in appLimits) {
//         app.usage = Duration.zero;
//       }
//       warnedApps.clear();
//     });
//     try {
//     platform.invokeMethod('removeDeviceAdmin');
//   } catch (e) {
//     print("Error removing Device Admin: $e");
//   }
//   }



//  void checkAndWarn(AppLimit app) {
//   if (app.usage >= app.limit && !warnedApps.contains(app.packageName)) {
//     tts.speak("${app.appName} usage limit exceeded");
//     warnedApps.add(app.packageName);
//   }
// }



// @override
//   void dispose() {
//     usageRefreshTimer?.cancel();
//     super.dispose();
//   }



//   Future<void> _checkFirstRun() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isFirstRun = prefs.getBool('first_run') ?? true;

//     if (isFirstRun) {
//       openAccessibilitySettings();
//       await prefs.setBool('first_run', false);
//     }
//   }

//   Future<Map<String, Duration>> getAccurateUsage() async {
//     try {
//       final now = DateTime.now();
//       final startOfDay = DateTime(now.year, now.month, now.day);
//       final Map result = await platform.invokeMethod("getAccurateUsage", {
//         "from": startOfDay.millisecondsSinceEpoch,
//         "to": now.millisecondsSinceEpoch,
//       });

//       return result.map((pkg, millis) => MapEntry(pkg.toString(), Duration(milliseconds: millis)));
//     } catch (e) {
//       print("Failed to get accurate usage: $e");
//       return {};
//     }
//   }


// Future<void> fetchApps() async {
//   List<Application> apps = await DeviceApps.getInstalledApplications(
//     includeAppIcons: true,
//     includeSystemApps: true,
//   );

//   final keywords = [
//     'whatsapp', 'instagram', 'facebook', 'youtube', 'snapchat', 'X',
//     'tiktok', 'zoom', 'meet', 'teams', 'telegram', 'messenger', 'reddit','sharechat',
//     'netflix', 'prime', 'hotstar', 'spotify', 'mxplayer', 'vlc', 'game',
//   ];

//   const allowedSystemPackages = [
//     'com.google.android.youtube',
//   ];

//   Map<String, Duration> usageMap = await getAccurateUsage();
//   List<AppLimit> tempLimits = [];

//   for (Application app in apps) {
//     final nameLower = app.appName.toLowerCase();
//     final pkgLower = app.packageName.toLowerCase();
//     final isAllowedSystemApp = allowedSystemPackages.contains(app.packageName);

//     if ((!app.systemApp || isAllowedSystemApp) &&
//         keywords.any((kw) => nameLower.contains(kw) || pkgLower.contains(kw))) {
//       try {
//         Duration appUsageDuration = usageMap[app.packageName] ?? Duration.zero;

//         AppLimit existing = appLimits.firstWhere(
//           (e) => e.packageName == app.packageName,
//           orElse: () => AppLimit(
//             packageName: app.packageName,
//             appName: app.appName,
//             usage: Duration.zero,
//             limit: Duration(minutes: 10),
//           ),
//         );

//         Duration appLimit = existing.limit;

//         // 🗣️ Voice Assistant Logic
//         int usedMinutes = appUsageDuration.inMinutes;
//         int limitMinutes = appLimit.inMinutes;
//         double usagePercent = usedMinutes / (limitMinutes == 0 ? 1 : limitMinutes);

//         if (usagePercent >= 0.9 && usagePercent < 1.0 && appWarned[app.packageName] != true) {
//           await speakWarning("Warning! You're about to reach your limit on ${app.appName}.");
//           appWarned[app.packageName] = true;
//         }

//         if (usedMinutes >= limitMinutes) {
//           await speakWarning("Time's up! You've reached your limit on ${app.appName}.");
//         }

//         tempLimits.add(AppLimit(
//           packageName: app.packageName,
//           appName: app.appName,
//           usage: appUsageDuration,
//           limit: appLimit,
//         ));
//       } catch (e) {
//         print("Error reading usage for ${app.packageName}: $e");
//       }
//     }
//   }

//   tempLimits.sort((a, b) => b.usage.compareTo(a.usage));

//   setState(() {
//     appLimits = tempLimits;
//   });

//   sendUsageLimits(tempLimits);
// }

//   Future<void> sendUsageLimits(List<AppLimit> limits) async {
//     final data = limits
//         .where((e) => e.usage >= e.limit)
//         .map((e) => {
//               'package': e.packageName,
//               'limitMinutes': e.limit.inMinutes,
//             })
//         .toList();

//     try {
//       await platform.invokeMethod('updateLimits', data);
//     } catch (e) {
//       print("Failed to send limits to native code: $e");
//     }
//   }

//   void setTotalLimit(int hours) {
//     int minutesPerApp = (hours * 60 ~/ appLimits.length);
//     setState(() {
//       totalLimitInHours = hours;
//       for (var app in appLimits) {
//         app.limit = Duration(minutes: minutesPerApp);
//       }
//       appState = AppState.editingAppLimits;
//     });
//   }

//   void updateLimit(AppLimit app, int minutes) {
//     int totalMinutes = appLimits.fold(0, (sum, a) => sum + a.limit.inMinutes);
//     int newTotal = totalMinutes - app.limit.inMinutes + minutes;

//     if (newTotal <= totalLimitInHours * 60) {
//       setState(() {
//         app.limit = Duration(minutes: minutes);
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text("Invalid time distribution: exceeds total limit."),
//       ));
//     }
//   }

//   void applyAndStart() async {
//     setState(() {
//       appState = AppState.trackingUsage;
//     });
//     fetchApps();
//     usageRefreshTimer = Timer.periodic(Duration(seconds: 60), (timer) {
//       fetchApps();
//     });

//     try {
//     await ownerChannel.invokeMethod("blockUninstall", {"block": true});
//   } catch (e) {
//     print("Failed to block uninstall: $e");
//   }
//   }

//   void openAccessibilitySettings() {
//     const intent = AndroidIntent(action: 'android.settings.ACCESSIBILITY_SETTINGS');
//     intent.launch();
//   }

//   // Get color for an app based on its name
//   Color getAppColor(String appName) {
//     String nameLower = appName.toLowerCase();
//     for (var key in appColors.keys) {
//       if (nameLower.contains(key)) {
//         return appColors[key]!;
//       }
//     }
//     // Default color if no match found
//     return Colors.grey;
//   }

//   Widget buildImprovedPieChart() {
//     List<AppLimit> appsWithUsage = appLimits.where((a) => a.usage.inMinutes > 0).toList();
//     int totalUsageMinutes = appsWithUsage.fold(0, (sum, app) => sum + app.usage.inMinutes);
    
//     if (appsWithUsage.isEmpty) {
//       // If there's no usage data yet, return placeholder text
//       return Center(
//         child: Text(
//           'No usage data available yet',
//           style: TextStyle(color: Colors.white70),
//         ),
//       );
//     }

//     // Create pie chart sections
//     List<PieChartSectionData> sections = [];
//     for (int i = 0; i < appsWithUsage.length; i++) {
//       final app = appsWithUsage[i];
//       final percentage = app.usage.inMinutes / totalUsageMinutes;
      
//       sections.add(
//         PieChartSectionData(
//           color: getAppColor(app.appName),
//           value: app.usage.inMinutes.toDouble(),
//           title: '',
//           radius: 85,
//           titlePositionPercentageOffset: 0.6,
//           borderSide: BorderSide(width: 1, color: Colors.black),
//         ),
//       );
//     }

//     return Container(
//       height: 320,
//       width: double.infinity,
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Color(0xFF1C1C1E),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         children: [
//           Text(
//             "App Usage Overview",
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(height: 16),
//           Expanded(
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 // Outer shadow for depth
//                 Container(
//                   width: 190,
//                   height: 190,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.3),
//                         blurRadius: 20,
//                         spreadRadius: 2,
//                       ),
//                     ],
//                   ),
//                 ),
//                 // The pie chart
//                 PieChart(
//                   PieChartData(
//                     sectionsSpace: 1,
//                     centerSpaceRadius: 60,
//                     sections: sections,
//                     startDegreeOffset: 270, // Start from the top
//                     pieTouchData: PieTouchData(enabled: false),
//                     borderData: FlBorderData(show: false),
//                   ),
//                 ),
//                 // Inner circle with total time
//                 Container(
//                   width: 120,
//                   height: 120,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.black,
//                     border: Border.all(
//                       color: Colors.white.withOpacity(0.1),
//                       width: 2,
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.5),
//                         blurRadius: 10,
//                         spreadRadius: 1,
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'TODAY',
//                         style: TextStyle(
//                           color: Colors.yellow,
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: 1.2,
//                         ),
//                       ),
//                       SizedBox(height: 6),
//                       Text(
//                         '$totalUsageMinutes',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 26,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         'minutes',
//                         style: TextStyle(
//                           color: Colors.white70,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 16),
//           // Legend for the pie chart
//           SizedBox(
//             height: 80,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: appsWithUsage.length,
//               itemBuilder: (context, index) {
//                 final app = appsWithUsage[index];
//                 final color = getAppColor(app.appName);
//                 return Container(
//                   margin: EdgeInsets.only(right: 12),
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 15,
//                         height: 15,
//                         decoration: BoxDecoration(
//                           color: color,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       SizedBox(width: 6),
//                       Text(
//                         app.appName,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12,
//                         ),
//                       ),
//                       SizedBox(width: 4),
//                       Text(
//                         '(${app.usage.inMinutes}m)',
//                         style: TextStyle(
//                           color: Colors.white70,
//                           fontSize: 11,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final filteredApps = appLimits.where((app) {
//       return app.appName.toLowerCase().contains(searchQuery.toLowerCase());
//     }).toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Good morning, Aarthi 🌞'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.pie_chart),
//             onPressed: () => setState(() => showChart = !showChart),
//           ),
//           IconButton(
//             icon: Icon(Icons.settings_accessibility),
//             onPressed: openAccessibilitySettings,
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.black, Color(0xFF121212)],
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (showChart) ...[
//                 buildImprovedPieChart(),
//                 SizedBox(height: 20),
//               ],
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: "Search apps...",
//                     prefixIcon: Icon(Icons.search, color: Colors.black),
//                     border: InputBorder.none,
//                     contentPadding: EdgeInsets.symmetric(vertical: 15),
//                   ),
//                   onChanged: (val) => setState(() => searchQuery = val),
//                 ),
//               ),
//               SizedBox(height: 16),
//               if (appState == AppState.settingTotalLimit) ...[
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Color(0xFF1C1C1E),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Set Daily Time Limit",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white
//                         ),
//                       ),
//                       SizedBox(height: 12),
//                       Slider(
//                         min: 1,
//                         max: 8,
//                         divisions: 7,
//                         value: totalLimitInHours.toDouble(),
//                         label: "$totalLimitInHours hours per day",
//                         onChanged: (value) => setState(() => totalLimitInHours = value.toInt()),
//                       ),
//                       Text(
//                         "$totalLimitInHours hours per day",
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 13,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 16),
//                       Center(
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             await fetchApps();
//                             if (appLimits.isNotEmpty) {
//                               int minutesPerApp = (totalLimitInHours * 60) ~/ appLimits.length;
//                               setState(() {
//                                 for (var app in appLimits) {
//                                   app.limit = Duration(minutes: minutesPerApp);
//                                 }
//                                 appState = AppState.editingAppLimits;
//                               });
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             minimumSize: Size(150, 45),
//                             shape: StadiumBorder(),
//                           ),
//                           child: Text("Apply Limit"),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: filteredApps.length,
//                     itemBuilder: (context, index) {
//                       final app = filteredApps[index];
//                       final appColor = getAppColor(app.appName);
                      
//                       return Container(
//                         margin: EdgeInsets.only(bottom: 10),
//                         decoration: BoxDecoration(
//                           color: Color(0xFF1C1C1E),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: ListTile(
//                           leading: Container(
//                             width: 30,
//                             height: 30,
//                             decoration: BoxDecoration(
//                               color: appColor,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Icon(Icons.apps, color: Colors.white, size: 18),
//                           ),
//                           title: Text(
//                             app.appName,
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           subtitle: LinearProgressIndicator(
//                             value: app.usage.inMinutes / 60, // Just for visualization
//                             backgroundColor: Colors.grey.withOpacity(0.2),
//                             valueColor: AlwaysStoppedAnimation<Color>(appColor),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ] else if (appState == AppState.editingAppLimits) ...[
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Color(0xFF1C1C1E),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Set Daily Time Limit",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Slider(
//                         min: 1,
//                         max: 8,
//                         divisions: 7,
//                         value: totalLimitInHours.toDouble(),
//                         label: "$totalLimitInHours hours per day",
//                         onChanged: (value) => setState(() => totalLimitInHours = value.toInt()),
//                       ),
//                       Text(
//                         "$totalLimitInHours hours per day",
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 13,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         "Set time limit for each app (minutes):",
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 13,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: filteredApps.length,
//                     itemBuilder: (context, index) {
//                       final app = filteredApps[index];
//                       final appColor = getAppColor(app.appName);
                      
//                       return Container(
//                         margin: EdgeInsets.only(bottom: 10),
//                         decoration: BoxDecoration(
//                           color: Color(0xFF1C1C1E),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: ListTile(
//                           leading: Container(
//                             width: 30,
//                             height: 30,
//                             decoration: BoxDecoration(
//                               color: appColor,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Icon(Icons.apps, color: Colors.white, size: 18),
//                           ),
//                           title: Text(
//                             app.appName,
//                             style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
//                           ),
//                           trailing: Container(
//                             width: 60,
//                             height: 40,
//                             decoration: BoxDecoration(
//                               color: Colors.white10,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Center(
//                               child: TextField(
//                                 keyboardType: TextInputType.number,
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(color: Colors.black),
//                                 decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: app.limit.inMinutes.toString(),
//                                   hintStyle: TextStyle(color: Colors.black),
//                                   contentPadding: EdgeInsets.zero,
//                                 ),
//                                 onSubmitted: (val) {
//                                   int? min = int.tryParse(val);
//                                   if (min != null) updateLimit(app, min);
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 16.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       TextButton(
//                         onPressed: () {
//                           setState(() {
//                             appState = AppState.settingTotalLimit;
//                           });
//                         },
//                         child: Text('Cancel', style: TextStyle(color: Colors.grey)),
//                       ),
//                       ElevatedButton(
//                         onPressed: applyAndStart,
//                         style: ElevatedButton.styleFrom(
//                           minimumSize: Size(150, 45),
//                           shape: StadiumBorder(),
//                         ),
//                         child: Text("Apply & Start"),
//                       ),
//                     ],
//                   ),
//                 ),
//               ] else ...[
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: filteredApps.length,
//                     itemBuilder: (context, index) {
//                       final app = filteredApps[index];
//                       final overLimit = app.usage > app.limit;
//                       final appColor = getAppColor(app.appName);
                      
//                       return Container(
//                         margin: EdgeInsets.only(bottom: 10),
//                         decoration: BoxDecoration(
//                           color: overLimit 
//                               ? Colors.pink.withOpacity(0.25) 
//                               : Color(0xFF1C1C1E),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: ListTile(
//                           leading: Container(
//                             width: 30,
//                             height: 30,
//                             decoration: BoxDecoration(
//                               color: appColor,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Icon(Icons.apps, color: Colors.white, size: 18),
//                           ),
//                           title: Text(
//                             app.appName,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(height: 4),
//                               Text(
//                                 "Used: ${app.usage.inMinutes} min / Limit: ${app.limit.inMinutes} min",
//                                 style: TextStyle(color: Colors.white70),
//                               ),
//                               SizedBox(height: 4),
//                               LinearProgressIndicator(
//                                 value: app.usage.inMinutes / app.limit.inMinutes,
//                                 backgroundColor: Colors.grey.withOpacity(0.2),
//                                 valueColor: AlwaysStoppedAnimation<Color>(
//                                   overLimit ? Colors.pinkAccent : appColor,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           trailing: overLimit
//                               ? Icon(Icons.warning_amber_rounded, color: Colors.pinkAccent)
//                               : null,
//                         ),
//                       );
//                     },
//                   ),
//                 )
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }








//claude new at  1.00pm  Ui good blocking code and app usage also correct 

import 'package:flutter/material.dart';

import 'package:device_apps/device_apps.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';

import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MyApp());
}

enum AppState { settingTotalLimit, editingAppLimits, trackingUsage }

class AppLimit {
  final String packageName;
  final String appName;
  Duration usage;
  Duration limit;

  AppLimit({
    required this.packageName,
    required this.appName,
    required this.usage,
    required this.limit,
  });
}


  final FlutterTts flutterTts = FlutterTts();
  Set<String> warnedApps = {};

  void initTTS() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
  }


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Wellbeing',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        cardColor: Color(0xFF1C1C1E),
        primaryColor: Colors.pinkAccent,
        sliderTheme: SliderThemeData(
          activeTrackColor: Colors.pinkAccent,
          inactiveTrackColor: Colors.grey.withOpacity(0.3),
          thumbColor: Colors.pinkAccent,
          overlayColor: Colors.pinkAccent.withOpacity(0.2),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pinkAccent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Rounded button
            ),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.black.withOpacity(0.1),
          hintStyle: TextStyle(color: Colors.white54),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          prefixIconColor: Colors.pinkAccent,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    initTTS();
    super.initState();
    _openAccessibilityAndUsageSettings();
    initTTS();
    scheduleMidnightReset();
    tts = FlutterTts();
    super.initState();
    _checkFirstRun();
    if (appState == AppState.trackingUsage) {
      fetchApps();
      usageRefreshTimer = Timer.periodic(Duration(seconds: 60), (timer) {
        fetchApps();
      });
    }
  }

  void _openAccessibilityAndUsageSettings() async {
    final usageIntent = AndroidIntent(
      action: 'android.settings.USAGE_ACCESS_SETTINGS',
    );
    await usageIntent.launch();

    final accessibilityIntent = AndroidIntent(
      action: 'android.settings.ACCESSIBILITY_SETTINGS',
    );
    await accessibilityIntent.launch();
  }


  List<AppLimit> appLimits = [];
  int totalLimitInHours = 4; // Default to 4 hours as in the image
  AppState appState = AppState.settingTotalLimit;
  Timer? usageRefreshTimer;
  static const platform = MethodChannel('app.usage/limits');
  bool showChart = false;
  String searchQuery = '';
  late FlutterTts tts;
  Set<String> warnedApps = {};



  static const MethodChannel ownerChannel = MethodChannel('device.owner/admin');

 final FlutterTts flutterTts = FlutterTts();
Map<String, bool> appWarned = {};
  
  // App color mapping to match the UI shown in your images
  Map<String, Color> appColors = {
    'instagram': const Color.fromRGBO(238,42,123,1),
    'youtube': Color(0xFFFF0000),
    'X': Color(0xFF141619),
    'whatsapp': Color(0xFF228B22),
    'spotify': Color(0xFF1DB954),
    'gmail': Color(0xFFF2F6F3),
    'telegram': Color(0xFF42A5F5),
    'hotstar': Color(0xFF7E38E9),
    'prime': Color(0xFF42A5F5),
    'other': Colors.green.shade300,
  };

    

  Future<void> speakWarning(String message) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(message);
  }

  @override
  
  void scheduleMidnightReset() {
    final now = DateTime.now();
    final nextMidnight = DateTime(now.year, now.month, now.day + 1);
    final durationUntilMidnight = nextMidnight.difference(now);
    Timer(durationUntilMidnight, () {
      resetUsageData();
      scheduleMidnightReset();
    });
  }

  void resetUsageData() {
    setState(() {
      for (var app in appLimits) {
        app.usage = Duration.zero;
      }
      warnedApps.clear();
    });
    try {
    platform.invokeMethod('removeDeviceAdmin');
  } catch (e) {
    print("Error removing Device Admin: $e");
  }
  }



 void checkAndWarn(AppLimit app) {
  if (app.usage >= app.limit && !warnedApps.contains(app.packageName)) {
    tts.speak("${app.appName} usage limit exceeded");
    warnedApps.add(app.packageName);
  }
}



@override
  void dispose() {
    usageRefreshTimer?.cancel();
    super.dispose();
  }



  Future<void> _checkFirstRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstRun = prefs.getBool('first_run') ?? true;

    if (isFirstRun) {
      openAccessibilitySettings();
      await prefs.setBool('first_run', false);
    }
  }

  Future<Map<String, Duration>> getAccurateUsage() async {
    try {
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      final Map result = await platform.invokeMethod("getAccurateUsage", {
        "from": startOfDay.millisecondsSinceEpoch,
        "to": now.millisecondsSinceEpoch,
      });

      return result.map((pkg, millis) => MapEntry(pkg.toString(), Duration(milliseconds: millis)));
    } catch (e) {
      print("Failed to get accurate usage: $e");
      return {};
    }
  }


Future<void> fetchApps() async {
  List<Application> apps = await DeviceApps.getInstalledApplications(
    includeAppIcons: true,
    includeSystemApps: true,
  );

  final keywords = [
    'whatsapp', 'instagram', 'facebook', 'youtube', 'snapchat', 'X',
    'tiktok', 'zoom', 'meet', 'teams', 'telegram', 'messenger', 'reddit','sharechat',
    'netflix', 'prime', 'hotstar', 'spotify', 'mxplayer', 'vlc', 'game',
  ];

  const allowedSystemPackages = [
    'com.google.android.youtube',
  ];

  Map<String, Duration> usageMap = await getAccurateUsage();
  List<AppLimit> tempLimits = [];

  for (Application app in apps) {
    final nameLower = app.appName.toLowerCase();
    final pkgLower = app.packageName.toLowerCase();
    final isAllowedSystemApp = allowedSystemPackages.contains(app.packageName);

    if ((!app.systemApp || isAllowedSystemApp) &&
        keywords.any((kw) => nameLower.contains(kw) || pkgLower.contains(kw))) {
      try {
        Duration appUsageDuration = usageMap[app.packageName] ?? Duration.zero;

        AppLimit existing = appLimits.firstWhere(
          (e) => e.packageName == app.packageName,
          orElse: () => AppLimit(
            packageName: app.packageName,
            appName: app.appName,
            usage: Duration.zero,
            limit: Duration(minutes: 10),
          ),
        );

        Duration appLimit = existing.limit;

        // 🗣️ Voice Assistant Logic
        int usedMinutes = appUsageDuration.inMinutes;
        int limitMinutes = appLimit.inMinutes;
        double usagePercent = usedMinutes / (limitMinutes == 0 ? 1 : limitMinutes);

        if (usagePercent >= 0.9 && usagePercent < 1.0 && appWarned[app.packageName] != true) {
          await speakWarning("Warning! You're about to reach your limit on ${app.appName}.");
          appWarned[app.packageName] = true;
        }

        if (usedMinutes >= limitMinutes) {
          await speakWarning("Time's up! You've reached your limit on ${app.appName}.");
        }

        tempLimits.add(AppLimit(
          packageName: app.packageName,
          appName: app.appName,
          usage: appUsageDuration,
          limit: appLimit,
        ));
      } catch (e) {
        print("Error reading usage for ${app.packageName}: $e");
      }
    }
  }

  tempLimits.sort((a, b) => b.usage.compareTo(a.usage));

  setState(() {
    appLimits = tempLimits;
  });

  sendUsageLimits(tempLimits);
}

  Future<void> sendUsageLimits(List<AppLimit> limits) async {
    final data = limits
        .where((e) => e.usage >= e.limit)
        .map((e) => {
              'package': e.packageName,
              'limitMinutes': e.limit.inMinutes,
            })
        .toList();

    try {
      await platform.invokeMethod('updateLimits', data);
    } catch (e) {
      print("Failed to send limits to native code: $e");
    }
  }

  void setTotalLimit(int hours) {
    int minutesPerApp = (hours * 60 ~/ appLimits.length);
    setState(() {
      totalLimitInHours = hours;
      for (var app in appLimits) {
        app.limit = Duration(minutes: minutesPerApp);
      }
      appState = AppState.editingAppLimits;
    });
  }

  void updateLimit(AppLimit app, int minutes) {
    int totalMinutes = appLimits.fold(0, (sum, a) => sum + a.limit.inMinutes);
    int newTotal = totalMinutes - app.limit.inMinutes + minutes;

    if (newTotal <= totalLimitInHours * 60) {
      setState(() {
        app.limit = Duration(minutes: minutes);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Invalid time distribution: exceeds total limit."),
      ));
    }
  }

  void applyAndStart() async {
    setState(() {
      appState = AppState.trackingUsage;
    });
    fetchApps();
    usageRefreshTimer = Timer.periodic(Duration(seconds: 60), (timer) {
      fetchApps();
    });

    try {
    await ownerChannel.invokeMethod("blockUninstall", {"block": true});
  } catch (e) {
    print("Failed to block uninstall: $e");
  }
  }

  void openAccessibilitySettings() {
    const intent = AndroidIntent(action: 'android.settings.ACCESSIBILITY_SETTINGS');
    intent.launch();
  }

  // Get color for an app based on its name
  Color getAppColor(String appName) {
    String nameLower = appName.toLowerCase();
    for (var key in appColors.keys) {
      if (nameLower.contains(key)) {
        return appColors[key]!;
      }
    }
    // Default color if no match found
    return Colors.grey;
  }

  Widget buildImprovedPieChart() {
    List<AppLimit> appsWithUsage = appLimits.where((a) => a.usage.inMinutes > 0).toList();
    int totalUsageMinutes = appsWithUsage.fold(0, (sum, app) => sum + app.usage.inMinutes);
    
    if (appsWithUsage.isEmpty) {
      // If there's no usage data yet, return placeholder text
      return Center(
        child: Text(
          'No usage data available yet',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    // Create pie chart sections
    List<PieChartSectionData> sections = [];
    for (int i = 0; i < appsWithUsage.length; i++) {
      final app = appsWithUsage[i];
      final percentage = app.usage.inMinutes / totalUsageMinutes;
      
      sections.add(
        PieChartSectionData(
          color: getAppColor(app.appName),
          value: app.usage.inMinutes.toDouble(),
          title: '',
          radius: 85,
          titlePositionPercentageOffset: 0.6,
          borderSide: BorderSide(width: 1, color: Colors.black),
        ),
      );
    }

    return Container(
      height: 320,
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            "App Usage Overview",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer shadow for depth
                Container(
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
                // The pie chart
                PieChart(
                  PieChartData(
                    sectionsSpace: 1,
                    centerSpaceRadius: 60,
                    sections: sections,
                    startDegreeOffset: 270, // Start from the top
                    pieTouchData: PieTouchData(enabled: false),
                    borderData: FlBorderData(show: false),
                  ),
                ),
                // Inner circle with total time
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'TODAY',
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        '$totalUsageMinutes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'minutes',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          // Legend for the pie chart
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: appsWithUsage.length,
              itemBuilder: (context, index) {
                final app = appsWithUsage[index];
                final color = getAppColor(app.appName);
                return Container(
                  margin: EdgeInsets.only(right: 12),
                  child: Row(
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        app.appName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '(${app.usage.inMinutes}m)',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredApps = appLimits.where((app) {
      return app.appName.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: [
          IconButton(
            icon: Icon(Icons.pie_chart),
            onPressed: () => setState(() => showChart = !showChart),
          ),
          IconButton(
            icon: Icon(Icons.settings_accessibility),
            onPressed: openAccessibilitySettings,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Color(0xFF121212)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showChart) ...[
                buildImprovedPieChart(),
                SizedBox(height: 20),
              ],
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search apps...",
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  onChanged: (val) => setState(() => searchQuery = val),
                ),
              ),
              SizedBox(height: 16),
              if (appState == AppState.settingTotalLimit) ...[
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFF1C1C1E),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Set Daily Time Limit",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                      SizedBox(height: 12),
                      Slider(
                        min: 1,
                        max: 8,
                        divisions: 7,
                        value: totalLimitInHours.toDouble(),
                        label: "$totalLimitInHours hours per day",
                        onChanged: (value) => setState(() => totalLimitInHours = value.toInt()),
                      ),
                      Text(
                        "$totalLimitInHours hours per day",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            await fetchApps();
                            if (appLimits.isNotEmpty) {
                              int minutesPerApp = (totalLimitInHours * 60) ~/ appLimits.length;
                              setState(() {
                                for (var app in appLimits) {
                                  app.limit = Duration(minutes: minutesPerApp);
                                }
                                appState = AppState.editingAppLimits;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(150, 45),
                            shape: StadiumBorder(),
                          ),
                          child: Text("Apply Limit"),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredApps.length,
                    itemBuilder: (context, index) {
                      final app = filteredApps[index];
                      final appColor = getAppColor(app.appName);
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Color(0xFF1C1C1E),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: appColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.apps, color: Colors.white, size: 18),
                          ),
                          title: Text(
                            app.appName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: LinearProgressIndicator(
                            value: app.usage.inMinutes / 60, // Just for visualization
                            backgroundColor: Colors.grey.withOpacity(0.2),
                            valueColor: AlwaysStoppedAnimation<Color>(appColor),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ] else if (appState == AppState.editingAppLimits) ...[
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFF1C1C1E),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Set Daily Time Limit",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                      SizedBox(height: 8),
                      Slider(
                        min: 1,
                        max: 8,
                        divisions: 7,
                        value: totalLimitInHours.toDouble(),
                        label: "$totalLimitInHours hours per day",
                        onChanged: (value) => setState(() => totalLimitInHours = value.toInt()),
                      ),
                      Text(
                        "$totalLimitInHours hours per day",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Set time limit for each app (minutes):",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredApps.length,
                    itemBuilder: (context, index) {
                      final app = filteredApps[index];
                      final appColor = getAppColor(app.appName);
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Color(0xFF1C1C1E),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: appColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.apps, color: Colors.white, size: 18),
                          ),
                          title: Text(
                            app.appName,
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                          trailing: Container(
                            width: 60,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: app.limit.inMinutes.toString(),
                                  hintStyle: TextStyle(color: Colors.black),
                                  contentPadding: EdgeInsets.zero,
                                ),
                                onSubmitted: (val) {
                                  int? min = int.tryParse(val);
                                  if (min != null) updateLimit(app, min);
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            appState = AppState.settingTotalLimit;
                          });
                        },
                        child: Text('Cancel', style: TextStyle(color: Colors.grey)),
                      ),
                      ElevatedButton(
                        onPressed: applyAndStart,
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(150, 45),
                          shape: StadiumBorder(),
                        ),
                        child: Text("Apply & Start"),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredApps.length,
                    itemBuilder: (context, index) {
                      final app = filteredApps[index];
                      final overLimit = app.usage > app.limit;
                      final appColor = getAppColor(app.appName);
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: overLimit 
                              ? Colors.pink.withOpacity(0.25) 
                              : Color(0xFF1C1C1E),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: appColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.apps, color: Colors.white, size: 18),
                          ),
                          title: Text(
                            app.appName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 4),
                              Text(
                                "Used: ${app.usage.inMinutes} min / Limit: ${app.limit.inMinutes} min",
                                style: TextStyle(color: Colors.white70),
                              ),
                              SizedBox(height: 4),
                              LinearProgressIndicator(
                                value: app.usage.inMinutes / app.limit.inMinutes,
                                backgroundColor: Colors.grey.withOpacity(0.2),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  overLimit ? Colors.pinkAccent : appColor,
                                ),
                              ),
                            ],
                          ),
                          trailing: overLimit
                              ? Icon(Icons.warning_amber_rounded, color: Colors.pinkAccent)
                              : null,
                        ),
                      );
                    },
                  ),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}