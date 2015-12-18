Pod::Spec.new do |s|

  s.name         = "CrutchKit"
  s.version      = "0.0.8"
  s.summary      = "CrutchKit is a set of crutches for IOS development."
  s.homepage     = "https://github.com/CognitiveDisson/CrutchKit"
  s.license      = "MIT"
  s.author       = { "Vadim Smal" => "cognitivedisson@gmail.com" }
  s.requires_arc = true
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/CognitiveDisson/CrutchKit.git", :tag => s.version.to_s }
  s.header_mappings_dir  = "Classes"

  s.subspec 'Proxying' do |pr|
    pr.header_mappings_dir = "Classes/Proxying"
    pr.source_files = "Classes/Proxying/**/*.{h,m}"
    pr.dependency 'CrutchKit/Runtime'
  end

  s.subspec 'Runtime' do |rn|
    rn.header_mappings_dir = "Classes/Runtime"
    rn.source_files = "Classes/Runtime/**/*.{h,m}"
  end

  s.subspec 'Helpers' do |hlp|
    hlp.header_mappings_dir = "Classes/Helpers"
    hlp.source_files = "Classes/Helpers/**/*.{h,m}"
  end

  s.subspec 'AnimationHandling' do |an|
    an.source_files = "Classes/AnimationHandling/**/*.{h,m}"
    an.dependency 'CrutchKit/Helpers'
  end

  s.subspec 'Debug' do |dbg|
    dbg.source_files = "Classes/Debug/**/*.{h,m}"
  end

end
