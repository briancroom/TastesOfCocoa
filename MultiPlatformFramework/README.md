# MultiPlatformFramework

When publishing a library for Apple platforms, there are now **four** (Mac, iOS, watchOS, tvOS) platforms which you may want to support. The question becomes how to setup your Xcode project to support each platform without too much maintenance overhead due to having a large number of targets.

The naïve approach is to create a separate static library and/or dynamic framework target for each platform (e.g. `MyLib-OSX`, `MyLib-iOS`, `MyLib-watchOS`, `MyLib-tvOS`), however it would be preferable to be able to share a single target.

It turns out that it is generally possible to do so (with some possible caveats), as illustrated by this project. Here you will find a `MultiPlatformFramework` target which is consumed by example apps on each platform. The primary build setting that needs to be changed from the default is `Support Platforms`. By default this is configured to values that specify a single platform, however it is possible to use the `Other...` option and manually add entries for each platform. The full value used in this example is:
```
iphonesimulator iphoneos macosx appletvsimulator appletvos watchsimulator watchos
```
