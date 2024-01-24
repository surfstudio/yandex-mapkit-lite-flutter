#import "YandexMapkitPlugin.h"
#import <yandex_mapkit_lite/yandex_mapkit-Swift.h>

@implementation YandexMapkitPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftYandexMapkitPlugin registerWithRegistrar:registrar];
}
@end
