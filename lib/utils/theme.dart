import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 14, 98, 150),
      surfaceTint: Color(0xff0e6396),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff98ceff),
      onPrimaryContainer: Color(0xff003b5d),
      secondary: Color(0xff4a6176),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcee6ff),
      onSecondaryContainer: Color(0xff344b5f),
      tertiary: Color(0xff7b4c8c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffecb4fd),
      onTertiaryContainer: Color(0xff502461),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfff8f9fe),
      onBackground: Color(0xff191c1f),
      surface: Color(0xfff8f9fe),
      onSurface: Color(0xff191c1f),
      surfaceVariant: Color(0xffdce3ec),
      onSurfaceVariant: Color(0xff40474f),
      outline: Color(0xff717880),
      outlineVariant: Color(0xffc0c7d0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3134),
      inverseOnSurface: Color(0xffeff1f5),
      inversePrimary: Color(0xff93ccff),
      primaryFixed: Color(0xffcde5ff),
      onPrimaryFixed: Color(0xff001d31),
      primaryFixedDim: Color(0xff93ccff),
      onPrimaryFixedVariant: Color(0xff004b74),
      secondaryFixed: Color(0xffcde5fe),
      onSecondaryFixed: Color(0xff031d30),
      secondaryFixedDim: Color(0xffb1c9e2),
      onSecondaryFixedVariant: Color(0xff32495d),
      tertiaryFixed: Color(0xfff9d8ff),
      onTertiaryFixed: Color(0xff310344),
      tertiaryFixedDim: Color(0xffeab3fb),
      onTertiaryFixedVariant: Color(0xff613472),
      surfaceDim: Color(0xffd8dadf),
      surfaceBright: Color(0xfff8f9fe),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f3f8),
      surfaceContainer: Color(0xffeceef2),
      surfaceContainerHigh: Color(0xffe6e8ed),
      surfaceContainerHighest: Color(0xffe1e2e7),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff00476e),
      surfaceTint: Color(0xff0e6396),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff337aad),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2e4559),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff60778d),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff5d306e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff9362a4),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff8f9fe),
      onBackground: Color(0xff191c1f),
      surface: Color(0xfff8f9fe),
      onSurface: Color(0xff191c1f),
      surfaceVariant: Color(0xffdce3ec),
      onSurfaceVariant: Color(0xff3d444b),
      outline: Color(0xff596068),
      outlineVariant: Color(0xff747b84),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3134),
      inverseOnSurface: Color(0xffeff1f5),
      inversePrimary: Color(0xff93ccff),
      primaryFixed: Color(0xff337aad),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff076193),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff60778d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff485e73),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff9362a4),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff784989),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd8dadf),
      surfaceBright: Color(0xfff8f9fe),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f3f8),
      surfaceContainer: Color(0xffeceef2),
      surfaceContainerHigh: Color(0xffe6e8ed),
      surfaceContainerHighest: Color(0xffe1e2e7),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff00243c),
      surfaceTint: Color(0xff0e6396),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff00476e),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff0b2437),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2e4559),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff390b4b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff5d306e),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff8f9fe),
      onBackground: Color(0xff191c1f),
      surface: Color(0xfff8f9fe),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffdce3ec),
      onSurfaceVariant: Color(0xff1e252b),
      outline: Color(0xff3d444b),
      outlineVariant: Color(0xff3d444b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3134),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffdfeeff),
      primaryFixed: Color(0xff00476e),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff002f4c),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff2e4559),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff172f42),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff5d306e),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff441856),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd8dadf),
      surfaceBright: Color(0xfff8f9fe),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f3f8),
      surfaceContainer: Color(0xffeceef2),
      surfaceContainerHigh: Color.fromARGB(255, 126, 135, 157),
      surfaceContainerHighest: Color(0xffe1e2e7),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffd2e8ff),
      surfaceTint: Color(0xff93ccff),
      onPrimary: Color(0xff003351),
      primaryContainer: Color(0xff80c1f9),
      onPrimaryContainer: Color(0xff00314e),
      secondary: Color(0xffb1c9e2),
      onSecondary: Color(0xff1b3246),
      secondaryContainer: Color(0xff2b4155),
      onSecondaryContainer: Color(0xffbfd7ef),
      tertiary: Color(0xfffadcff),
      onTertiary: Color(0xff491c5a),
      tertiaryContainer: Color(0xffdfa8f0),
      onTertiaryContainer: Color(0xff461a58),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff111417),
      onBackground: Color(0xffe1e2e7),
      surface: Color(0xff111417),
      onSurface: Color(0xffe1e2e7),
      surfaceVariant: Color(0xff40474f),
      onSurfaceVariant: Color(0xffc0c7d0),
      outline: Color(0xff8a919a),
      outlineVariant: Color(0xff40474f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e2e7),
      inverseOnSurface: Color(0xff2e3134),
      inversePrimary: Color(0xff0e6396),
      primaryFixed: Color(0xffcde5ff),
      onPrimaryFixed: Color(0xff001d31),
      primaryFixedDim: Color(0xff93ccff),
      onPrimaryFixedVariant: Color(0xff004b74),
      secondaryFixed: Color(0xffcde5fe),
      onSecondaryFixed: Color(0xff031d30),
      secondaryFixedDim: Color(0xffb1c9e2),
      onSecondaryFixedVariant: Color(0xff32495d),
      tertiaryFixed: Color(0xfff9d8ff),
      onTertiaryFixed: Color(0xff310344),
      tertiaryFixedDim: Color(0xffeab3fb),
      onTertiaryFixedVariant: Color(0xff613472),
      surfaceDim: Color(0xff111417),
      surfaceBright: Color(0xff36393d),
      surfaceContainerLowest: Color(0xff0b0e12),
      surfaceContainerLow: Color(0xff191c1f),
      surfaceContainer: Color(0xff1d2023),
      surfaceContainerHigh: Color(0xff272a2e),
      surfaceContainerHighest: Color(0xff323539),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffd2e8ff),
      surfaceTint: Color(0xff93ccff),
      onPrimary: Color(0xff002e4a),
      primaryContainer: Color(0xff80c1f9),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffb6cde6),
      onSecondary: Color(0xff001829),
      secondaryContainer: Color(0xff7c93aa),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffadcff),
      onTertiary: Color(0xff441755),
      tertiaryContainer: Color(0xffdfa8f0),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff111417),
      onBackground: Color(0xffe1e2e7),
      surface: Color(0xff111417),
      onSurface: Color(0xfff9fbff),
      surfaceVariant: Color(0xff40474f),
      onSurfaceVariant: Color(0xffc5cbd4),
      outline: Color(0xff9da3ac),
      outlineVariant: Color(0xff7d848c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e2e7),
      inverseOnSurface: Color(0xff272a2e),
      inversePrimary: Color(0xff004c75),
      primaryFixed: Color(0xffcde5ff),
      onPrimaryFixed: Color(0xff001322),
      primaryFixedDim: Color(0xff93ccff),
      onPrimaryFixedVariant: Color(0xff00395a),
      secondaryFixed: Color(0xffcde5fe),
      onSecondaryFixed: Color(0xff001322),
      secondaryFixedDim: Color(0xffb1c9e2),
      onSecondaryFixedVariant: Color(0xff21384c),
      tertiaryFixed: Color(0xfff9d8ff),
      onTertiaryFixed: Color(0xff220031),
      tertiaryFixedDim: Color(0xffeab3fb),
      onTertiaryFixedVariant: Color(0xff4f2360),
      surfaceDim: Color(0xff111417),
      surfaceBright: Color(0xff36393d),
      surfaceContainerLowest: Color(0xff0b0e12),
      surfaceContainerLow: Color(0xff191c1f),
      surfaceContainer: Color(0xff1d2023),
      surfaceContainerHigh: Color(0xff272a2e),
      surfaceContainerHighest: Color(0xff323539),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff9fbff),
      surfaceTint: Color(0xff93ccff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff9cd0ff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff9fbff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb6cde6),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffff9fa),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffeeb7ff),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff111417),
      onBackground: Color(0xffe1e2e7),
      surface: Color(0xff111417),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff40474f),
      onSurfaceVariant: Color(0xfff9fbff),
      outline: Color(0xffc5cbd4),
      outlineVariant: Color(0xffc5cbd4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e2e7),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff002d48),
      primaryFixed: Color(0xffd5e9ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff9cd0ff),
      onPrimaryFixedVariant: Color(0xff001829),
      secondaryFixed: Color(0xffd5e9ff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb6cde6),
      onSecondaryFixedVariant: Color(0xff001829),
      tertiaryFixed: Color(0xfffadeff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffeeb7ff),
      onTertiaryFixedVariant: Color(0xff2a003b),
      surfaceDim: Color(0xff111417),
      surfaceBright: Color(0xff36393d),
      surfaceContainerLowest: Color(0xff0b0e12),
      surfaceContainerLow: Color(0xff191c1f),
      surfaceContainer: Color(0xff1d2023),
      surfaceContainerHigh: Color(0xff272a2e),
      surfaceContainerHighest: Color(0xff323539),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary, 
    required this.surfaceTint, 
    required this.onPrimary, 
    required this.primaryContainer, 
    required this.onPrimaryContainer, 
    required this.secondary, 
    required this.onSecondary, 
    required this.secondaryContainer, 
    required this.onSecondaryContainer, 
    required this.tertiary, 
    required this.onTertiary, 
    required this.tertiaryContainer, 
    required this.onTertiaryContainer, 
    required this.error, 
    required this.onError, 
    required this.errorContainer, 
    required this.onErrorContainer, 
    required this.background, 
    required this.onBackground, 
    required this.surface, 
    required this.onSurface, 
    required this.surfaceVariant, 
    required this.onSurfaceVariant, 
    required this.outline, 
    required this.outlineVariant, 
    required this.shadow, 
    required this.scrim, 
    required this.inverseSurface, 
    required this.inverseOnSurface, 
    required this.inversePrimary, 
    required this.primaryFixed, 
    required this.onPrimaryFixed, 
    required this.primaryFixedDim, 
    required this.onPrimaryFixedVariant, 
    required this.secondaryFixed, 
    required this.onSecondaryFixed, 
    required this.secondaryFixedDim, 
    required this.onSecondaryFixedVariant, 
    required this.tertiaryFixed, 
    required this.onTertiaryFixed, 
    required this.tertiaryFixedDim, 
    required this.onTertiaryFixedVariant, 
    required this.surfaceDim, 
    required this.surfaceBright, 
    required this.surfaceContainerLowest, 
    required this.surfaceContainerLow, 
    required this.surfaceContainer, 
    required this.surfaceContainerHigh, 
    required this.surfaceContainerHighest, 
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      surfaceContainerHighest: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
