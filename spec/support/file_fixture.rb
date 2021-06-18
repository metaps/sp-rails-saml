module FileFixture
  def file_fixture(relative_path)
    root = File.expand_path('../fixtures', __dir__)
    path = File.join(root, relative_path)
    File.read(path)
  end
end

RSpec.configure do |config|
  config.include FileFixture
end
