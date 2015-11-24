#import <Foundation/Foundation.h>

@interface PKCS12Contents : NSObject

@property (nonatomic) SecIdentityRef identity;
@property (nonatomic) SecCertificateRef certificate;
@property (nonatomic) SecKeyRef privateKey;

- (instancetype)initWithPKCS12Data:(NSData *)data passphrase:(NSString *)passphrase;

@end
