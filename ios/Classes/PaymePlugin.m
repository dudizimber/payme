#import "PaymePlugin.h"
#if __has_include(<payme/payme-Swift.h>)
#import <payme/payme-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "payme-Swift.h"
#endif

@implementation PaymePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPaymePlugin registerWithRegistrar:registrar];
}
@end
