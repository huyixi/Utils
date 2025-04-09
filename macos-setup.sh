#!/bin/bash

echo "🔧 应用 macOS 系统优化设置中..."

## 🧩 系统设置
defaults write -g AppleKeyboardUIMode -int 3
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 1
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write -g NSWindowResizeTime -float 0.001
defaults write -g NSDocumentSaveNewDocumentsToCloud -bool true
defaults write -g AppleScrollerPagingBehavior -bool true
defaults write -g AppleWindowTabbingMode -string always

## 🧭 Dock 设置
defaults write com.apple.dock orientation -string left
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock showhidden -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock persistent-apps -array ""

## 🗂️ Finder 设置
defaults write com.apple.finder QuitMenuItem -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string clmv
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder FXDefaultSearchScope -string SCcf
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder NewWindowTarget -string PfHm
defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/"
defaults write com.apple.finder QLEnableTextSelection -bool true
defaults write com.apple.finder FXInfoPanesExpanded -dict MetaData -bool true Preview -bool false

## 👆 Trackpad 设置
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

## 📊 活动监视器
defaults write com.apple.ActivityMonitor SortColumn -string CPUUsage
defaults write com.apple.ActivityMonitor SortDirection -int 0

## 🚫 Launch Services
defaults write com.apple.LaunchServices LSQuarantine -bool false

## 🌐 Safari 设置（隐私）
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtras -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

## 🧑‍🦯 Universal Access（无障碍）
defaults write com.apple.universalaccess mouseDriverCursorSize -float 1.5

## 📸 截图设置
defaults write com.apple.screencapture name -string screenshot
defaults write com.apple.screencapture include-date -bool false

## 💻 Desktop Services
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

## 💽 磁盘镜像
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

## 💥 Crash Reporter
defaults write com.apple.CrashReporter DialogType -string none

## 📉 AdLib（广告追踪）
defaults write com.apple.AdLib forceLimitAdTracking -bool true
defaults write com.apple.AdLib allowApplePersonalizedAdvertising -bool false
defaults write com.apple.AdLib allowIdentifierForAdvertising -bool false

## 🔋 电源管理设置
sudo pmset -a displaysleep 10
sudo pmset -a sleep 15
sudo pmset -a disksleep 30
sudo pmset -a womp 0
sudo pmset -a acwake 0
sudo pmset -a proximitywake 0
sudo pmset -a powernap 0
sudo pmset -a halfdim 1
sudo pmset -b gpuswitch 2
sudo pmset -c gpuswitch 1
sudo pmset -a standby 1
sudo pmset -a standbydelayhigh 7200
sudo pmset -a standbydelaylow 3600
sudo pmset -a hibernatemode 3

## 🔓 允许安装非 App Store 应用
sudo spctl --master-disable

echo "✅ 所有设置应用完成，请注销或重启以确保全部生效。"
