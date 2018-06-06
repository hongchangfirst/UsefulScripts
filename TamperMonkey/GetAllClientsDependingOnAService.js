var allClientsData = getAllClients();
console.log("all clients number: " + allClientsData.length);
var result = NonTestFilter(allClientsData, 0);
console.log("all filtered clients number: " + result.length);

var xmlString = '<a id="downloadLink" onclick="clickDownload(this)" download="downlaod.csv" href="#">download</a>';
var bodys = document.getElementsByTagName("body");
// The link is on the top left of the page.
bodys[0].innerHTML = xmlString + bodys[0].innerHTML;
var aLink = document.getElementById("downloadLink");

// HTML part:
// <a id="test" onclick="clickDownload(this)" download="downlaod.csv" href="#">download</a>

// why there's a \ufeff?  The Unicode character U+FEFF is the byte order mark, or BOM, and is used to tell the difference between big- and little-endian UTF-16 encoding 
// https://stackoverflow.com/questions/17912307/u-ufeff-in-python-string
// if you use utf-8, don't need to set \ufeff.

aLink.onclick = function clickDownload(aLink) {
  var text = CSVTransformer(result);
  text =  encodeURIComponent(text);
  aLink.srcElement.href = "data:text/csv;charset=utf-8,"+text;
}; 

/*
// can't trigger without html element insertion. Will continue finding how to do this by pure js.
var xmlString = '<a id="test" onclick="clickDownload(this)" download="downlaod.csv" href="#">download</a>';
var parser = new DOMParser()
var aLink = parser.parseFromString(xmlString, "text/xml");
triggerDownload(aLink, result);

function triggerDownload(aLink, data) {
  var text = CSVTransformer(data);
  text =  encodeURIComponent(text);
  aLink.href = "data:text/csv;charset=utf-8,"+text;
}
*/


function CSVTransformer(data) {
  var text = "";
  for (var i = 0; i < data.length; ++i) {
    var row = data[i];
    for (var j = 0; j < row.length; ++j) {
      text += row[j];
      text += ",";
    }
    text = text.substring(0, text.length - 1);
    text += "\n";
  }
  return text;
}

// var result = NonTestFilter(allClientsData, 0);
function NonTestFilter(data, column) {
  var res = [];
  // i is index instead of value
  for (var i in data) {
    if (data[i][column].toLowerCase().search("test") < 0) {
      res.push(data[i]);
    }
  }
  return res;
}

function getAllClients() {
  var allClientsTable = document.getElementById("relationshipClientsTable");
  var allClientsRows = allClientsTable.rows;
  var totalLength = allClientsRows.length - 1;
  
  var allClientsData = new Array(totalLength);
  for (var i = 1; i < allClientsRows.length; ++i) {
    var row = allClientsRows[i];
    // the first td column is what we want.
    var clientURL = row.cells[0].innerHTML;
    var clientName = row.cells[0].innerText;
    var clientStatus = row.cells[3].innerText;
    allClientsData[i-1] = new Array(clientName, clientStatus);
  }

  return allClientsData;
}
