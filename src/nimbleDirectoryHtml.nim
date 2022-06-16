## nimbleDirectoryHtml.nim
## Nimble Packages Directory XML to HTML
## Author: Sergio Lima
## Created at: Jun, 16 2022
## How to compile for Linux:
##   nimbleDirectoryHtml$ nim c -d:ssl --verbosity:0 --hints:off -d:danger -d:lto --opt:speed src/nimbleDirectoryHtml.nim
## How to run
##   ./src/nimbleDirectoryHtml

import httpClient, xml, xml/selector, strutils

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

func updatedAtFormat(updatedAt: string):string =
  var updatedSplit = updatedAt.split
  return updatedSplit[1] & "/" & updatedSplit[2] & "/" & updatedSplit[3] & " " & updatedSplit[4]

func writeHTMLTableRow(seqXmlItems: seq[XmlNode] ): string =
    var pkgDescription = seqXmlItems[1].text
    var pkgLink = seqXmlItems[2].text
    var pkgShowLink = pkgLink.split("/")[4]
    var pkgUpdatedAt = seqXmlItems[4].text.updatedAtFormat
    result &= "<tr>\n"
    result &= "  <td><link><a href=\"" & pkgLink & "\" target=\"_blank\">" & pkgShowLink & "</a></link></td>\n"
    result &= "  <td class=\"cell-breakWord\">" & pkgDescription & "</td>\n"
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
