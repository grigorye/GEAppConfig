Pod::Spec.new do |s|

  s.name = "GEAppConfig"
  s.version = "0.0.1"
  s.summary = "Application configuration related stuff"

  s.description  = <<~END
    A few components shared between applications, related to the configuration.
  END

  s.homepage = "https://github.com/grigorye/GEAppConfig"
  s.license = 'MIT'
  s.author = { "Grigory Entin" => "grigory.entin@gmail.com" }

  s.ios.deployment_target = '11.0'
  # s.osx.deployment_target = '10.10'
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.source = { :git => "https://github.com/grigorye/GEAppConfig.git", :tag => "#{s.version}" }
  
  s.swift_version = "4.0"

  s.source_files  = "GEAppConfig/*.swift"

  s.dependency 'GEDebugKit'
  s.dependency 'GEUIKit'
  s.dependency 'GEFoundation'
  s.dependency 'GETracing'

  s.dependency 'FTLinearActivityIndicator'
  s.dependency 'JGProgressHUD'
  s.dependency 'Watchdog'

end
