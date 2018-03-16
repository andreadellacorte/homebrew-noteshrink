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

  depends_on "python@2" if MacOS.version <= :snow_leopard
  depends_on "gcc"
  depends_on "imagemagick"
  depends_on "libtiff"
  depends_on "libjpeg"
  depends_on "freetype"
  depends_on "jpeg"
  depends_on "webp"
  depends_on "little-cms2"

  resource "Pillow" do
    url "https://files.pythonhosted.org/packages/0f/57/25be1a4c2d487942c3ed360f6eee7f41c5b9196a09ca71c54d1a33c968d9/Pillow-5.0.0.tar.gz"
    sha256 "12f29d6c23424f704c66b5b68c02fe0b571504459605cfe36ab8158359b0e1bb"
  end

  resource "numpy" do
    url "https://files.pythonhosted.org/packages/0b/66/86185402ee2d55865c675c06a5cfef742e39f4635a4ce1b1aefd20711c13/numpy-1.14.2.zip"
    sha256 "facc6f925c3099ac01a1f03758100772560a0b020fb9d70f210404be08006bcb"
  end

  resource "scipy" do
    url "https://pypi.python.org/packages/34/ac/f793c8f18b6f188788b37aae02d94689ac8df317f09a681a3a61ecc466ab/scipy-0.13.0.tar.gz"
    sha256 "e7fe93ffc4b55d8357238406b1b9e47a4f932474238e2bfdb552423bcd45dc5e"
  end

  def install
    venv = virtualenv_create(libexec)

    resource("Pillow").stage do
      inreplace "setup.py" do |s|
        sdkprefix = MacOS::CLT.installed? ? "" : MacOS.sdk_path
        s.gsub! "openjpeg.h", "probably_not_a_header_called_this_eh.h"
        s.gsub! "ZLIB_ROOT = None", "ZLIB_ROOT = ('#{sdkprefix}/usr/lib', '#{sdkprefix}/usr/include')"
        s.gsub! "JPEG_ROOT = None", "JPEG_ROOT = ('#{Formula["jpeg"].opt_prefix}/lib', '#{Formula["jpeg"].opt_prefix}/include')"
        s.gsub! "FREETYPE_ROOT = None", "FREETYPE_ROOT = ('#{Formula["freetype"].opt_prefix}/lib', '#{Formula["freetype"].opt_prefix}/include')"
      end

      begin
        # avoid triggering "helpful" distutils code that doesn't recognize Xcode 7 .tbd stubs
        deleted = ENV.delete "SDKROOT"
        ENV.append "CFLAGS", "-I#{MacOS.sdk_path}/System/Library/Frameworks/Tk.framework/Versions/8.5/Headers" unless MacOS::CLT.installed?
        venv.pip_install Pathname.pwd
      ensure
        ENV["SDKROOT"] = deleted
      end
    end

    res = resources.map(&:name).to_set - ["Pillow"]

    res.each do |r|
      venv.pip_install resource(r)
    end

    venv.pip_install_and_link buildpath
    bin.install "noteshrink.py"
  end
end
