import 'package:material_ui/material_ui.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true, //container styling allowed
      colorScheme: ColorScheme.light(
        surface: Color(0xFFFFFFFF), //bg
        surfaceContainer: Color(0xFFF8F9FD), //sidebar and border for uploads
        onSurface: Color(0xFF18171C), //text or symbols
        onSurfaceVariant: Color(0xFF44454a), //subtitles
        secondaryContainer: Color(0xFFd3e3fd), //buttons bg
        secondary: Color.fromARGB(255, 33, 81, 225),
        error: Color(0xFFb00020), //error
        onError: Color(0xFFffffff), //error text
        errorContainer: Color(0xFFfcd8df) //error background
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle( //header
          color: Color(0xFF18171C), 
          fontSize: 20,
          fontFamily: 'GoogleSans',
        ),
        bodyMedium: TextStyle( //upload text titles
          color: Color(0xFF18171C),
          fontSize: 16,
          fontFamily: 'GoogleSans',
        ),
        bodySmall: TextStyle( //subtitles
          color: Color(0xFF44454a),
          fontSize: 14,
          fontFamily: 'GoogleSans',
        ),
      ),
      filledButtonTheme: FilledButtonThemeData( //buttons
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states){
            if (states.contains(WidgetState.pressed)){
              return Color(0xFF435f8f);
            }else{
              return Color(0xFFd3e3fd);
            }
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states){
            if (states.contains(WidgetState.pressed)){
              return Color(0xFFfefefd);
            }else{
              return Color(0xFF18171C);
            }
          })
        )
      )
    );
  }  
}