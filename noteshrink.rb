# Documentation: https://docs.brew.sh/Formula-Cookbook
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
 class Noteshrink < Formula
  include Language::Python::Virtualenv
  desc "Convert scans of handwritten notes to beautiful, compact PDFs"
  homepage "https://mzucker.github.io/2016/09/20/noteshrink.html"
  url "https://github.com/mzucker/noteshrink/archive/0.1.1.tar.gz"
  version "0.1.1"
  sha256 "2a29c09768973e688b693b61337c6c49384e8123cf88824dba335cc8c4ed2ca8"

  depends_on "python"
  depends_on "numpy"
  depends_on "scipy"
  depends_on "imagemagick"

  resource "image" do
    url "https://files.pythonhosted.org/packages/5a/f5/47025a3dabe2188a7f1416c3054f4ae7597543b18e2c1acecbdb2f18180a/image-1.5.19.tar.gz"
    sha256 "e70b88ae06cc1cb8b691fa00dc51f702b90a8a3ce13fb12a06e48ae44874f274"
  end

  def install
      virtualenv_install_with_resources
      bin.install "noteshrink.py"
  end
end
