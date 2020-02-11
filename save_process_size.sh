#!/bin/bash

if [ ! -d log ]
then
        mkdir log
fi

memory_process(){

        process=$(ps -e -o pid --sort -size | head -n 11 | grep [0-9])
        for pid in $process
        do
                process_name=$(ps -p $pid -o comm=)
                echo -n $(date +%F,%H:%M:%S,) >> log/$process_name.log
                process_size=$(ps -p $pid -o size | grep [0-9])
                echo "$(bc <<<"sacle=2;$process_size/1024") MB" >> log/$process_name.log
        done
}

memory_process
if [ $? -eq 0 ]
then
        echo "Files saves sucessfully!"
else
        echo "Error saving files!"
fi
