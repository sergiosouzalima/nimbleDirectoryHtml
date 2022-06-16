## nimbleDirectoryHtml.nim
## Nimble Packages Directory XML to HTML
## Author: Sergio Lima
## Created at: Jun, 16 2022
## How to compile for Linux:
##   nimbleDirectoryHtml$ nim c -d:ssl --verbosity:0 --hints:off -d:danger -d:lto --opt:speed src/nimbleDirectoryHtml.nim
## How to run
##   ./src/nimbleDirectoryHtml

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

proc writeHTMLTableRow(seqXmlItems: seq[XmlNode] ): string =
    var pkgName = seqXmlItems[0].text
    var pkgDescription = seqXmlItems[1].text
    var pkgLink = seqXmlItems[2].text
    var pkgUpdatedAt = seqXmlItems[4].text
    result &= "<tr>\n"
    result &= "  <td>" & pkgName & "</td>\n"
    result &= "  <td font-size: 1.15rem;>" & pkgDescription & "</td>\n"
    result &= "  <td><link><a href=\"" & pkgLink & "\" target=\"_blank\">" & pkgLink & "</a></link></td>\n"
    result &= "  <td>" & pkgUpdatedAt & "</td>\n"
    result &= "</tr>"

proc createHtmlItemsFromXML(xmlFileName: string) =
  var xml = q($system.readFile(xmlFileName))
  var arrayXmlItemFields = xml.select("item")
  let itemsFile = open("items.html", fmWrite)
  defer: itemsFile.close()
  for item in 0..arrayXmlItemFields.len-1:
    let seqXmlItems = arrayXmlItemFields[item].select("^channel^item")
    let strHtmlLine = writeHTMLTableRow(seqXmlItems)
    itemsFile.writeLine(strHtmlLine)

when isMainModule:
  downloadXmlFromNimbleDir(url, xmlFileName)
  createHtmlItemsFromXML(xmlFileName)
