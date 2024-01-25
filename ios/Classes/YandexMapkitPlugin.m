#import "YandexMapkitPlugin.h"
#import <yandex_mapkit_lite/yandex_mapkit_lite-Swift.h>

@implementation YandexMapkitPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftYandexMapkitPlugin registerWithRegistrar:registrar];
}
@end
