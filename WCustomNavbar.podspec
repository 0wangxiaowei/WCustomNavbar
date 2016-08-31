#
#  Be sure to run `pod spec lint WCustomNavbar.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "WCustomNavbar"
  s.version      = "0.0.1"
  s.license  = "MIT"  //开源协议
  s.summary  = 'This is a countdown button' //简单的描述 
  s.homepage = 'https://github.com/0wangxiaowei/WCustomNavbar' //主页
  s.author   = { 'Xiaowei Wang' => '2456897876@qq.com' } //作者
  s.source   = { :git => 'https://github.com/0wangxiaowei/WCustomNavbar.git', :tag => "1.0" } //git路径、指定tag号
  s.platform = :ios 
  s.source_files = 'WCustomNavbar/*'  //库的源代码文件
  s.framework = 'UIKit'  //依赖的framework
  s.requires_arc = true

end
