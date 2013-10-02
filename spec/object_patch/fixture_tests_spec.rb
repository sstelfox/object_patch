
require 'spec_helper'

def msg_to_exception(msg)
  puts "Received exception: #{msg}"
  case msg
  when /out of bounds/i; ObjectPatch::IndexError
  when /missing|non-existant/; ObjectPatch::MissingTargetError
  else; ObjectPatch::TestOperationFailed
  end
end

def run_test(t)
  pending "Disabled: #{t["comment"]}" if t["disabled"]

  !!t['error'] ? test_for_error(t) : test_success(t)
end

def test_for_error(t)
  it t["comment"] do
    excep = msg_to_exception(t["error"])
    patch = t["patch"]
    source_hash = t["doc"]

    expect { ObjectPatch.apply(source_hash, patch) }.to raise_error(msg_to_exception(t["error"]))
  end
end

def test_success(t)
  it t["comment"] do
    source_hash = t["doc"]
    patch = t["patch"]

    ObjectPatch.apply(source_hash, patch).should eq(t['expected'])
  end
end

describe ObjectPatch do
  JSONTestLoader.load_file('json-patch-tests/spec_tests.json').each { |t| run_test(t) }
  JSONTestLoader.load_file('json-patch-tests/tests.json').each { |t| run_test(t) }
  JSONTestLoader.load_file('tenderlove_tests.json').each { |t| run_test(t) }
end
