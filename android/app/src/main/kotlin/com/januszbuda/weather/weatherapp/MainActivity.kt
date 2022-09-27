package com.januszbuda.weather.weatherapp

import android.annotation.SuppressLint
import android.os.Bundle
import android.util.Log
import android.view.ViewGroup
import android.webkit.WebView
import android.widget.Button
import android.widget.LinearLayout
import android.widget.RelativeLayout

import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.StringCodec
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "webview"

    @SuppressLint("SetJavaScriptEnabled", "SetTextI18n")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val buttonParams = RelativeLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.WRAP_CONTENT
        )

        buttonParams.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM)

        val button = Button(this)
        button.text = "Close WebView"
        button.layoutParams = buttonParams

        button.setOnClickListener {
            finish()
        }

        val webViewParams = RelativeLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT
        )

        webViewParams.addRule(RelativeLayout.ABOVE, button.id)

        val webView = WebView(this)
        webView.settings.javaScriptEnabled = true
        webView.layoutParams = webViewParams

        val layout = RelativeLayout(this)
        layout.addView(webView)
        layout.addView(button)

        provideFlutterEngine(this)?.let { GeneratedPluginRegistrant.registerWith(it) }
        MethodChannel(flutterEngine?.dartExecutor,CHANNEL).setMethodCallHandler(
                object : MethodCallHandler {
                    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
                        if (call.method.equals("startNativeView")) {

                            call.argument<String>("url")?.let {
                                webView.loadUrl(it)
                            }

                            setContentView(layout)
                        }
                    }
                }
        )
    }
}
