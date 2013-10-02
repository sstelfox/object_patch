
require 'spec_helper'

describe ObjectPatch::Pointer, :focus do
  conversions = [
    [ [], '/' ],
    [ ['a/b'], '/a~1b' ],
    [ ['c%d'], '/c%d' ],
    [ ['e^f'], '/e^f' ],
    [ ['g|h'], '/g|h' ],
    [ ['~01'], '/~1' ],
    [ ['i\\j'], '/i\\j' ],
    [ ['k\"l'], '/k\"l' ],
    [ [' '], '/ ' ],
    [ ['m~n'], '/m~0n' ],
    [ ['test', 1], '/test/1' ],
  ]

  conversions.each do |c|
    it "should encode #{c.first} as #{c.last}" do
      ObjectPatch::Pointer.encode(c.first).should eq(c.last)
    end
    
    it "should decode #{c.last} as #{c.first}" do
      ObjectPatch::Pointer.parse(c.last).should eq(c.first)
    end
  end

  context "#escape" do
    it "should escape ~ as ~0" do
      ObjectPatch::Pointer.escape("~").should eq("~0")
    end

    it "should escape / as ~1" do
      ObjectPatch::Pointer.escape("/").should eq("~1")
    end

    it "should escape ~s before /s to prevent reencoding the new ~s" do
      ObjectPatch::Pointer.escape("/~").should eq("~1~0")
    end
  end
end

