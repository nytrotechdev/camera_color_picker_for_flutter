#import "ColorPickerCameraPlugin.h"
#if __has_include(<color_picker_camera/color_picker_camera-Swift.h>)
#import <color_picker_camera/color_picker_camera-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "color_picker_camera-Swift.h"
#endif

@implementation ColorPickerCameraPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftColorPickerCameraPlugin registerWithRegistrar:registrar];
}
@end
