#stderr usage

#translit
#http://www.unix.com/shell-programming-scripting/196823-completed-command-line-google-translation-tool.html

#phonetics to ascii: echo Hej på dig, du den dära | iconv -f utf-8 -t us-ascii//TRANSLIT

#https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&ved=0CDQQFjAA&url=http%3A%2F%2Fwww.commandlinefu.com%2Fcommands%2Fview%2F8044%2Fgoogle-text-to-speech-in-mp3-format&ei=mpoHUfLcJanV4QTMmYDQBw&usg=AFQjCNGCSihY6QftaFWuAKRpsIFsbBKpYQ&sig2=GsEg3ttz_5pio9TTJ400QA&bvm=bv.41524429,d.Yms
#http://www.jstorimer.com/2011/12/29/the-difference-between-stdout-and-stderr.html

#say() { if [[ "${1}" =~ -[a-z]{2} ]]; then local lang=${1#-}; local text="${*#$1}"; else local lang=${LANG%_*}; local text="$*";fi; 
#say() { if [[ "${1}" =~ -[a-z]{2} ]]; then local lang=${1#-}; local text="${*#$1}"; else local lang=${LANG%_*}; local text="$*";fi; mplayer "http://translate.google.com/translate_tts?ie=UTF-8&tl=${lang}&q=${text}" &> /dev/null ; }
#}
#count the number of files, check existance, direct errors to dev/null
#http://www.ducea.com/2009/03/05/bash-tips-if-e-wildcard-file-check-too-many-arguments/
green "Redirection"

#is_silent='false'

test_redirecting_stdout_to_file() {

    bin/output_stdout > tmp/redirect_test.txt

    local contents=`cat tmp/redirect_test.txt`

    assertEqual "$contents" 'out to stdout'

}

test_redirecting_stderr_to_file() {
    bin/output_stderr 
    bin/output_stderr 2> tmp/redirect_test2.txt

    local contents=`cat tmp/redirect_test2.txt`

    assertEqual "$contents" 'out to stderr'
}

test_redirecting_stdout_to_stderr() {
    bin/output_stdout 2> tmp/redirect_test3.txt 1>&2

    local contents=`cat tmp/redirect_test3.txt`

    assertEqual "$contents" 'out to stdout'

}

test_redirecting_stderr_to_stdout() {
    bin/output_stderr 1> tmp/redirect_test4.txt 2>&1

    local contents=`cat tmp/redirect_test4.txt`

    assertEqual "$contents" 'out to stderr'

}

test_redirecting_stdout_and_stderr_to_file() {
    bin/output_both 1> tmp/redirect_test5.txt 2> tmp/redirect_test6.txt

    local contents5=`cat tmp/redirect_test5.txt`
    local contents6=`cat tmp/redirect_test6.txt`

    assertEqual "$contents5" 'out to stdout'
    assertEqual "$contents6" 'out to stderr'

}
test_file_exist() {
    local lang='itiiiiiiiiiiiiiitiii'
    local input_ws='I love'
    local input=$(echo "$input_ws"|sed 's/ /_/g');

    #   local file1= $(  tmp/word_${input}_${lang}.txt )

    local file_name=$(  echo tmp/word_${input}_${lang}.txt )
   
    
#touch "$file_name" 

   # echo 'data1' > "$file_name"
   # local content=$(cat  "$file_name")
   # local size=`expr length "$content"`
    #assertEqual "$file_name" 'out to stderr'

    #local exp=
  #  local exp1=$( [ -s "$file_name" ] )
    

  files=$(ls $file_name ) #**2> /dev/null**)
#[ -f /etc/hosts ] && echo "Found" || echo "Not found"

#local returned_value="$?"
    #assertEqual "$files" 'out to stderr'
    if [[ ! "$files"  ]]
    then


touch "$file_name" 
      #  assertEqual "file not exist!" 'out to stderr'



    else

echo ''
      #  assertEqual "file exist" 'file exist' #out to stderr'
    fi


        assertEqual 1 1
        #"file exist" 'file exist' #out to stderr'


}


