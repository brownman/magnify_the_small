# about file:
# choose a workflow , run serial.sh
#http://blog.jamesslocum.com/post/61904545275/graphical-user-interfaces-from-a-bash-script-using
#https://help.gnome.org/users/zenity/stable/
pushd `dirname $0` > /dev/null
. loader.sh

#export VERBOSE=true
#export DEBUG=true
file_locker=/tmp/interpreter
delay=30




step3(){

zenity --list \
  --title="Choose the Bugs You Wish to View" \
  --column="Bug Number" --column="Severity" --column="Description" \
    992383 Normal "GtkTreeView crashes on multiple selections" \
    293823 High "GNOME Dictionary does not handle proxy" \
    393823 Critical "Menu editing does not work in GNOME 2.0"
}


step2(){

zenity --list --radiolist --text "<b>Please</b> make a selection:" --hide-header --column "Buy" --column "Item" FALSE "Door 1" FALSE "Door 2" FALSE "Door 3" FALSE Quit

}
step1(){

ans=$(zenity  --list  --text "Is linux.byexamples.com helpful?" --radiolist  --column "Pick" --column "Opinion" \
    TRUE Amazing FALSE Average FALSE "Difficult to follow" FALSE "Not helpful"); echo $ans
}
run(){
step1
}

#unlocker
run
popd > /dev/null
exit 0


