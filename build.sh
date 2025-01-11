#!/bin/bash

# Build target application
# NOTE: Debug symbols (-g) are no necessary for using putenv.
g++ -o target_app target_app.cpp
