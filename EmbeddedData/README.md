# EmbeddedData

Demonstration of using Xcode to embed arbitrary binary data within a Mach-O executable, and then retrieving it again.

The example data in this case is a `.p12` identity file, containing a certificate and private key. *Note that this key is not secure* because it has been published to a public repo.

Also included is an example implementation of  `-URLSession:didReceiveChallenge:completionHandler:` showing how you could respond to a `NSURLAuthenticationMethodClientCertificate` challenge when opening a secure server connection using `NSURLSession` when the server requires the client to identify itself.