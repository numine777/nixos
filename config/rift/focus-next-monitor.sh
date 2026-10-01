#!/bin/bash
set -euo pipefail

# launchd may omit the Nix profile (jq) and Homebrew (rift-cli) from PATH.
export PATH="${PATH:-/usr/bin:/bin}:$HOME/.nix-profile/bin:/opt/homebrew/bin:/usr/local/bin"

# Rift's active-context flag can stay on the old monitor when focusing an empty
# workspace. Display focus always warps the pointer, so use that as our position.
cursor=$(/usr/bin/osascript -l JavaScript -e '
  ObjC.import("CoreGraphics");
  var point = $.CGEventGetLocation($.CGEventCreate(null));
  JSON.stringify({x: point.x, y: point.y});
')

# Query each time so pointer movement and display reconnects are honored.
# Inactive Spaces cannot receive Rift focus. Order displays by their position,
# then wrap; UUID targeting avoids relying on changing display indexes.
next_uuid=$(rift-cli query displays | jq -r --argjson cursor "$cursor" '
  # Rift reports usable frames, which exclude menu bars and docks. The nearest
  # rectangle also identifies the right display when the pointer is in those gaps.
  def distance_to($point):
    .frame as $f
    | ([($f.origin.x - $point.x), 0,
        ($point.x - $f.origin.x - $f.size.width)] | max) as $dx
    | ([($f.origin.y - $point.y), 0,
        ($point.y - $f.origin.y - $f.size.height)] | max) as $dy
    | $dx * $dx + $dy * $dy;
  map(select(.is_active_space == true))
  | sort_by(.frame.origin.x, .frame.origin.y, .uuid)
  | if length < 2 then empty
    else
      (to_entries | min_by(.value | distance_to($cursor)) | .key) as $current
      | .[($current + 1) % length].uuid
    end
')

if [[ -n "$next_uuid" ]]; then
  exec rift-cli execute display focus --uuid "$next_uuid"
fi
