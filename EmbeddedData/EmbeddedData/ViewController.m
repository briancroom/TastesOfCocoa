#import "ViewController.h"
#import "NSData+EmbeddedData.h"
#import "PKCS12Contents.h"

// A real app would use something more elaborate than a Caesar Cipher for obfuscation
static const char *obfuscatedPassword = "01234";

static inline NSString *plaintextPassword(void) {
    NSMutableString *pass = [NSMutableString string];
    const char *nextCh = obfuscatedPassword;
    while (*nextCh) {
        [pass appendFormat:@"%c", (*nextCh+1)];
        nextCh++;
    }
    return pass;
}

@interface ViewController () <NSURLSessionDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    PKCS12Contents *certContents = [self loadCredentials];

    [self log:@"Got identity:"];
    [self log:CFBridgingRelease(CFCopyDescription(certContents.identity))];
    [self log:@"Got cert:"];
    [self log:CFBridgingRelease(CFCopyDescription(certContents.certificate))];
    [self log:@"Got private key:"];
    [self log:CFBridgingRelease(CFCopyDescription(certContents.privateKey))];
}

- (void)log:(NSString *)message {
    NSString *string = self.textView.text ?: @"";
    self.textView.text = [string stringByAppendingFormat:@"\n%@", message];
}

#pragma mark - Data loading

- (PKCS12Contents *)loadCredentials {
    NSData *certData = [NSData dataWithContentsOfSegment:@"__TEXT" section:@"cert"];
    if (certData) {
        [self log:@"Loaded certificate data"];
    } else {
        [self log:@"Failed to load data"];
        return nil;
    }

    PKCS12Contents *contents = [[PKCS12Contents alloc] initWithPKCS12Data:certData passphrase:plaintextPassword()];
    if (!contents) {
        [self log:@"Unable to import from data"];
    }

    return contents;
}

#pragma mark - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodClientCertificate]) {
        // Load the local identity to respond to the server's authentication challenge
        PKCS12Contents *credentials = [self loadCredentials];
        if (credentials && credentials.identity && credentials.certificate) {
            NSURLCredential *credential = [NSURLCredential credentialWithIdentity:credentials.identity certificates:@[(__bridge id)credentials.certificate] persistence:NSURLCredentialPersistenceForSession];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
    } else {
        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
    }
}

@end
