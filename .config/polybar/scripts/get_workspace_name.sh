#!/bin/bash

wmctrl -d | grep -w '*' | awk '{print $9}'
