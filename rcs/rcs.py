#!/usr/bin/python3
# -*- coding: utf-8 -*-
# 0xCCCCCCCC

import argparse
import base64
import json
import shutil
import subprocess

from os import path


REPO_FILENAME = 'repo'
RESOURCES_FILENAME = 'resources.json'


class Conf:
    def __init__(self):
        self._repo = ''
        self._resources = {}

    @property
    def repo(self):
        return self._repo

    @repo.setter
    def repo(self, repo_path):
        self._repo = repo_path

    @property
    def resources(self):
        return self._resources

    @resources.setter
    def resources(self, new_resources):
        self._resources = new_resources


rcs_conf = Conf()


def init_conf():
    install_dir = path.dirname(path.dirname(path.abspath(__file__)))

    repo_file = path.join(install_dir, REPO_FILENAME)
    with open(repo_file) as f:
        rcs_conf.repo = f.read().strip()

    resources_file = path.join(install_dir, RESOURCES_FILENAME)
    with open(resources_file) as f:
        rcs_conf.resources = json.load(f)


def display_version():
    ver = '0.1.0'
    print('rcs ' + ver)


def show_supported_resources():
    print('Currently supported items:')
    for item in rcs_conf.resources.keys():
        print(item)


def deploy(item):
    if item not in rcs_conf.resources:
        print('Error: cannot deploy unrecognized item ' + item)
        return

    item_conf = rcs_conf.resources[item]
    src = path.join(rcs_conf.repo, 'rcs', 'resources', item_conf['resource'])
    dest = path.expanduser(item_conf['deploy_target'])
    shutil.copy(src, dest)

    print('Done deploying {0} -> {1}'.format(src, dest))

    if 'post_deploy' not in item_conf:
        return

    post_cmd = base64.decodebytes(item_conf['post_deploy'].encode('utf-8')).decode('utf-8')
    post_cmd = '#!/bin/bash\n' + post_cmd
    subprocess.call(post_cmd, shell=True)

    print('Done running post deployment command')


def update(item):
    if item not in rcs_conf.resources:
        print('Error: cannot update unrecognized item ' + item)
        return

    item_conf = rcs_conf.resources[item]
    src = path.expanduser(item_conf['deploy_target'])
    dest = path.join(rcs_conf.repo, 'rcs', 'resources', item_conf['resource'])
    shutil.copy(src, dest)

    print('Done update {0} -> {1}'.format(src, dest))

    if 'post_update' not in item_conf:
        return

    post_cmd = base64.decodebytes(item_conf['post_update'].encode('utf-8')).decode('utf-8')
    post_cmd = '#!/bin/bash\n' + post_cmd
    subprocess.call(post_cmd, shell=True)

    print('Done running post update command')


def main():
    parser = argparse.ArgumentParser()

    cmder = parser.add_subparsers(title='commands', dest='command')

    deploy_parser = cmder.add_parser('deploy', help='deploy to current user')
    deploy_parser.add_argument('item', action='store')

    update_parser = cmder.add_parser('update', help='update changes to repo')
    update_parser.add_argument('item', action='store')

    cmder.add_parser('list', help='list supported items')

    parser.add_argument('--version', dest='show_ver', action='store_true')

    args = parser.parse_args()

    if args.show_ver:
        display_version()
        return

    init_conf()

    cmds = {
        'deploy': deploy,
        'update': update,
        'list': show_supported_resources
    }

    if args.command == 'list':
        cmds[args.command]()
    else:
        cmds[args.command](args.item)


if __name__ == '__main__':
    main()
