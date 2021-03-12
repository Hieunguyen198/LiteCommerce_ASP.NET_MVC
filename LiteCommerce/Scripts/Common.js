

$("#selectAll").click(function () {
    $("input[type=checkbox]").prop("checked", $(this).prop("checked"));
});

$("input[type=checkbox]").click(function () {
    if (!$(this).prop("checked")) {
        $("#selectAll").prop("checked", false);
    }
});

document.getElementById("my_input_file").onchange = function () {
            var reader = new FileReader();
            reader.onload = function (e) {
        document.getElementById("showThumb").src = e.target.result;
    };
    reader.readAsDataURL(this.files[0]);
};