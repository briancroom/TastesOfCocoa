#import "PKCS12Contents.h"

@implementation PKCS12Contents

- (instancetype)initWithPKCS12Data:(NSData *)data passphrase:(NSString *)passphrase {
    if (self = [super init]) {
        CFArrayRef items = NULL;
        OSStatus result = SecPKCS12Import((__bridge CFDataRef)data,
                                          (__bridge CFDictionaryRef)@{ (__bridge NSString *)kSecImportExportPassphrase: passphrase },
                                          &items);
        if (result != errSecSuccess) { return nil; }

        NSDictionary *contents = [(__bridge NSArray *)items firstObject];
        _identity = (__bridge_retained SecIdentityRef)contents[(__bridge NSString *)kSecImportItemIdentity];

        SecCertificateRef certificate = NULL;
        if (SecIdentityCopyCertificate(_identity, &certificate) == errSecSuccess) {
            _certificate = certificate;
        }

        SecKeyRef privateKey = NULL;
        if (SecIdentityCopyPrivateKey(_identity, &privateKey) == errSecSuccess) {
            _privateKey = privateKey;
        }
    }
    return self;
}

- (void)dealloc {
    if (_identity) { CFRelease(_identity); }
    if (_certificate) { CFRelease(_certificate); }
    if (_privateKey) { CFRelease(_privateKey); }
}

@end
