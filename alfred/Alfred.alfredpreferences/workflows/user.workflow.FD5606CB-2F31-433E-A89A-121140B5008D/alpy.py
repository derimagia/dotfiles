#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""script.py

Utilities for working with Alfred.app.
"""
__all__ = (
    'ScriptFilter',
)
import os
import sys
import json
import errno
import os.path
import plistlib
from xml.etree import ElementTree as et

from docopt import docopt

# Recommended storage path for volatile settings and data.
# See http://www.alfredforum.com/topic/307-workflows-best-practices/
VOLATILE_PATH = (
    '~/Library'
    '/Caches'
    '/com.runningwithcrayons.Alfred-2'
    '/Workflow Data/'
)

# Recommended storage path for non-volatile settings and data.
# See http://www.alfredforum.com/topic/307-workflows-best-practices/
NON_VOLATILE_PATH = (
    '~/Library'
    '/Application Support'
    '/Alfred 2'
    '/Workflow Data/'
)


def _make_dir(path):
    # http://stackoverflow.com/a/600612
    try:
        os.makedirs(path + os.sep)
    except OSError as exc:
        if exc.errno == errno.EEXIST and os.path.isdir(path):
            pass
        else:
            raise


class ScriptFilter(object):
    def __init__(self, version=None):
        self._version = version
        self._info = {}
        self._config_name = 'config.json'

        if os.path.isfile('info.plist'):
            self._info = plistlib.readPlist('info.plist')

        self.create_folders()

    @property
    def version(self):
        """
        The version (if any) of this script.
        """
        return self._version

    @property
    def bundleid(self):
        """
        The Alfred BundleID for the workflow containing this
        script.
        """
        return self._info.get('bundleid')

    @property
    def config_path(self):
        return os.path.join(self.non_volatile_path, self._config_name)

    @property
    def volatile_path(self):
        """
        The full path to the recommended folder for volatile
        settings and data storage.
        """
        return os.path.join(
            os.path.expanduser(VOLATILE_PATH),
            self.bundleid
        )

    @property
    def non_volatile_path(self):
        """
        The full path to the recommended folder for non-volatile
        settings and data storage.
        """
        return os.path.join(
            os.path.expanduser(NON_VOLATILE_PATH),
            self.bundleid
        )

    def create_folders(self):
        """
        Create the volatile and non-volatile settings folders, if
        they do not already exist.
        """
        if not os.path.isdir(self.non_volatile_path):
            _make_dir(self.non_volatile_path)

        if not os.path.isdir(self.volatile_path):
            _make_dir(self.volatile_path)


    def set(self, key, value):
        """
        Set a setting by its key.

        :param key: The key of the setting to set.
        :param value: The new value of the key.
        """
        if os.path.isfile(self.config_path):
            with open(self.config_path, 'rb') as fin:
                j = json.load(fin)
                j[key] = value
        else:
            j = {key: value}

        with open(self.config_path, 'wb') as fout:
            json.dump(j, fout)

    def get(self, key, default=None):
        """
        Get a setting by its key, returning `default` if it does
        not exist.

        :param key: The key of the setting to retrieve.
        :param default: The value to return if no such key exists.
        """
        # FIXME: We re-load the settings from disk each time,
        #        which is clearly not optimal.
        if not os.path.isfile(self.config_path):
            return default

        with open(self.config_path, 'rb') as fin:
            return json.load(fin).get(key, default)

    def unset(self, key, silent=True):
        """
        Unset an existing setting by its key.

        :param key: The key of the setting to unset.
        :param silent: If ``True``, don't raise an exception if the
                       key doesn't exist.
        """
        if not os.path.isfile(self.config_path):
            if not silent:
                raise KeyError('{key} not found'.format(key=key))

            return

        with open(self.config_path, 'rb') as fin:
            j = json.load(fin)
            if key in j:
                del j[key]
            elif not silent:
                raise KeyError('{key} not found'.format(key=key))
            else:
                return

        with open(self.config_path, 'wb') as fout:
            json.dump(j, fout)

    @staticmethod
    def to_xml(items):
        """
        Convert a list of items to XML and return
        it as a string.
        """
        items_node = et.Element(u'items')

        for item_attr, item_elements in items:
            item_node = et.SubElement(items_node, 'item', attrib=item_attr)
            for el_name, el_val in item_elements.iteritems():
                if isinstance(el_val, (tuple, list)):
                    attrib, el_val = el_val
                else:
                    attrib = {}

                el_node = et.SubElement(item_node, el_name, attrib=attrib)
                el_node.text = el_val

        return et.tostring(items_node)

    def main(self, args):
        """
        Called when your script filter is run.
        """
        raise NotImplementedError()

    def _main(self):
        args = docopt(self.__doc__, version=self.version)

        result = self.main(args)

        if isinstance(result, int):
            sys.exit(result)
        elif not result:
            print(self.to_xml([
                ({
                    'valid': 'no'
                }, {
                    'title': 'There were no results.',
                    'subtitle': 'Try another query',
                    'icon': 'icon.png'
                })
            ]))
        else:
            print(self.to_xml(result))
