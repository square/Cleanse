Pod::Spec.new do |s|
  s.name     = 'Cleanse'
  s.version  = '4.1.2'
  s.license  = 'Apache License, Version 2.0'
  s.summary  = 'Lightweight Swift Dependency Injection Framework'
  s.homepage = 'https://github.com/square/Cleanse'
  s.authors  = 'Square'
  s.source   = { :git => 'https://github.com/square/Cleanse.git', :tag => s.version }
  s.source_files = 'Cleanse/*.swift'
  s.ios.deployment_target = '8.3'
end
