#include <Cocoa/Cocoa.h>
#include <CoreGraphics/CGWindow.h>
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {

  @autoreleasepool {
    NSString *owner = argv[1] ? [NSString stringWithUTF8String:argv[1]] : @"*";
    NSString *name = argv[2] ? [NSString stringWithUTF8String:argv[2]] : @"*";
    NSArray *windows = (NSArray *)CFBridgingRelease(CGWindowListCopyWindowInfo(kCGWindowListExcludeDesktopElements,kCGNullWindowID));

    for(NSDictionary *window in windows)
    {
      NSString *windowOwnerName = [window objectForKey:(NSString *)kCGWindowOwnerName];
      NSString *windowName = [window objectForKey:(NSString *)kCGWindowName];
      int windowID = [[window objectForKey:(NSString *)kCGWindowNumber] intValue];

      if (![owner isEqualToString:@"*"] && ![windowOwnerName isEqualToString:owner])
        continue;

      if ((![name isEqualToString:@"*"] && ![windowName isEqualToString:name]) || [windowName isEqualToString:@""] || windowName == nil)
        continue;

      if ([owner isEqualToString:@"*"])
        printf("%s\t", [windowOwnerName UTF8String]);

      if ([name isEqualToString:@"*"])
        printf("%s\t", [windowName UTF8String]);

      printf("%d\n", windowID);
    }
  }

  return 0;
}
