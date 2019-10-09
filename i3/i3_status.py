#!/usr/bin/python

import subprocess
import json

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


displays = ['DVI-I-1', 'DP-0.1', 'DVI-D-0']

outputs = list(filter(lambda output: output['active'], json.loads(call("i3-msg -t get_outputs"))))
workspaces = json.loads(call("i3-msg -t get_workspaces"))
workspaces.sort(key=lambda ws: ws['num'])

active_workspaces = map(lambda x: str(x['current_workspace']), outputs)

def gen_status(current_display):
    active_workspace_name = filter(lambda x: str(x['name']) == current_display, outputs)[0]['current_workspace']

    string = '| '
    for ws in workspaces:
        num = str(ws['num'])
        name = ws['name']

        if num == name:
            ws_name = num + ': ' + name
        else:
            ws_name = name

        if name == active_workspace_name:
            ws_name = "> " + ws_name + " <"
        elif name in active_workspaces:
            ws_name = ".." + ws_name + ".."

        string += ws_name
        string += ' | '

    f = open('/home/leslie/.config/i3/i3_status_' + current_display + ".txt", 'w')
    f.write(string)
    f.close()

for d in displays:
    gen_status(d)
