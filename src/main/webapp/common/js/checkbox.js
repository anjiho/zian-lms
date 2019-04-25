function getBookMainCheckbox(resKey) {
    var bookMainCheckbox = "";
    bookMainCheckbox     += " <div class='col-sm-10'>";
    bookMainCheckbox     += " <div style=\"margin-top: -23px;\">";
    bookMainCheckbox     += "부교재";
    bookMainCheckbox     += " <label class=\"switch\">";
    bookMainCheckbox     += " <input type='checkbox' id='isBookMain_"+ resKey + "' style='display:none;' >";
    bookMainCheckbox     += "<span class=\"slider\" ></span>";
    bookMainCheckbox     += "</label>";
    bookMainCheckbox     += "주교재";
    bookMainCheckbox     += "  </div>";
    bookMainCheckbox     += "</div>";
    return bookMainCheckbox;
}
