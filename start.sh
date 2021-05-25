#!/bin/sh
if ps -ef | grep -v grep | grep screen ; then
  echo "already running."
  echo "WARN: you can still running another one by starting manually."
  exit 0
else
  screen -m -d -S server DreamDaemon tgstation.dmb 2505 -trusted
  echo "launching"
  exit 0
fi