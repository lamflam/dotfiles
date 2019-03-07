# Tmux Spotify Plugin

Tmux plugin that shows the current spotify status in your statusline

Introduces the following new status variables:

* `#{spotify_status}`
* `#{spotify_artist}`
* `#{spotify_album}`
* `#{spotify_track}`

### Usage

The following interpolations are made available for your statusline:

* `#{spotify_status}` - Spotify status icons
* `#{spotify_artist}` - Current artist
* `#{spotify_album}`  - Current album
* `#{spotify_track}`  - Current track

Here's the example in `.tmux.conf`:

    set -g status-right "♫ #{spotify_status} #{spotify_artist}: #{spotify_track} | %a %h-%d %H:%M "

Customize the icons with:

    set -g @spotify_playing_icon ">"
    set -g @spotify_paused_icon "="

    # optional: defaults to `paused_icon`
    set -g @spotify_stopped_icon "X"

### Screenshots

![status](/screenshots/spotify-status.png)<br/>

### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'robhurring/tmux-spotify'

Hit `prefix + I` to fetch the plugin and source it.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/robhurring/tmux-spotify ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/spotify.tmux

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf

