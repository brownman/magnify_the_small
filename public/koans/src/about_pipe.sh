green "Piping"

test_piping_output_to_another_program() {
  # The pipe lets you use the output of a program as the input of another one
  local output=`echo 'milk' | sed -e "s/milk/beer/g"`

  assertEqual $output 'beer'
}


test_piping_2() {

file_missions=$(echo '/TORRENTS/TASKS/list.txt')

  #text1=$(cat "$file_missions")

  lang="ru"

result1='giardino'
#$(translate-bin -f en -t "$lang" "$file_missions") 
assertEqual "$result1" 'giardino'
}

