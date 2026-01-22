#!/bin/bash

song_icon=""
song_title=$(playerctl metadata --format '{{title}}')
song_artist=$(playerctl metadata --format '{{artist}}')

# song_art=$(playerctl metadata --format '{{mpris:artUrl}}')

song_info="$song_icon $song_title - $song_artist"

echo $song_info
