Pod::Spec.new do |s|
  s.name     = 'Cleanse'
  s.version  = '0.1.0'
  s.license  = 'Apache License, Version 2.0'
  s.summary  = 'Lightweight Swift Dependency Injection Framework'
  s.homepage = 'https://github.com/square/Cleanse'
  s.authors  = 'Square'
  s.source   = { :git => 'https://github.com/square/Cleanse.git', :tag => s.version }
  s.source_files = 'Cleanse/*.swift'
  s.ios.deployment_target = '8.1'
  s.osx.deployment_target = '10.10'
end
