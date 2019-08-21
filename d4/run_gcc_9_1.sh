#!/bin/bash

# Run           |Volume mount    |PWD      |Cont     |Command
docker run --rm -v "$PWD":/myapp -w /myapp gcc:9.1.0 gcc -o myapp_9_1 gcc_app.c
