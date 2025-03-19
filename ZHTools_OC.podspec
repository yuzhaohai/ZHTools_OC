Pod::Spec.new do |s|
  s.name         = 'ZHTools_OC'
  s.summary      = 'Fast Fast Fast'
  s.version      = '0.0.3'
  s.license      = { :type => 'MIT' }
  s.authors      = { "born2try" => "yuzhaohai@126.com" }
  s.homepage     = 'https://github.com/yuzhaohai/ZHTools_OC'

  s.ios.deployment_target = '12.0'

  s.source       = { :git => 'https://github.com/yuzhaohai/ZHTools_OC.git', :tag => s.version.to_s }
  
  s.requires_arc = true
  s.source_files = 'ZHTools_OC/*.{h,m}'
  s.public_header_files = 'ZHTools_OC/*.{h}'
  
  s.frameworks = 'UIKit','Foundation'

end