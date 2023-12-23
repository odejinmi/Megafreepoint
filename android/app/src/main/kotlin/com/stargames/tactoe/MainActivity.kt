package com.stargames.tactoe

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin


import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
//        GeneratedPluginRegistrant.registerWith(flutterEngine)
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine,
            "adFactoryExample", NativeAdFactoryExample(layoutInflater));
    }

    override fun cleanUpFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "adFactoryExample")
    }
}
