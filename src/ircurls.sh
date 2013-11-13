#!/bin/sh
fbb $(for i in $(cat); do echo $i | grep http; done)
