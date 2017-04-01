hackdaycapture
==============
GUI for Mac | Tested on UltraStudio Express, Blackmagic hardware. 

__Dependency install instructions:__

_Install from BlackMagic website_

Blackmagic SDK

https://www.blackmagicdesign.com/support

Blackmagic Desktop Video (10.2.1 is tested)

If you don't have it already, install Homebrew:

https://brew.sh/

Install BMDTools:

https://github.com/lu-zero/bmdtools

`brew tap amiaopensource/amiaos`

`brew install bmdtools` 

Install FFmpeg with ffplay:

`brew install ffmpeg --with-sdl2 --with-openjpeg`

__Options within the tool__

_Container options:_

* MKV
* MOV
* AVI
* MXF

_Codec options:_

* FFV1 (does not work with MXF)
* JPEG-2000
* ProRes
* Uncompressed 

__Choice of 8 bit or 10 bit (except ProRes, will default and only capable of 10 bit)__

__Audio output is always two audio tracks, with stereo audio.__
