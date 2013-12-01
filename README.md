
Quote: 
----------
"Magnify The Small" (Wayne Dyer)

About the project:
------------------
- project:
    - goal:
             - increase awareness for the clock
             - get prespective through time
             - increase motivation to deal with your tasks
             - increase efficiency by doing more and more order
    -  hope:
             - it will serve others too.

pipes:
-------
- the project consist of 3 projects:
    - 1. a koan project   -  where we update the unit-tests
    - 2. a tasks project  -  where we update our daily tasks and add motivation sentences
    - 3. an image project -  where we build a picture of our day by accumulating notifications 

life-cycle: 
--------------------
- update:
    - daily tasks:
        - edit blank.yaml
    - motivations:
        - edit glossary.txt

- push koans forward:
    - first run: 
        - watchr linux.watchr
    - update a koan:
        - edit and save a unit-test file

- the system will:
    - show a notification regarding an error in the code 
    - play a motivation sentence and its translation 
    - remind you of your life's tasks
    
- the daily product:
    - the notifications will be accumulated in a log file
    - we will compile this log file to a colorful and meaningful picture


tools and services:
---------
- google calender/tasks/blogger/youtube
- linux tools: notify-send, gxmessage, flite


directory structure:
----------------------
- root:
    - config/timer.cfg    | user set preferences
    - conifg/workflow.txt | user set list of tasks to execute one after another 

    - public/plugins/suspend.sh     | plugin example: suspend the computer
    - public/plugins/translation.sh | plugin example: translate a sentance to a choosen forign-languages

    - automatic.sh    
        - parse: workflow.cfg - execute listed tasks - one after another
        - run this script every 5 minutes
        
    - manual.sh    
        - update blog:
            - service: google blogger
            - use:     upload cfg/blank.txt
        - update youtube:
            - service: youtube
            - use:     recored your morning wishes to youtube

videos:
---------------
- [ 11-7-13 imagine.sh - break task to mini-tasks ](http://ascii.io/a/4113).
- [ 25-7-13 plugin: translation: choose random line from motivation.txt and say it to many languages ](http://ascii.io/a/4337).



news:
------------
- idea:
    - percieve yourself as an emotional human being
            
- take action:      save your thoughts:
    - each task we want to do - rise some emotion - note it down!

- how:     draw a colorful image of your feelings
- example:
    - draw your emotions: 
        - one can represent his fear as a grey cloud with a text description in its middle.

- be efficient:
    - look at yesturday picture - and observe it as a true picture of your mind
    - be productive about how you deal with your fears - don't pospond a task


- be cool regarding your fears:
    - how: look deep into this picture and grasp your map of feelings 
    - look fear in its eyes - don't ignore it - increase your self compation
    - comminucate with your higher self

- be creative:
    - invite yourself tomorrow to deal again with your fears - make them smaller and smaller 
    - entertain yourself with a picture which is creative warm and inspiring

- RECENT_DUMP:
- riddle:
1,1,1,1
- koan
9,"count new records",10:35,tasks_sh,db,"counter koan",3,8
8,"count new records",10:35,tasks_sh,db,"counter koan",3,7
7,"count new records",10:26,tasks_sh,db,"counter koan",3,""
6,"count new records",10:09,tasks_sh,db,"counter,koan",3,"0 #file_db=/test.db assert_equal_str res1="
5,"count new records",10:09,tasks_sh,db,"counter koan",3,""
4,"count new records",09:55,tasks_sh,db,"counter koan",x,failed
3,"count new records",09:54,tasks_sh,db,"counter koan",x,failed
2,"update the readme file",15:03,tasks_sh,update_readme,"",x,failed
1,1,1,1,1,1,1,1
     1	she had a good company
     2	but she was still happy
     3	but she was still happy
     4	but she was still happy
     5	but she was stil happy
     6	the ant had a small brain
     7	the ant had a small brain
     8	about his good friend - the ant
     9	exit
    10	and he was happy to hear the good news
    11	there was also an elephant though
    12	there was a little ant
    13	once upon a time
