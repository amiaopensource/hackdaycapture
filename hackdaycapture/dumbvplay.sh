#!/bin/bash
pixel="$1"
video_input="$2"
audio_input="$3"

/usr/local/bin/bmdcapture -m 0 -V "${video_input}" -A "${audio_input}" -c 8 -s 32 -p "${pixel}" -F nut -f pipe:1 | \
        /usr/local/bin/ffplay -v info -hide_banner -stats -i - \
        -vf "split=5[a][b][c][d][e];\
        [b]field=top[b1];\
        [c]field=bottom[c1];\
        [b1]histogram=step=20:mode=waveform:waveform_mode=column:waveform_mirror=1,\
        crop=iw:256:0:0,\
        drawbox=y=(256-16):w=iw:h=16:color=aqua@0.3:t=16,\
        drawbox=w=iw:h=(256-235):color=crimson@0.3:t=16[b2];\
        [c1]histogram=step=20:mode=waveform:waveform_mode=column:waveform_mirror=1,\
        crop=iw:256:0:0,\
        drawbox=y=(256-16):w=iw:h=16:color=aqua@0.3:t=16,\
        drawbox=w=iw:h=(256-235):color=crimson@0.3:t=16[c2];\
        [b2][c2]framepack=tab,format=yuv422p[bc1];\
        [a]pad=iw+512:ih+512[a1];\
        [d]histogram=mode=color2,lutyuv=y=val*5,\
        transpose=dir=2,\
        scale=512:512,\
        drawgrid=w=32:h=32:t=1:c=white@0.1,\
        drawgrid=w=256:h=256:t=1:c=white@0.2,\
        drawbox=w=9:h=9:t=1:x=180-3:y=512-480-5:c=red@0.6,\
        drawbox=w=9:h=9:t=1:x=108-3:y=512-68-5:c=green@0.6,\
        drawbox=w=9:h=9:t=1:x=480-3:y=512-220-5:c=blue@0.6,\
        drawbox=w=9:h=9:t=1:x=332-3:y=512-32-5:c=cyan@0.6,\
        drawbox=w=9:h=9:t=1:x=404-3:y=512-444-5:c=magenta@0.6,\
        drawbox=w=9:h=9:t=1:x=32-3:y=512-292-5:c=yellow@0.6,\
        drawbox=w=9:h=9:t=1:x=199-3:y=512-424-5:c=red@0.8,\
        drawbox=w=9:h=9:t=1:x=145-3:y=512-115-5:c=green@0.8,\
        drawbox=w=9:h=9:t=1:x=424-3:y=512-229-5:c=blue@0.8,\
        drawbox=w=9:h=9:t=1:x=313-3:y=512-88-5:c=cyan@0.8,\
        drawbox=w=9:h=9:t=1:x=367-3:y=512-397-5:c=magenta@0.8,\
        drawbox=w=9:h=9:t=1:x=88-3:y=512-283-5:c=yellow@0.8,\
        drawbox=w=9:h=9:t=1:x=128-3:y=512-452-5:c=sienna@0.8,\
        drawbox=w=9:h=9:t=1:x=160-3:y=512-404-5:c=sienna@0.8,\
        drawbox=w=9:h=9:t=1:x=192-3:y=512-354-5:c=sienna@0.8,\
        drawbox=w=9:h=9:t=1:x=224-3:y=512-304-5:c=sienna@0.8[d1];\
        [e]signalstats=out=brng,scale=512:486[e1];\
        [a1][bc1]overlay=0:486[abc1];\
        [abc1][d1]overlay=720:486[abcd1];\
        [abcd1][e1]overlay=720:0[out]"
        