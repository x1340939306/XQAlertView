Pod::Spec.new do |s|
  s.name = "XQAlertView"
  s.version = "1.0.2"
  s.summary = "UIAlertView\u{ff0c}UIActionSheet\u{ff0c}UIAlertController\u{5c01}\u{88c5}\u{5904}\u{7406}"
  s.license = "MIT"
  s.authors = {"x1340939306"=>"xuqiangjob@163.com"}
  s.homepage = "https://github.com/x1340939306/XQAlertView"
  s.description = "UIAlertView\u{ff0c}UIActionSheet\u{ff0c}UIAlertController\u{5c01}\u{88c5}\u{ff0c}\u{4e00}\u{53e5}\u{4ee3}\u{7801}\u{5373}\u{53ef}\u{ff0c}iOS\u{4efb}\u{4f55}\u{7cfb}\u{7edf}\u{90fd}\u{53ef}\u{4ee5}\u{4f7f}\u{7528}"
  s.requires_arc = true
  s.source = { :path => '.' }

  s.ios.deployment_target    = '6.0'
  s.ios.vendored_framework   = 'ios/XQAlertView.framework'
end
