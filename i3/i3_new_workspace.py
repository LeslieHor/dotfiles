#!/usr/bin/python

import subprocess
import json
import time

def call(command):
    """Call into the system and run Command (string)"""
    cmd = join_and_sanitize(command)
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                            shell=True)
    result, _err = proc.communicate()
    return result

def join_and_sanitize(list_):
    """Join a list of items into a single string"""
    if isinstance(list_, str):
        return list_

    new_list = []
    for item in list_:
        if isinstance(item, str):
            new_list.append(item)
        elif isinstance(item, int):
            new_list.append(str(item))
        elif isinstance(item, float):
            new_list.append(str(item))
        else:
            raise Exception('Invalid type when attempting to join and sanitize')

    return ' '.join(new_list)

workspaces_data = json.loads(call("i3-msg -t get_workspaces"))

for i in range(1, len(workspaces_data) + 1):
    result = filter(lambda x: x['num'] == i, workspaces_data)
    if len(result) == 0:
        call(["i3-msg move container to workspace number", i])
        call(["i3-msg workspace number", i])
        exit(0)

call(["i3-msg move container to workspace number", len(workspaces_data) + 1])
call(["i3-msg workspace number", len(workspaces_data) + 1])
