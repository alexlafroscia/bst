bst
===

A Python script to make BrowserStackTunnel a little easier to use

## Installation

1. Download the files from Github
2. Make `bst` executable by running

        chmod a+x path/to/bst
        
3. Run `bst`.  It assumes your server is running at localhost:3000 unless otherwise specified

That's it.

## Options

+ -a *accesskey*, --access_key *accesskey*

> Sets the specified *accesskey* as the key that `bst` will use to contact BrowserStack

+ -c, --clear_access_key

> Clears your BrowserStack access key

+ -g, --get_access_key

> Prints your BrowserStack access key

+ -j, --jar

> Remove, locate, or downlaod the BrowserStackTunnel.jar file

+ -s *server*, --server *server*

> Connects BrowserStack to the specified local server. Please see BrowserStack's documentation for the proper syntax.

+ -f *path/to/folder*, --file *path/to/folder*

> Connects BrowserStack to the specified local static site.  This should be the path to the FOLDER that the site lives in.

## Tips and Tricks

To make `bst` a little easier to use, I highly recomment symlinking to a location within your path.  The command would look something like this:

    sudo ln -s "path/to/bst" /bin/bst


## Road Map

- [x] Save your access key for later use
- [x] Optionally download the BrowserStackTunnel.jar file for you
- [x] Optionally provide the BrowserStackTunnel.jar file yourself
- [ ] Better control over the actual BrowserStackTunnel program
- [ ] Fetch the access key for you by providing your BrowserStack credentials


## About the Author

My name is [Alex LaFroscia](http://alexlafroscia.com).
If you want to chat, I'm [@alexlafroscia](http://twitter.com/alexlafroscia) on Twitter.
