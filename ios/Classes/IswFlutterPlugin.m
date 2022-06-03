#import "IswFlutterPlugin.h"
#if __has_include(<isw_flutter/isw_flutter-Swift.h>)
#import <isw_flutter/isw_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "isw_flutter-Swift.h"
#endif

@implementation IswFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftIswFlutterPlugin registerWithRegistrar:registrar];
}
@end
