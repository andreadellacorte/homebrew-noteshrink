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

  resource "Pillow" do
    url "https://files.pythonhosted.org/packages/0f/57/25be1a4c2d487942c3ed360f6eee7f41c5b9196a09ca71c54d1a33c968d9/Pillow-5.0.0.tar.gz"
    sha256 "12f29d6c23424f704c66b5b68c02fe0b571504459605cfe36ab8158359b0e1bb"
  end

  def install
      virtualenv_install_with_resources
      bin.install "noteshrink.py"
  end
end
