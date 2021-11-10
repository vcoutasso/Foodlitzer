all: generate open

generate:
	@ echo "\033[1;37mRunning bundle install\033[0m"
	@ bundle config set --local path 'vendor/bundle'
	@ bundle install --quiet --gemfile=App/Gemfile
	@ echo "\033[1;37mGenerating project files and installing dependencies\033[0m"
	@ (cd App; xcodegen -c && pod install --deployment)
	@ echo "\033[1;37mRunning SwiftGen\033[0m"
	@ App/Pods/SwiftGen/bin/swiftgen config run --config config/swiftgen.yml
	@ echo "\033[1;37mAdding generated files to project\033[0m"
	@ (cd App; xcodegen -c && pod install --deployment)

open:
	@ open App/Spider-Verse.xcworkspace

dependencies:
	@ (cd App; pod install)

clean:
	@ echo "\033[1;37mCleaning up project files\033[0m"
	@ rm -rf App/Spider-Verse.xc* App/Podfile.lock App/Pods App/vendor .bundle
	@ find App/Spider-Verse/Resources/Generated ! -name '.gitkeep' -type f -exec rm -f {} +

remake: clean generate open
