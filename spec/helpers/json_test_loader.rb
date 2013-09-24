
TEST_DIR = File.expand_path('../../', __FILE__)

module JSONTestLoader
  # Load a JSON test file for auto generation of tests based on IETF tests, my
  # own, and some from tenderlove.
  #
  # @param [String] path Path to the fixture from root of the fixtures
  #   directory, should not have a path at the beginning or the end.
  # @return [Array<Hash>] The tests
  def load_file(path)
    JSON.parse(File.read(File.join(TEST_DIR, 'fixtures', path)))
  end

  module_function :load_file
end

