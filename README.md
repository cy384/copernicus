Copernicus
==========
A digital homage to the Raketa Kopernik mechanical watch, inspired by the orbits of the sun and the moon, with a few configurable features:

* Dark and light variants

* Enable/disable arbor

* Enable/disable seconds hand

It may be found [on the Garmin store](https://apps.garmin.com/en-US/apps/7f9c1277-ffb8-44f6-ab86-963ad88c85a6).

Build
-----
Follow the Garmin instructions for installing and configuring the SDK, along with Eclipse.  Note the key requirements, etc.  Unfortunately, you cannot, as far as I can tell, build the bundle necessary to submit to the Garmin store without using their Eclipse plugins (also the SDK tools don't seem to run on Ubuntu without fiddling anymore?).  This version builds with the ConnectIQ SDK version `3.0.11`.

After you do a build, you can deploy it locally by simply transferring the `.prg` file over USB to your device.

Open Source
-----------
I'm releasing this as open source in the hopes that someone may find it interesting or useful.  The only mildly clever feature in the code is scaling the sizes and locations of all things drawn on-screen based on the dimensions of the screen, and therefore effortlessly ported to all Garmin watches, regardless of shape and pixel count.

This code is covered by the included BSD 3-clause license (see LICENSE file).  Any patches, bug reports, or other user commments are greatly appreciated.  I will note that I personally consider this feature-complete, and am not likely to merge features that make the design more complicated.  Please feel free to fork if you plan on signficant additions.
