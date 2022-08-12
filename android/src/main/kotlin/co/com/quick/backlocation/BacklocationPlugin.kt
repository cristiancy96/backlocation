package co.com.quick.backlocation

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** BacklocationPlugin */
class BacklocationPlugin: FlutterPlugin, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  companion object {

      /**
      Legacy for v1 embedding
        */
      @SuppressWarnings("deprecation")
      fun registerWith(registrar: PluginRegistry.Registrar) {
          val service = BackgroundLocationService.getInstance()
          service.onAttachedToEngine(registrar.context(), registrar.messenger())
          registrar.addRequestPermissionsResultListener(service)
      }

      const val TAG = "com.almoullim.Log.Tag"
      const val PLUGIN_ID = "com.almoullim.background_location"
  }
  
  override fun onAttachedToEngine(binding: FlutterPluginBinding) {
      BacklocationService.getInstance().onAttachedToEngine(binding.applicationContext, binding.binaryMessenger)
  }

  override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
      BacklocationService.getInstance().onDetachedFromEngine()
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
      val service = BacklocationService.getInstance()
      service.setActivity(binding)
      binding.addRequestPermissionsResultListener(service)
  }

  override fun onDetachedFromActivityForConfigChanges() {
      this.onDetachedFromActivity()
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
      this.onAttachedToActivity(binding)
  }

  override fun onDetachedFromActivity() {
      BacklocationService.getInstance().setActivity(null)
  }
}
