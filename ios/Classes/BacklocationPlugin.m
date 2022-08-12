#import "BacklocationPlugin.h"
#if __has_include(<backlocation/backlocation-Swift.h>)
#import <backlocation/backlocation-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "backlocation-Swift.h"
#endif

@implementation BacklocationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBacklocationPlugin registerWithRegistrar:registrar];
}
@end
