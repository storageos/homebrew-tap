require "language/go"

class Relay < Formula  
  desc "Client for StorageOS - enterprise persistent storage for containers and the cloud"
  homepage "https://storageos.com"
  url "https://github.com/storageos/go-cli.git",
    :tag => "0.0.10",
    :revision => "56a378eb87c3e45ddcf2f767ba09e2c401b53c1a"

  head "https://github.com/storageos/go-cli.git"

  depends_on "go" => :build

  def install    
    contents = Dir["{*,.git,.gitignore}"]
    gopath = buildpath/"gopath"
    (gopath/"src/github.com/storageos/go-cli").install contents
    ENV["GOPATH"] = gopath
    ENV.prepend_create_path "PATH", gopath/"bin"

    cd gopath/"src/github.com/storageos/go-cli" do
        system "make", "build"
        bin.install "cmd/storageos/storageos"        
    end
  end

  test do
    system "#{bin}/storageos", "--help"
  end
end