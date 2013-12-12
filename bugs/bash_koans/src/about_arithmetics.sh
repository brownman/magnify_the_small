green "Arithmetic evaluation"

test_arithmetic_evaluation() {

  local output=`echo 1+1`

  assertEqual $output '1+1'

  local output2=$((1+1))

  assertEqual $output2 2
}

test_pid(){
local  command='exec /bin/gxmessage hi'
local pid0=$$
$( eval "$command" ) & pid=$!
   #{ sleep 4; kill $pid; } &
#local res=$( kill -0 $pid )
assertEqual "$pid" "$pid0"

}


