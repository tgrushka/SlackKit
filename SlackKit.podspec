Pod::Spec.new do |s|
  s.name                    = "SlackKit"
  s.version                 = "4.2.0"
  s.summary                 = "Write Slack apps in Swift"
  s.homepage                = "https://github.com/pvzig/SlackKit"
  s.license                 = "MIT"
  s.author                  = { "Peter Zignego" => "peter@launchsoft.co" }
  s.source                  = { :git => "https://github.com/pvzig/SlackKit.git", :tag => s.version.to_s }
  s.social_media_url        = "https://twitter.com/pvzig"
  s.ios.deployment_target   = "10.0"
  s.osx.deployment_target   = "10.11"
  s.tvos.deployment_target  = "10.0"
  s.default_subspec         = "SlackKit"
  s.swift_version           = "4.2"
  s.cocoapods_version       = ">= 1.4.0"

  s.subspec "SlackKit" do |ss|
    ss.source_files = "SlackKit/Sources"
    ss.dependency "SlackKit/SKClient"
    ss.dependency "SlackKit/SKCore"
    ss.dependency "SlackKit/SKRTMAPI"
    ss.dependency "SlackKit/SKServer"
    ss.dependency "SlackKit/SKWebAPI"
    ss.framework = "Foundation"
  end

  s.subspec "SKCore" do |ss|
    ss.source_files = "SKCore/Sources"
  end

  s.subspec "SKClient" do |ss|
    ss.source_files = "SKClient/Sources"
    ss.dependency "SlackKit/SKCore"
  end

  s.subspec "SKRTMAPI" do |ss|
    ss.source_files = "SKRTMAPI/Sources"
    ss.dependency "SlackKit/SKCore"
    ss.dependency "SlackKit/SKWebAPI"
    ss.dependency "Starscream", "3.0.6"
  end

  s.subspec "SKServer" do |ss|
    ss.source_files = "SKServer/Sources"
    ss.dependency "SlackKit/SKCore"
    ss.dependency "SlackKit/SKWebAPI"
    ss.dependency "Swifter", "1.4.5"
  end

  s.subspec "SKWebAPI" do |ss|
    ss.source_files = "SKWebAPI/Sources"
    ss.dependency "SlackKit/SKCore"
  end
end