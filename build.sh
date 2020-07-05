#!/bin/bash

rm dev/*
elm make src/Main.elm --debug --output dev/app.js
webpack --config webpack.config.js
cp src/index.html dev/index.html
cp src/style.css dev/style.css
cp src/favicon.ico dev/favicon.ico

ls dev