use_frameworks!

# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

def app
  pod 'NetworkUtilsKit'
  pod 'UtilsKit'
  pod 'SDWebImage'
  pod 'CoreDataUtilsKit'
  pod 'netfox'
  
  # Firebase
  pod 'FirebaseCore'
  pod 'FirebaseDatabase'
  pod 'FirebaseAuth'
  pod 'FirebaseAnalytics'
  pod 'FirebaseCrashlytics'
end

target 'FosterAppTests' do
  app
end

target 'FosterApp' do
  app
end


post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			
			if config.base_configuration_reference.is_a? Xcodeproj::Project::Object::PBXFileReference
				xcconfig_path = config.base_configuration_reference.real_path
				IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
			end
		end
	end
end
