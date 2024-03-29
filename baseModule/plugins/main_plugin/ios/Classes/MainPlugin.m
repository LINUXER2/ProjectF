#import "MainPlugin.h"
#if __has_include(<main_plugin/main_plugin-Swift.h>)
#import <main_plugin/main_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "main_plugin-Swift.h"
#endif

@implementation MainPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMainPlugin registerWithRegistrar:registrar];
}
@end
