#!/bin/bash

# Run           |Volume mount    |PWD      |Cont   |Command
docker run --rm -v "$PWD":/myapp -w /myapp gcc:6.4 gcc -o myapp_6_4 gcc_app.c
