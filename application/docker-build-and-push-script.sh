#Extract version
VERSION_FILE='version.txt'
current_version=$(cat "$VERSION_FILE")
#Increment version
new_version=$((current_version+1))
echo $new_version >> VERSION_FILE


# Build Jar
./gradlew clean bootJar -P version=test-$new_version --parallel
cd build/libs
java -Djarmode=tools -jar *.jar  extract --layers --launcher --destination extracted
#Docker build
docker build -t test-app-$new_version --platform=linux/amd64 ../../

