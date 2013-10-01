# ObjectPatch

Please note this project isn't complete in either the generation or application
of patches.

ObjectPatch is a pure ruby implementation of [RFC6902
(JSON::Patch)](http://tools.ietf.org/rfc/rfc6902.txt) for standard hashes,
arrays, and scalar types. This will both generate patches as well as apply
them.

Rather than restricting end-users to the native JSON library, ObjectPatch only
operates on pure Ruby objects. These objects can be converted to a proper JSON
encoding using the standard JSON library or any other JSON compliant encoder.

The application of patches is based on
[Hana](http://github.com/tenderlove/hana). I greatly respect tenderlove but
disagreed with pieces of his implementation. I could have chosen to make pull
requests but since I was going to be extending the scope of the project I
decided to create my own project. At the very least it seemed like a fun
project to attempt.

The generation of patches attempts to do so in a way to minimize the size of
the patch, this is particularily difficult in arrays where the deletion of a
single element at the beginning may be hard to distinguish from the changing of
multiple values and the removal of the last.

## Installation

Add this line to your application's Gemfile:

    gem 'object_patch'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install object_patch

## Usage

TODO: Write usage instructions here

## RFC6902

One thing to note is that while referencing [RFC6902
(JSON::Patch)](http://tools.ietf.org/rfc/rfc6902.txt) it came to my attention
that the published RFC was missing a section that was part of the accepted
revision (specifically the appendix). The revision of the document that was
accepted by the IETF can be [found
here](http://tools.ietf.org/id/draft-ietf-appsawg-json-patch-10.txt). This was
gleaned from the public history of review of the RFC which is [available
here](https://datatracker.ietf.org/doc/rfc6902/history/).

I referenced the draft version 10 for any information available in the appendix
and the published version when the information was available there.

## Contributing

1. Fork it
2. Create your feature branch off of the current `develop` head (`git checkout
   -b my-new-feature origin/develop`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

I'll respond to all pull requests within two weeks, hopefully in under one.

