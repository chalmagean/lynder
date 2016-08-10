require 'spec_helper'

# We need this for compatibility reasons between Ruby 2.3 and FakeFS
require 'pp'

describe Lynder do
  include FakeFS::SpecHelpers

  it 'has a version number' do
    expect(Lynder::VERSION).not_to be nil
  end

  it 'does something useful' do
    files = [
      "file-name-431622.mp4",
      "file-name-431615.mp4",
      "file-name-431614.mp4",
      "file-name-431616.mp4",
      "file-name-431628.mp4"
    ]

    FileUtils.touch(files)
    Lynder::Rename.reorder!

    expected = [
      "001. file-name-431614.mp4",
      "002. file-name-431615.mp4",
      "003. file-name-431616.mp4",
      "004. file-name-431622.mp4",
      "005. file-name-431628.mp4"
    ]

    files_in_current_dir = Dir.glob('*').map { |f| f.gsub(/^\//, '') }
    expect(files_in_current_dir).to eq(expected)
  end
end
