import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instafake_flutter/core/presentation/auth/auth_screen.dart';
import 'package:instafake_flutter/core/presentation/home/home_screen.dart';
import 'package:instafake_flutter/core/providers/auth_provider.dart';
import 'package:instafake_flutter/core/providers/home_provider.dart';
import 'package:instafake_flutter/core/providers/camera_provider.dart';
import 'package:instafake_flutter/core/providers/profile_provider.dart';
import 'package:instafake_flutter/dependency_injection.dart';
import 'package:instafake_flutter/services/account_service.dart';
import 'package:instafake_flutter/services/connectivity_service.dart';
import 'package:instafake_flutter/services/user_data_service.dart';
import 'package:instafake_flutter/utils/theme.dart';
import 'package:provider/provider.dart';

// READ ME


// After several days bashing my head against the wall of my bedroom and office, bashing my keyboard from time to time, trying to make sense how to build a fully fledge        /next line
// Instagram with a very limited time constraint -- of which I just started working on it on day 3 becase of my tight schedule -- I finally realized that I didn't need         /next line
// to build a fully fledge Instagram clone. I literally just realized that on Friday night. All this time I spent my time working on the data persistency first, turned out     /next line
// I wasn't required to. So if you encounter blocked codes, those are the codes that was supposed to be continued but I blocked it becuase it's impossible to build them        /next line
// in such short notice. I spent 2 days on working with the Data Persistency, so, brace yourself because this application is made with rush.

// I use GetX because of its perfect ability for dependency injection which makes it easier for me to manage the storage and services.
// The GetService interface has the ability to store value in memory and accessible throughout the application as long as the service class is not terminated                   /next line
// - very useful for clean architecture.
// There are so many Get.put()s being called. That is because I want to create instances in memory so the value will be accessible to the affected classes                      /next line
// - avoiding any kind of repeating initialization which in my honest opinion it will slow down the application.
// For state management, I use Provider as required. Although I still prefer GetX because of the aforementioned reasoning, maybe because I'm not really good at Provider        /next line
// - I can learn and improve my technique once I see a source code from a complex application created fully with Provider.
// For the sake of simplicity, I use Hive as my storage solution. It's pretty quick at loading and saving data. I know data persistence is not required, I just can't help it.  /next line
// - I really care about quality and I want to make sure that my application will be able to run smoothly.
// I don't have enough time to generate unit tests as I rely on manual tests for every function, method, or API I created.                                                      /next line
// - I hope that my code is clean and understandable. I will make sure to write unit tests in the future.
// It's more into that no one ever shown me and taught me how to code for unit tests, integration tests, and end-to-end. I still scratch my head everytime I do this            /next line
// - perhaps, if I get accepted, I can learn how to do it properly from better developers and I can improve my skills.


// A bit of myself, I code because I love doing this. It's like playing a grand strategy game like HOI4 or Victoria 3 -- gotta build properly from beginning or lose the end game.

Future<void> main() async {

  await DependencyInjection.init();
  UserDataService userService = Get.find<UserDataService>();
  bool isLogin = false;
  
  if(DependencyInjection.isJwtExpired(userService.userModel==null? '' : userService.userModel!.token)){
    isLogin = false;
  }else {
    isLogin = true;
  }
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(InstafakeApp(isLogin: isLogin));
}

class InstafakeApp extends StatelessWidget {
  final bool isLogin;
  InstafakeApp({super.key, required this.isLogin});

  final DeviceStatusService accountService = Get.find<DeviceStatusService>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context)=>AuthProvider(userModelRepository:  Get.find()),
        ),
        
        ChangeNotifierProvider(
          create: (context)=>ConnectivityProvider(),
        ),

        ChangeNotifierProvider(
          create: (context)=>HomeProvider(
            postModelRepository: Get.find(), 
            storyModelRepository: Get.find(),
            userModelRepository: Get.find()),
        ),

        ChangeNotifierProvider(
          create: (context)=>CameraProvider(postModelRepository: Get.find(), storyModelRepository: Get.find())
        ),

        ChangeNotifierProvider(
          create: (context)=>ProfileProvider(userRepo: Get.find())
        )

      ],
      child: GetMaterialApp(
        defaultTransition: Transition.cupertino,
        debugShowCheckedModeBanner: false,
        theme: MaterialTheme(
        TextTheme(
          displayLarge: GoogleFonts.poppins(
            fontSize: 72,
            fontWeight: FontWeight.w300,
          ),
          displayMedium: GoogleFonts.poppins(
            fontSize: 48,
            fontWeight: FontWeight.w300,
          ),
          displaySmall: GoogleFonts.poppins(
            fontSize: 42,
            fontWeight: FontWeight.w400
          ),
          headlineMedium: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
          headlineSmall: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w400
          ),
          titleLarge: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          titleMedium: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          titleSmall: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          labelLarge: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          bodySmall: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
          labelSmall: GoogleFonts.poppins(
            fontSize: 8,
            fontWeight: FontWeight.w400,
          ),
        )
      ).light(),
      darkTheme: MaterialTheme(
        TextTheme(
          displayLarge: GoogleFonts.poppins(
            fontSize: 72,
            fontWeight: FontWeight.w300,
          ),
          displayMedium: GoogleFonts.poppins(
            fontSize: 48,
            fontWeight: FontWeight.w300,
          ),
          displaySmall: GoogleFonts.poppins(
            fontSize: 42,
            fontWeight: FontWeight.w400
          ),
          headlineMedium: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
          headlineSmall: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w400
          ),
          titleLarge: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          titleMedium: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          titleSmall: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          labelLarge: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          bodySmall: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
          labelSmall: GoogleFonts.poppins(
            fontSize: 8,
            fontWeight: FontWeight.w400,
          ),
        )
      ).dark(),
        home: 
        accountService.permissionsGranted.value? (
          isLogin? const HomeScreen() : AuthScreen()
        ):
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Please every permissions to use this application!', style: TextStyle(fontSize: 18),),
              const SizedBox(height: 10,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0
                ),
                onPressed: () => DependencyInjection.requestPermissions(accountService),
                child: const Text('Allow Permissions', style: TextStyle(fontSize: 18),),
              ),
            ],
          )
        ),
      ),
    );
  }
}

