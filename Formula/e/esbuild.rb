require "language/node"

class Esbuild < Formula
  desc "Extremely fast JavaScript bundler and minifier"
  homepage "https://esbuild.github.io/"
  url "https://registry.npmjs.org/esbuild/-/esbuild-0.19.9.tgz"
  sha256 "2c6bb0897593130fa75ad46ce7ba8a498fa4b00ee4a13d0c3d71f2046d33a3fe"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "1af41f4a2cd7e6e86a86197d8d367414b3204d123b95bccb970617f299b5b9cc"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "1af41f4a2cd7e6e86a86197d8d367414b3204d123b95bccb970617f299b5b9cc"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1af41f4a2cd7e6e86a86197d8d367414b3204d123b95bccb970617f299b5b9cc"
    sha256 cellar: :any_skip_relocation, sonoma:         "9e46145d872b4f96b6eebae95a775dd32586122b53a1590e5d66d5e769e4b564"
    sha256 cellar: :any_skip_relocation, ventura:        "9e46145d872b4f96b6eebae95a775dd32586122b53a1590e5d66d5e769e4b564"
    sha256 cellar: :any_skip_relocation, monterey:       "9e46145d872b4f96b6eebae95a775dd32586122b53a1590e5d66d5e769e4b564"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f4c52398cd06bf367ed332f2af1efce89fa68f16d3b4237ebf67edff62d9ec11"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"app.jsx").write <<~EOS
      import * as React from 'react'
      import * as Server from 'react-dom/server'

      let Greet = () => <h1>Hello, world!</h1>
      console.log(Server.renderToString(<Greet />))
    EOS

    system Formula["node"].libexec/"bin/npm", "install", "react", "react-dom"
    system bin/"esbuild", "app.jsx", "--bundle", "--outfile=out.js"

    assert_equal "<h1>Hello, world!</h1>\n", shell_output("node out.js")
  end
end
