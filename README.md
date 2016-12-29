git-resource-fork-hooks
=======================
by Morgan Aldridge <morgant@makkintosshu.com>

OVERVIEW
--------

Client-side hooks for Git projects containing old Mac HFS/HFS+ resource forks. I tossed this together for doing some [NewtonScript](http://newtonscript.org/) development in NTK under MacOS 7.x, but it would also be useful for old MPW/CodeWarrior/ThinkC/etc. projects, or any other old Mac files with resource forks.

It performs its magic by using OS X's `SplitForks` & `FixupResourceForks` to split the resource forks off into AppleDouble format (`._` files) prior to committing to the Git repo (otherwise Git would just ignore the resource forks, rendering the files incomplete if you were to checkout a fresh copy), then converting them back to resource forks upon any merge/update/etc.

INSTALLING
----------

1. Install Xcode Command Line Tools, if you haven't already done so.
2. ...
3. Profit

FURTHER READING
---------------

* The [Dash-Board-for-Newton-OS README](https://github.com/masonmark/Dash-Board-for-Newton-OS/blob/master/README.md) for an exciting look behind the scenes of recovering & releasing the source code for NewtonOS software on GitHub (touching on the resource forks issue, of course.)
* [AppleDouble format on ArchiveTeam.org](http://fileformats.archiveteam.org/wiki/AppleDouble)
* [Git Hooks documentation](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)

LICENSE
-------

_TBD_

Copyright (c) 2016 Morgan T. Aldridge. All Rights Reserved.
