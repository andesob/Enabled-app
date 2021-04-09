package io.flutter.plugins;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry;

/**
 * Generated file. Do not edit.
 * This file is generated by the Flutter tool based on the
 * plugins that support the Android platform.
 */
@Keep
public final class GeneratedPluginRegistrant {
  public static void registerWith(@NonNull FlutterEngine flutterEngine) {
    ShimPluginRegistry shimPluginRegistry = new ShimPluginRegistry(flutterEngine);
      com.yanisalfian.flutterphonedirectcaller.FlutterPhoneDirectCallerPlugin.registerWith(shimPluginRegistry.registrarFor("com.yanisalfian.flutterphonedirectcaller.FlutterPhoneDirectCallerPlugin"));
    flutterEngine.getPlugins().add(new com.tundralabs.fluttertts.FlutterTtsPlugin());
    flutterEngine.getPlugins().add(new dev.flutter.plugins.integration_test.IntegrationTestPlugin());
    flutterEngine.getPlugins().add(new io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin());
    flutterEngine.getPlugins().add(new io.flutter.plugins.urllauncher.UrlLauncherPlugin());
      com.ly.wifi.WifiPlugin.registerWith(shimPluginRegistry.registrarFor("com.ly.wifi.WifiPlugin"));
  }
}
