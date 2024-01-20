#!/bin/bash
lsof -ti:1313 | xargs kill
hugo server &
open -a 'Google Chrome' http://localhost:1313/
