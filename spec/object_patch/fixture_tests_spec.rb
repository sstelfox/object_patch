
require 'spec_helper'

def run_test(t)
  return if t["disabled"]
end

describe ObjectPatch do
  JSONTestLoader.load_file('tenderlove_tests.json').each { |t| run_test(t) }
  JSONTestLoader.load_file('json-patch-tests/spec_tests.json').each { |t| run_test(t) }
  JSONTestLoader.load_file('json-patch-tests/tests.json').each { |t| run_test(t) }
end
