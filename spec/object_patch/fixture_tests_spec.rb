
require 'spec_helper'

def msg_to_exception(msg)
  case msg
  when /Out of bounds/i then ArgumentError
  else then ArgumentError
  end
end

def run_test(t)
  pending "Disabled: #{t["comment"]}" if t["disabled"]

  !!t['error'] ? test_for_error(t) : test_success(t)
end

def test_for_error(t)
  source_hash = t["doc"]
  patch = t["patch"]

  expect { ObjectPatch.apply(source_hash, patch) }.to raise_error(msg_to_exception(t["error"]))
end

def test_success(t)
  source_hash = t["doc"]
  patch = t["patch"]

  ObjectPath.apply(source_hash, patch).should eq(t['expected'])
end

describe ObjectPatch do
  JSONTestLoader.load_file('json-patch-tests/spec_tests.json').each { |t| run_test(t) }
  JSONTestLoader.load_file('json-patch-tests/tests.json').each { |t| run_test(t) }
  JSONTestLoader.load_file('tenderlove_tests.json').each { |t| run_test(t) }
end
