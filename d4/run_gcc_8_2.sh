#!/bin/bash

# Run           |Volume mount    |PWD      |Cont   |Command
docker run --rm -v "$PWD":/myapp -w /myapp gcc:8.2 gcc -o myapp_8_2 gcc_app.c
