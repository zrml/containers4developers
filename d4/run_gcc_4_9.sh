#!/bin/bash

# Run           |Volume mount    |PWD      |Cont   |Command
docker run --rm -v "$PWD":/myapp -w /myapp gcc:4.9 gcc -o myapp_4_9 gcc_app.c
