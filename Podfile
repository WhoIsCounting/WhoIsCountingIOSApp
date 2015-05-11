source 'https://github.com/CocoaPods/Specs.git'

xcodeproj 'consumer.xcodeproj'
platform :ios, '8.0'
use_frameworks!

pod 'AeroGearHttp'
pod 'AeroGearOAuth2'
pod 'SwiftyJSON'

# due to swift compiler bug, disable the '-Fastest' optimization flag
# for the 'AeroGearOAuth2' library
unoptimized_pod_names = ['AeroGearAuth2']

post_install do |installer_representation|
targets = installer_representation.project.targets.select { |target|
unoptimized_pod_names.select { |name|
target.display_name.end_with? name
}.count > 0
}
targets.each do |target|
target.build_configurations.each do |config|
config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
end
end
end
