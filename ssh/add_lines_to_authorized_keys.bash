#!/bin/bash

TARGET_USER=shaakma
PUBLIC_KEY="ssh-rsa"

>> ${TARGET_USER} ~/.ssh/authorized_keys_tmp
>> ${PUBLIC_KEY} ~/.ssh/authorized_keys_tmp