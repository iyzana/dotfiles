#!/usr/bin/env python3

import gi
gi.require_version('Playerctl', '2.0')
from gi.repository import Playerctl, GLib
from subprocess import Popen


def on_play(player, status):
    print('on_play')
    notify(player)


def on_metadata(player, metadata):
    global last_track_info
    print('on_metadata', metadata)
    track_info = get_track_info(player)
    if track_info:
        status = player.get_property('status')
        if (status == 'Playing' and track_info != last_track_info):
            notify(player)
        last_track_info = track_info


def get_track_info(player):
    if player.get_artist() and player.get_title():
        return '{title} by {artist}'.format(
            artist=player.get_artist(),
            title=player.get_title())
    else:
        return None


def notify(player):
    track_info = get_track_info(player)
    if track_info:
        print('Playing', track_info)
        Popen(['notify-send', 'playing', track_info])


def new_player(manager, name):
    global player
    global last_track_info
    print('new_player', name.name)
    player = Playerctl.Player.new_from_name(name)
    player.connect('metadata', on_metadata)
    player.connect('playback-status::playing', on_play)
    last_track_info = get_track_info(player)
    manager.manage_player(player)


manager = Playerctl.PlayerManager()
last_track_info = ''

manager.connect('name-appeared', new_player)

GLib.MainLoop().run()
