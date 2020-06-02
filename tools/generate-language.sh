#!/bin/bash

ORIGIN=/Users/wilseyler/Downloads/pdi-ee-client-9.1.0.0-212/data-integration
DEST=/Users/wilseyler/Desktop/languagePackInstaller/data-integration

HERE=$(pwd)
for locale in "$@"
do
    (
        # Create files missing in the biserver
        # touch  $ORIGIN/pentaho-solutions/system/data-access/resources/messages/messages_supported_languages.properties

        # Generate the bundles
        ./generate_language_bundle.py "$locale" $ORIGIN $DEST/"$locale"
        # ./generate_language_bundle.py "$locale" $ORIGIN/pentaho-solutions/system $DEST/"$locale"/system

        # fix
        rm -rf $DEST/"$locale"/adaptive-execution/lib
        rm -rf $DEST/"$locale"/adaptive-execution/extra/kinesis-plugin-impl-*
        rm -rf $DEST/"$locale"/lib/spring-security-core-*
        rm -rf $DEST/"$locale"/system/karaf/system/com/pentaho/di/plugins/snowflake-staging-vfs-ui
        rm -rf $DEST/"$locale"/system/karaf/system/com/pentaho/di/plugins/pentaho-ee-streaming-amqp-plugin
        # find  $DEST/"$locale"/system/common-ui/ -iname "*.properties" | xargs -I {} sed -i '' 's/messagebundleid=\(.*\)<TRANSLATE ME>/messagebundleid=\1/g' {}
        #
        # rm -rf $DEST/"$locale"/tomcat/webapps/pentaho/js

        # handle metadata
        # if [ ! -f $DEST/"$locale"/metadata.json ]; then
        #     cp $DEST/metadata.json $DEST/"$locale"/
        #     sed -i '' 's/Klingon/@$locale@/g'  $DEST/"$locale"/metadata.json
        #     sed -i '' "s/tlh/$locale/g"  $DEST/"$locale"/metadata.json
        # fi
        # if [ ! -d $DEST/"$locale"/resources ]; then
        #     rsync -uva $DEST/tlh/resources $DEST/"$locale"/
        #     find $DEST/"$locale"/resources -iname "*.properties" |  xargs -I {} sed -i '' 's/Klingon/@$locale@/g' {}
        # fi
        #
        # find $DEST/"$locale" -iname "*.js" | xargs js-beautify -r
        # rm -rf $DEST/"$locale"/system/plugin-cache

        #cd $DEST/
        #zip -r zips/"$locale" "$locale"
        #cd $HERE
    ) &
done
wait
