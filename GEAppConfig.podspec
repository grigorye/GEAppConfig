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
  s.osx.deployment_target = '10.13'
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.source = { :git => "https://github.com/grigorye/GEAppConfig.git", :tag => "#{s.version}" }
  
  s.swift_version = "4.0"

  s.ios.source_files = "GEAppConfig/iOS/*.swift", "GEAppConfig/Shared/*.swift"
  s.osx.source_files = "GEAppConfig/macOS/*.swift", "GEAppConfig/Shared/*.swift"
  s.source_files = "GEAppConfig/Shared/*.swift"

  s.ios.dependency 'GEDebugKit'
  s.ios.dependency 'GEUIKit'
  s.dependency 'GECoreData'
  s.dependency 'GEFoundation'
  s.dependency 'GETracing'

  s.ios.dependency 'FTLinearActivityIndicator'
  s.ios.dependency 'JGProgressHUD'
  s.ios.dependency 'Watchdog'

end
