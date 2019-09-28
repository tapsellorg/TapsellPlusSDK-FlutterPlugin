#import "TapsellPlusPlugin.h"
#import <tapsell_plus/tapsell_plus-Swift.h>

@implementation TapsellPlusPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTapsellPlusPlugin registerWithRegistrar:registrar];
}
@end
