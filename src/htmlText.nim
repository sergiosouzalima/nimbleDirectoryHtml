
func htmlPagePart1*: string =
  return """
<!DOCTYPE html>
<html lang="en-GB">
"""

func htmlPagePart2*: string =
  return """
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />

  <title>Home Page | Nimble Packages Directory</title>
  <meta name="description" content="Nimble Packages Directory." />
  <link rel="stylesheet" href="https://cdn.simplecss.org/simple.css" />
  <link rel="stylesheet" href="assets/css/style.css" />

  <link rel="icon" href="assets/images/favicon.png" />
  <link rel="apple-touch-icon" href="assets/images/favicon.png" />

  <!-- Facebook integration -->
  <meta property="og:title" content="Home Page" />
  <meta property="og:url" content="https://sergiosouzalima.dev" />
  <meta property="og:type" content="article" />
  <meta property="og:site_name" content="sergiosouzalima.dev" />
  <meta property="og:description" content="Nimble Packages Directory." />

  <!-- Twitter integration -->
  <meta name="twitter:card" content="summary_large_image" />
  <meta name="twitter:title" content="Home Page" />
  <meta name="twitter:url" content="sergiosouzalima.dev" />
  <meta name="twitter:description" content="Nimble Packages Directory." />
</head>
"""
func htmlPagePart3*: string =
  return """
  <body>
    <header>
      <nav>
        <a href="index.html">Home</a>

        <a href="https://nimble.directory/" target="_blank">Nimble Directory</a>

        <a href="https://www.nim-lang.org/" target="_blank">👑 Nim Language</a>
      </nav>

      <h1>Nim Package Directory</h1>
      <p>Are you a Nim 👑 developer? Search for packages or jump to a package page.</p>
    </header>

    <main>
      <div class="blog-item">
        <table>
          <thead>
  """

func htmlPagePart4*: string =
  return """
        </tbody>
      </table>
  </main>
  <footer>
    <p>
      This website was created with &#128151; by <a href="https://sergiosouzalima.dev">Sergio Lima</a>.
      Powered &#128170; by
      <a href="https://nim-lang.org/">Nim</a> & <a href="https://simplecss.org/">Simple.css</a>.
    </p>
  </footer>
</body>

</html>
"""
