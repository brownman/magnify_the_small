#!/bin/bash
#gxmessage $GXMESSAGET -title 'simple notification' 'hello  world!'
cmd="gedit $KOANS_DIR/about_project.sh"
optional "$cmd" "$cmd" 'error'
