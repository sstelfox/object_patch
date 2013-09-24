# ObjectPatch

ObjectPatch is a pure ruby implementation of [RFC6902
(JSON::Patch)](http://tools.ietf.org/rfc/rfc6902.txt) for standard hashes,
arrays, and scalar types. This will both generate patches as well as apply
them.

Rather than restricting end-users to the native JSON library, ObjectPatch only
operates on pure Ruby objects. These objects can be converted to a proper JSON
encoding using the standard JSON library or any other JSON compliant encoder.

Unlike some of the similar projects out there, this strictly follows the
mentioned RFCs including [RFC6901](http://tools.ietf.org/rfc/rfc6902.txt).

## Installation

Add this line to your application's Gemfile:

    gem 'object_patch'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install object_patch

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch off of the current `develop` head (`git checkout
   -b my-new-feature origin/develop`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

I'll respond to all pull requests within two weeks, hopefully in under one.
