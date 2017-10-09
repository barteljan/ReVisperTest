# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'WhoIsRight' do
    
    use_frameworks!
    pod 'ReactiveReSwift'
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'VISPER'
    pod 'PureLayout'

    target 'WhoIsRightTests' do
        inherit! :search_paths
    end

    post_install do |installer|
        installer.pods_project.targets.each do |target|
            swift3Pods = ['RxSwift','RxCocoa','ReactiveReSwift']
            
            if swift3Pods.include? target.name
                target.build_configurations.each do |config|
                    config.build_settings['SWIFT_VERSION'] = '3.2'
                end
                else
                target.build_configurations.each do |config|
                    config.build_settings['SWIFT_VERSION'] = '4.0'
                end
            end
        end
    end

end
