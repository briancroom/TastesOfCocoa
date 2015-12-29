#import <Cedar/Cedar.h>

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ObjCSpec)

describe(@"An Objective-C spec", ^{
    it(@"should run examples", ^{
        1 should equal(1);
    });
});

SPEC_END
