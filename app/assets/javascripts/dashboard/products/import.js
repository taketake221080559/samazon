function handleCSV(csv) {
    let reader = new FileReader();
    reader.onload = function() {
      let csvName = document.getElementById("product-import-csv-filename");
      console.log(reader)
      csvName.innerHTML = csv[0].name;
    }
    console.log(csv);
    reader.readAsDataURL(csv[0]);
  }
