

insert_row(){

    notify-send 'insert row' "$1 | $2"
    local name="$1"
    local table1="$name"
    local  file_db=$file_db
    #SQL_DIR/$name.db 

    local fields=$(echo "($2)" | sed 's/ /,/g')
    #assert_equal_str "$fields"
    local values=$(echo "('$3')" | sed "s/|/','/g")
    #local fields1='(doing,should,sport)'
    #local values1="('a a','b','1')"
    #local cmd=$(echo "sqlite3 $file_db  \"insert into $table1 $fields values $fields\";")
    local cmd=$(echo "sqlite3 $file_db  \"insert into $table1 $fields values $values\";")

    local res=$(   eval "$cmd")
    trace "res: $res"
}

update_db_list(){

    local file_db=$file_db
    local file_new=$DATA_DIR/txt/db.txt
    notify-send 'update_db_list'
    #local str=$(sqlite3 -header -list ex1.db ".tables" | xargs echo | sed 's/ /|/g')
    local str=$(sqlite3 -header -list $file_db ".tables" | tr -s ' ' '\n')
    echo "$str" > $file_new

    #mantion_file $file_new 20
    #assert_equal_file "$file_new"

    echo "$str"
}


show_selected_table(){


    local cmd=''
    local values="$2"
    local gui=''
    if [ "$values" ];then

        gui=false
    else

        gui=true
    fi


    #local gui=true

    local table1="$1"
    local name="$1"

    #assert_equal_str "$table1"
    local  file_db=$file_db
    #SQL_DIR/$name.db 
    notify-send 'show_selected_table:' ": $table1"
    #breakpoint


    local zen1="--width=1280 --height=800 --list --title=$table1"
    local zen2=''


    local header=$(sqlite3 -header -list $file_db "select * from $table1;" | head -n 1)

    IFS='|' read -a columns <<< "$header"
    fields=(${columns[@]})
    unset fields[0]
    fields="${fields[@]}"

    count=0
    for col in ${columns[@]}; do
        zen1="$zen1 --column=\"$col\" "

        if [ $count -eq 0 ];then
            trace 'skip id'

        else
            zen2="$zen2 --add-entry=\"$col\" "

        fi

        let 'count=count+1'
    done


    local tmp=$(echo "zenity $timeout1 --forms --title=$table1 --text=currently: "$zen2" ")
    if [ "$gui" = true ];then

        values=$(eval $tmp)
    fi


    local tmp1=$(echo "$values" | sed 's/|//g' | sed 's/ //g')

    if [ "$tmp1" != '' ];then
        #assert_equal_str "$fields"
        cmd="insert_row '$name' '$fields' '$values'"
        #COMMANDER=true
        eval "$cmd"
        #insert_row "$name" "$fields" "$values"
    fi

    local str1="'select * from $table1 order by id desc;'"
    local pipe1=" tr ','  ' ' " 
    local pipe2=" tr '\n' ' ' "
    local str_sql1="sqlite3 -csv $file_db $str1 | $pipe1 | $pipe2"
    local cmd_sql1=$(echo "$str_sql1")
    local res_sql1=$(eval "$cmd_sql1")
    local str_zen1="xargs zenity $zen1 $timeout1"
    if [ "$gui" = true ];then
        res=$(echo "$res_sql1" |   eval "$str_zen1")
    else
        cmd='echo "$res_sql1" |   eval "$str_zen1"'
        #COMMANDER=true
        #commander "$cmd"
        every "$cmd" 21

    fi
    cmd="$tasks_sh scp_android"
    every "$cmd" 40


    #notify-send1 "res: $res"
    local last=$(sqlite3 $file_db "select * from $table1 order by id desc" | head -1)


    echo "$last"

}

get_column_number(){
    local table1="$1"
    local header=$(sqlite3 -header -list $file_db "select * from $table1;" | head -n 1)
    IFS='|' read -a columns <<< "$header"
trace "${columns[@]}"
    max=${#columns[@]}
    let 'max=max-1'
    return $max
}

update_table(){
    local table="$1"
    shift
    local ids=("$@")
    local values=$( IFS='|'; echo "${ids[*]}" ); 
    local num=${#ids[@]}
    get_column_number "$table"
    local max=$?

    if [ $num -eq $max ];then

        show_selected_table "$table" "$values" 
    else

        assert_equal_str "num:$num max:$max values:$values"
    fi
}


run(){
local res=$($tasks_sh update_db koan)
assert_equal_str "$res"
}

run
