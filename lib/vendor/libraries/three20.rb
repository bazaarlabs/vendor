require 'vendor/library' unless defined?(Vendor::Library)

class Three20 < Vendor::Library
  source "https://github.com/facebook/three20.git"
  libraries 'libThree20.a'
  frameworks "CoreAnimation"
  header_path "three20/Build/Products/three20"
  linker_flags "ObjC", "all_load"
  vendors "JSONKit"
end
