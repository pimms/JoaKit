Pod::Spec.new do |s|
  s.name         = 'JoaKit'
  s.version      = '0.1'
  s.summary      = "Joakim's Toolkit"
  s.author       = 'Joakim Stien'

  s.platform      = :ios, '13.0'
  s.swift_version = '5.1'
  s.source        = { :git => "https://github.com/pimms/JoaKit.git", :tag => s.version }
  s.requires_arc  = true

  s.source_files = 'JoaKit/*.{h,m,swift}', 'JoaKit/**/*.{h,m,swift}', 'JoaKit/**/**/*.{h,m,swift}'
  s.resource_bundles = {
      'FinniversKit' => ['JoaKit/Resources/*.xcassets' ]
  }
  s.frameworks = 'Foundation', 'UIKit'
end
