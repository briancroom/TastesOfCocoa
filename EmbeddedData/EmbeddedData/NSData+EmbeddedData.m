#import "NSData+EmbeddedData.h"
#include <mach-o/getsect.h>
#include <mach-o/ldsyms.h>

@implementation NSData (EmbeddedData)

+ (instancetype)dataWithContentsOfSegment:(NSString *)segmentName section:(NSString *)sectionName {
    unsigned long size;
    void *ptr = getsectiondata(&_mh_execute_header, [segmentName UTF8String], [sectionName UTF8String], &size);
    return [NSData dataWithBytesNoCopy:ptr length:size freeWhenDone:NO];
}

@end
