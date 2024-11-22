#!/bin/sh
set -e

# Move godot templates already installed from the docker image to home
mkdir -v -p ~/.local/share/godot/export_templates
cp -a /root/.local/share/godot/export_templates/. ~/.local/share/godot/export_templates/


if [ "$3" != "" ]
then
    echo "SubDirectories are no longer supported."
    exit 1
fi

mode="export-release"
if [ "$6" = "true" ]
then
    echo "Exporting in debug mode!"
    mode="export-debug"
fi

# Export for project
echo "Building $1 for $2"
cd "$GITHUB_WORKSPACE/$5"
godot ./project.godot --headless --${mode} "$2"
echo "Build Done"

if [ "$5" != "" ]
then
    BUILD_PATH="$GITHUB_WORKSPACE/$5/build/"
else
    BUILD_PATH="$GITHUB_WORKSPACE/build/"
fi
echo build=$BUILD_PATH >> $GITHUB_OUTPUT


if [ "$4" = "true" ]
then
    echo "Packing Build"
    mkdir -p $GITHUB_WORKSPACE/package
    cd $BUILD_PATH
    zip $GITHUB_WORKSPACE/package/artifact.zip . -r
    echo artifact=package/artifact.zip >> $GITHUB_OUTPUT
    echo "Done"
fi
