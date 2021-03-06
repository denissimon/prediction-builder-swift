Pod::Spec.new do |s|
  s.name         = 'PredictionBuilder'
  s.version      = '1.2.0'
  s.homepage     = 'https://github.com/denissimon/prediction-builder-swift'
  s.authors      = { 'Denis Simon' => 'denis.v.simon@gmail.com' }
  s.summary      = 'A library for machine learning that builds predictions using a linear regression'
  s.license      = { :type => 'MIT' }

  s.swift_versions = ['5.0', '5.1']
  s.ios.deployment_target = "9.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "3.0"
  s.tvos.deployment_target = "10.0"
  s.source       =  { :git => 'https://github.com/denissimon/prediction-builder-swift.git', :tag => 'v'+s.version.to_s }
  s.source_files = 'Sources/**/*.swift'
  s.frameworks  = "Foundation"
end
