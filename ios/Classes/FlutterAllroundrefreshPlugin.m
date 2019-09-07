#import "FlutterAllroundrefreshPlugin.h"
#import <flutter_allroundrefresh/flutter_allroundrefresh-Swift.h>

@implementation FlutterAllroundrefreshPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterAllroundrefreshPlugin registerWithRegistrar:registrar];
}
@end
