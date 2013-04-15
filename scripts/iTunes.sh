#!/usr/bin/env osascript
# Returns the current playing song in iTunes for OSX

tell application "System Events"
  set process_list to (name of every process)
end tell

if process_list contains "iTunes" then
  tell application "iTunes"
    if player state is playing then
      set trim_length to 40
      set now_playing to current stream title
      if now_playing is missing value then
          set now_playing to name of current track as string
      end if

      if length of now_playing is 0 then
        set now_playing to name of current track
      end if

      if length of now_playing is less than trim_length then
        set now_playing_trim to now_playing
      else
        set now_playing_trim to characters 1 thru trim_length of now_playing as string
      end if
    else
      set now_playing_trim to ""
    end if
  end tell
else
  set now_playing_trim to ""
end if
