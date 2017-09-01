Pod::Spec.new do |s|
  s.name         = 'PredictionBuilder'
  s.version      = '1.0.1'
  s.homepage     = 'https://github.com/denissimon/prediction-builder-swift'
  s.authors      = {
    'Denis Simon' => 'denis.v.simon@gmail.com'
  }
  s.summary      = 'A library for machine learning that builds predictions using a linear regression.'
  s.license      = { :type => 'MIT' }

  s.source       =  {
    :git => 'https://github.com/denissimon/prediction-builder-swift.git',
    :tag => 'v'+s.version.to_s
  }
  s.source_files = 'Sources/PredictionBuilder.swift'

  s.requires_arc = true
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
end
