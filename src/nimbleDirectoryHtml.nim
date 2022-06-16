## nimblePackagesHtml.nim
## Nimble Packages Directory XML to HTML
## Author: Sergio Lima
## Created at: Jun, 16 2022
## How to compile for Linux:
##   nimblePackagesHtml$ nim c -d:ssl --verbosity:0 --hints:off -d:danger -d:lto --opt:speed src/nimblePackagesHtml.nim
## How to run
##   ./src/nimblePackagesHtml

import httpClient, xml, xml/selector

let url = "https://nimble.directory/packages.xml"
let xmlFileName = "assets/nimble_packages.xml"

proc downloadXmlFromNimbleDir(url, xmlFileName: string) =
  var client = newHttpClient()
  try:
    var file = system.open(xmlFileName, fmWrite)
    defer: file.close()
    file.write(client.getContent(url))
    echo("Success - downloaded to " & xmlFileName)
  except IOError as err:
    echo("Failed to download: " & err.msg)

proc readXmlFile(xmlFileName: string) =
  let xmlItemFields = 4
  var xml = q($system.readFile(xmlFileName))
  var seqXmlItems: seq[XmlNode]
  var arrayXmlItemFields = xml.select("item")

  for item in 0..arrayXmlItemFields.len-1:
    echo("-------------------------------------------")
    seqXmlItems = arrayXmlItemFields[0].select("^channel^item")
    for field in 0..xmlItemFields:
      echo seqXmlItems[field]

when isMainModule:
  downloadXmlFromNimbleDir(url, xmlFileName)
  readXmlFile(xmlFileName)
