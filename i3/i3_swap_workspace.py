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

direction = sys.argv[1]

if direction == 'left':
    offset = -1
else:
    offset = 1

outputs = list(filter(lambda output: output['active'], json.loads(call("i3-msg -t get_outputs"))))
active_workspace = list(filter(lambda workspace: workspace['focused'], json.loads(call("i3-msg -t get_workspaces"))))[0]

displays = ['DVI-I-1', 'DP-0.1', 'DVI-D-0']

active_output = active_workspace['output']
active_workspace_num = active_workspace['num']

target_workspace_id = list(filter(lambda output: output['name'] == displays[((displays.index(active_output) + offset) % len(displays))], outputs))[0]['current_workspace']

if direction == 'left':
    call('i3-msg move workspace to output left')
else:
    call('i3-msg move workspace to output right')

call(['i3-msg workspace number', str(target_workspace_id)])

if direction == 'left':
    call('i3-msg move workspace to output right')
else:
    call('i3-msg move workspace to output left')

# Sleep due to race condition with i3 changing focus after the second move
time.sleep(0.1)

# i3 has weird behaviour if target output has no workspaces
call(['i3-msg workspace number', str(target_workspace_id)])
