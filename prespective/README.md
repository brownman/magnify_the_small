Quote: 
----------
"Magnify The Small" (Wayne Dyer)

About the project:
------------------
- project:
    - status:
              - updated daily for the last: 3 month 

    - goal:
             - increase awareness for the clock
             - get prespective through time

    -  motivation: 
        - increase efficiency and make more and more order

    -  hope:
        - it will serve others too.

project motivation: 
--------------------
- organize my schedules:
    - use: Google Tasks, Calender
    - why:
        - time prespective
        - task managment
        - monitoring: difficulties,time consumers

- remind myself again and again:
    - use:
        - a system timer
    - why:
           - run series of tasks

- record myself: 
    - use: Google Blogger, Youtube
    - why:
          - for later inspection
          - save your ideas, plans,  

- teach myself a new language:
    - use: Google Translate , tts engine
    - why:
        - motivation mantras/guidance




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




