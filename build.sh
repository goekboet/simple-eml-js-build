#!/bin/bash

build_debug() {
    echo "Build debug"

    elm make src/Main.elm \
        --debug \
        --output dist/app.js

    browserify src/index.js \
        -o dist/index.js \
        -t [ babelify --presets [ @babel/preset-env ] ]  
}

build() {
    echo "Build prod"
    elm make src/Main.elm \
        --optimize \
        --output dist/app.js 

    uglifyjs dist/app.js -c "pure_funcs=[F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9],pure_getters,keep_fargs=false,unsafe_comps,unsafe" \
        | uglifyjs --mangle -o dist/app.js

    browserify src/index.js \
        -o dist/index.js \
        -t [ babelify --presets [ @babel/preset-env ] ] 

    uglifyjs dist/index.js \
        -o dist/index.js
}

mkdir -p dist
rm -r dist/*

if [[ $1 = "-debug" ]];
then build_debug
else build
fi

cp src/index.html dist/index.html
cat $(find src -type f -name "*.css") > dist/style.css
cp src/favicon.ico dist/favicon.ico

ls -lh dist