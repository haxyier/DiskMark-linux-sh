#! /bin/bash

# This script is derived from CrystalDiskMark
# (https://crystalmark.info/ja/software/crystaldiskmark/)


TEST_FILE=$1
INTERVAL_TIME=5

dm_interval() {
    echo "Wait for the next test for $INTERVAL_TIME seconds..."
    sleep $INTERVAL_TIME
}


echo "Executing Sequential Read (SEQ1M Q8T1)..."

# TODO: Create test file manually for better randomization and less effect on the performance.
diskspd -c1G -Zr -b1M -d5 -o8 -t1 -W0 -Sd -w0 -L $1
dm_interval

echo "Executing Sequential Read (SEQ1M Q1T1)..."
diskspd -Zr -b1M -d5 -o1 -t1 -W0 -Sd -w0 -L $1
dm_interval

echo "Executing Random Read (RND4K Q32T16)..."
diskspd -Zr -b4K -d5 -o32 -t16 -W0 -Sd -w0 -L -r $1
dm_interval

echo "Executing Random Read (RND4K Q1T1)..."
diskspd -Zr -b4K -d5 -o1 -t1 -W0 -Sd -w0 -L -r $1
dm_interval

echo "Executing Sequential Write (SEQ1M Q8T1)..."
diskspd -Zr -b1M -d5 -o8 -t1 -W0 -Sd -w100 -L $1
dm_interval 

echo "Executing Sequential Write (SEQ1M Q1T1)..."
diskspd -Zr -b1M -d5 -o1 -t1 -W0 -Sd -w100 -L $1
dm_interval

echo "Executing Random Write (RND4K Q32T16)..."
diskspd -Zr -b4K -d5 -o32 -t16 -W0 -Sd -w100 -L -r $1
dm_interval

echo "Executing Random Read (RND4K Q1T1)..."
diskspd -Zr -b4K -d5 -o1 -t1 -W0 -Sd -w100 -L -r $1
dm_interval


rm -f $TEST_FILE

echo "DiskMark is completed!"
