
Pod::Spec.new do |s|

  s.name         = "XYWLogerManager"
  s.version      = "0.0.1"
  s.summary      = "XYWLogerManager is a loger system base on ddloger "

  s.homepage     = "https://github.com/xueyongwei/XYWLogerManager.git"
 
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "xueyognwei" => "xueyongwei@foxmail.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/xueyongwei/XYWLogerManager.git", :tag => s.version.to_s }

  s.source_files = "XYWLogerManagerDemo/XYWLogerManager/*.{h,m}"
  
  s.dependency 'CocoaLumberjack'

  s.requires_arc = true

end