#!/usr/bin/python

import subprocess
import json
import sys
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

workspace_target = sys.argv[1]

workspaces_data = json.loads(call("i3-msg -t get_workspaces"))

active_workspace = list(filter(lambda workspace: workspace['focused'], workspaces_data))[0]
active_output = active_workspace['output']

target_workspace = filter(lambda x: x['num'] == int(workspace_target), workspaces_data)
if len(target_workspace) == 0:
    call(["i3-msg workspace number", workspace_target])
    exit(0)
target_workspace = target_workspace[0]

# Focus target workspace
call(["i3-msg workspace number", workspace_target])

if not target_workspace['visible']:
    # Move workspace to current display
    print active_output
    call(["i3-msg move workspace to output", str(active_output)])
    # Focus target workspace again
    time.sleep(0.1)
    call(["i3-msg workspace number", workspace_target])
