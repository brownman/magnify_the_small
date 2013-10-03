#!/bin/bash
#python+android on ubuntu
#steps:
#1 - compile code to binary
#2 - package to .apk
#3 - push to android device

#errors:
#pip install cython
#
step1(){
echo 'update .bashrc with'
echo '#export PATH=$ANDROIDNDK:$ANDROIDSDK/tools:$PATH' >> ~/.bashrc
gedit ~/.bashrc

}
step2(){

xdg-open https://github.com/kivy/python-for-android/blob/master/docs/source/prerequisites.rst
}

step2
