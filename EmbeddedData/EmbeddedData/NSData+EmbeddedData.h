#import <Foundation/Foundation.h>

@interface NSData (EmbeddedData)

/// Load data that is embedded in your Mach-O binary, by its segment and section name. e.g.:
/// @code NSData *data = [NSData dataWithContentsOfSegment:@"__TEXT" section:@"__info_plist"];
+ (instancetype)dataWithContentsOfSegment:(NSString *)segmentName section:(NSString *)sectionName;

@end
