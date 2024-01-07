#! /usr/bin/env zsh

# Sets the tile size to 36px.
defaults write com.apple.dock "tilesize" -int "36"

# Enable magnification of the dock on hover.
defaults write com.apple.dock "magnification" -bool "true"

# Sets the tile size, on hover, to 48px.
defaults write com.apple.dock "largesize" -int "56"

# Do not show indicators for open applications.
defaults write com.apple.dock "show-process-indicators" -bool "false"

# Do not show suggested and recent apps in the dock.
defaults write com.apple.dock "show-recents" -bool "false"

# Automatically hide and show the dock.
defaults write com.apple.dock "autohide" -bool "true"

# Remove the auto-hide delay.
defaults write com.apple.dock "autohide-delay" -float "0"

# Minimize windows into application icon.
defaults write com.apple.dock "minimize-to-application" -bool "true"

# Scroll up on a dock icon to show all opened windows for an app (in the active space), or open stack.
defaults write com.apple.dock "scroll-to-open" -bool "true"

# Persistent apps are those that you typically drag into the Dock.
# We're going to clear the ones that are currently configured and add those that we find in the persistent-apps directory.
defaults write com.apple.dock persistent-apps -array
for file in ./persistent-apps/*.xml(N); do
	tile=$(cat "${file}")
	defaults write com.apple.dock persistent-apps -array-add ${tile}
done

# Persistent others are directories, like the ~/Downloads folder.
# Clear the currently configured entries and add those that we find in the persistent-others directory.
defaults write com.apple.dock persistent-others -array
for file in ./persistent-others/*.xml(N); do
	tile=$(cat "${file}")
	defaults write com.apple.dock persistent-others -array-add ${tile}
done

# Static apps are similar to persistent ones, but you can't manually remove them from the dock.
# We're going to clear the ones that are currently configured and add those that we find in the static-apps directory.
defaults write com.apple.dock static-apps -array
for file in ./static-apps/*.xml(N); do
	tile=$(cat "${file}")
	defaults write com.apple.dock static-apps -array-add ${tile}
done

# Static others are directories, like the ~/Downloads folder and are not manually removable from the dock.
# Clear the currently configured entries and add those that we find in the static-others directory.
defaults write com.apple.dock static-others -array
for file in ./static-others/*.xml(N); do
	tile=$(cat "${file}")
	defaults write com.apple.dock static-others -array-add ${tile}
done

# Only show the static tiles, hiding the persistent ones. Has the effect of only showing the active applications
# if there are no static apps/others configured.
# defaults write com.apple.dock "static-only" -bool "true"

# Will cause LauchPad to reset when the dock restarts.
# This will cause the first page of LaunchPad to contain Apple applications.
# Third party applications will start at the second page.
defaults write com.apple.dock ResetLaunchPad -bool true

killall Dock

