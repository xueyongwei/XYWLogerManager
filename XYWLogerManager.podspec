Pod::Spec.new do |spec|
  spec.name         = 'XYWLogerManager'
  spec.version      = '0.0.1'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/xueyongwei/XYWLogerManager.git'
  spec.authors      = { 'xueyognwei" => "xueyongwei@foxmail.com' }
  spec.summary      = 'XYWLogerManager is a loger system base on ddloger .'
  spec.source       = { :git => 'https://github.com/xueyongwei/XYWLogerManager.git', :tag => '0.0.1' }
  spec.source_files = 'HYFileManager/*.{h,m}'
  spec.platform     = :ios, '8.0'
  spec.framework    = 'Foundation', 'UIKit'
  spec.requires_arc = true
end
