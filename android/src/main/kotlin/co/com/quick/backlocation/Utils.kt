package co.com.quick.backlocation

import android.content.Context

internal object Utils {

    private const val KEY_REQUESTING_LOCATION_UPDATES = "requesting_location_updates"
    private const val SHARED_PREFERENCES_FILE = "${BacklocationPlugin.PLUGIN_ID}_preferences"


    fun requestingLocationUpdates(context: Context): Boolean {
        return context.getSharedPreferences(SHARED_PREFERENCES_FILE, Context.MODE_PRIVATE).getBoolean(KEY_REQUESTING_LOCATION_UPDATES, false)
    }


    fun setRequestingLocationUpdates(context: Context, requestingLocationUpdates: Boolean) {
        context.getSharedPreferences(SHARED_PREFERENCES_FILE, Context.MODE_PRIVATE)
                .edit()
                .putBoolean(KEY_REQUESTING_LOCATION_UPDATES, requestingLocationUpdates)
                .apply()
    }

}