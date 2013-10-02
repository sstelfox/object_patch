
require 'spec_helper'

describe ObjectPatch::Pointer do
  conversions = [
    [ [], '/' ],
    [ ['a/b'], '/a~1b' ],
    [ ['c%d'], '/c%d' ],
    [ ['e^f'], '/e^f' ],
    [ ['g|h'], '/g|h' ],
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
  end

  context "#unescape" do
    it "should unescape ~0 as ~" do
      ObjectPatch::Pointer.unescape("~0").should eq("~")
    end

    it "should unescape ~1 as /" do
      ObjectPatch::Pointer.unescape("~1").should eq("/")
    end

    it "should unescape ~s before /s to prevent double unrolling" do
      ObjectPatch::Pointer.unescape("~01").should eq("~1")
    end
  end
end

