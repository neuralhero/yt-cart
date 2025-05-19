# yt-cart - Slow Watching YouTube

![yt-cart banner](assets/banner.png "yt-cart banner")

A carting system for YouTube to enable *browse now watch later* behavior, consisting of a set of Bash scripts to detect changes and download new videos from a YouTube playlist.

## Solving Impulse Watching

I have personally spent too much time on YouTube and found myself binge watching and dead scrolling just to kill time. On the other hand, I do find YouTube helpful in learning new things, keeping up with the latest news, etc. So like many things in life, I need some guardrails and strike a good balance with YouTube.

Seeing similarity in [*impulse shopping*](https://www.bankrate.com/banking/what-is-slow-shopping/) and the benefit of delayed/slow shopping, I decided to try a similar approach to my YouTube watching.

1. **Browsing**: I limit the platforms and time I can use YouTube, and I only use it for browsing mainly.
2. **Carting**: During browsing, if I see anything interesting and non-urgent (which applies to 99% of my watched videos), I will add them to a semi-private playlist, which will be scanned and downloaded by this script.
3. **Watching**: After the videos are downloaded, I will revisit them at a later time of the day or week, if they still interest me.

The turns and friction have so far allowed me to be more deliberate about which videos to watch, and gain better focus since I don't need to watch whatever interests me immediately.

Obviously, YouTube's *Watch Later* could be a much easier solution too, but when everything can be done so effortlessly on one platform, I found myself on a very slippery slope to reclaim my attention, hence this script and approach.

## Features

* Download Video IDs: Fetches all video IDs from a YouTube playlist every minute.

* Change Detection and Download: Detects new videos and triggers downloads based on detected changes.

## Prerequite

* [yt-dlp](https://github.com/yt-dlp/yt-dlp)
* Basics with `bash` and `cron`
* An [unlisted YouTube playlist](https://support.google.com/youtube/answer/3127309?hl=en&co=GENIE.Platform%3DAndroid) which can only be accessed through URL and not search or browse

## Getting Started

1. Clone this repo or [download as ZIP](https://codeload.github.com/neuralhero/yt-cart/zip/refs/heads/main)
2. Switch to the repo folder

    ```bash
    cd yt-cart-main
    ```

3. Change the parameters in `.env`

    ```bash
    nano .env
    ```

4. [OPTIONAL] You may also modify `download_new_videos.sh` based on yt-dlp usage. The script is currently set to grab the video of highest quality with subtitles and thumbnails

    ```bash
    nano download_new_videos.sh
    ```

5. Make sure all these scripts are executable

    ```bash
    sudo chmod +x detect_and_download.sh
    sudo chmod +x download_new_videos.sh
    ```

6. Test run the download script. If this doesn't work, check `.env` (like are the strings wrapped in double quotes?)

    ```bash
    ./download_new_videos.sh
    ```

7. Add this to your cron jobs if you want them to scan and download every minute

    ```bash
    * * * * * /path/to/yt-cart-main/detect_and_download.sh
    ```

You can start adding videos to the playlist to see if they appear after 5-10 minutes in `ROOT_DIR/downloads`.

## BONUS: Archiving old videos

Another issue I have run into with this carting system is that sometimes my folder is full of videos I no longer want to watch. To solve this, I created another script `archive_old_videos.sh` to move videos older than a week to a separate archive folder, so I can decide which to keep or delete.

If you already set up the `.env`, you can just also add `archive_old_videos.sh` to the cron jobs, with the retention date and scanning intervals you like.

1. Make the script is executable

    ```bash
    sudo chmod +x archive_old_videos.sh
    ```

2. Add it to your cron jobs. This example runs the script every day at 4AM.

    ```bash
    0 4 * * * /path/to/yt-cart-main/archive_old_videos.sh
    ```
