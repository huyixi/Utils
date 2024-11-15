#!/bin/bash
rm -rf public
lsof -ti:1313 | xargs kill
hugo server --ignoreCache &
open -a 'Google Chrome' http://localhost:1313/
