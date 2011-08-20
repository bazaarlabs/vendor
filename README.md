# Vendor – an iOS library management system #

Vendor makes the process of using and managing libraries in iOS easy.  Vendor leverages the XCode Workspaces feature introduced with XCode 4 and is modeled after Bundler. Vendor streamlines the installation and update process for dependent libraries.  It also tracks versions and manages dependencies between libraries.

## Step 1) Specify dependencies ##

Specify your dependencies in a Vendors file in your project’s root.

    source "https://github.com/bazaarlabs/vendor"

    lib "facebook-ios-sdk"  # Formula specified at source above
    lib "three20"
    lib "asi-http-request", :git => "https://github.com/pokeb/asi-http-request.git"
    lib "JSONKit", :git => "https://github.com/johnezang/JSONKit.git"

## Step 2) Install dependencies ##

    vendor install
    git add Vendors.lock

Installing a vendor library gets the latest version of the code, and adds the XCode project to the workspace.  As part of the installation process, the library is set up as a dependency of the main project, header search paths are modified, and required frameworks are added.  The installed version of the library is captured in the Vendors.lock file.

After a fresh check out of a project from source control, the XCode workspace may contain links to projects that don’t exist in the file system because vendor projects are not checked into source control. Run `vendor install` to restore the vendor projects.

## Other commands ##

    # Updating all dependencies will update all libraries to their latest versions.
    vendor update
    # Specifying the dependency will cause only the single library to be updated.
    vendor update facebook-ios-sdk

## Adding a library formula ##

If a library has no framework dependencies, has no required additional compiler/linker flags, and has an XCode project, it doesn’t require a Vendor formula. An example is JSONKit, which may be specified as below. However, if another Vendor library requires JSONKit, JSONKit must have a Vendor formula.

    lib "JSONKit", :git => "https://github.com/johnezang/JSONKit.git"

However, if the library requires frameworks or has dependencies on other Vendor libraries, it must have a Vendor formula.  As with Brew, a Vendor formula is some declarative Ruby code that is open source and centrally managed.

An example Vendor formula might look like:

    require 'formula'

    class Three20 < Formula
      url "https://github.com/facebook/three20"
      libraries libThree20.a
      frameworks "CoreAnimation"
      header_path "three20/Build/Products/three20"
      linker_flags "ObjC", "all_load"
      vendors "JSONKit"
    end