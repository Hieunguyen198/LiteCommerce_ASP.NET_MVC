$(document).ready(function () {
    loadData();
});
loadData = function(searchValue) {
    $.ajax({
        url: "/Category/List",
        data:{ searchValue: searchValue },
        type: "GET",
        contentType: "application/json",
        dataType: "json",
        success: function (result) {
            var html = '';
            var i = 1;
            $.each(result, function (key, item) {
                html += '<tr>';
                html += '<td>' + '<input type="checkbox" name="CategoryIDs" value=' + item.CategoryID + ' />' + '</td>';
                html += '<td>' + (i++) + '</td>';
                html += '<td>' + item.CategoryName + '</td>';
                html += '<td>' + item.Description + '</td>';
                html += '<td align="center"> <button type="button" onclick ="return getbyID(' + item.CategoryID + ') " class="btn btn-success mr-3"><i class="fa fa-edit"></i></button> <button type="button"   onclick = "return Delete(' + item.CategoryID + ') " class="btn btn-danger mr-3" type = "button" ><i class="fa fa-remove"></i></button ></td>';
                html += '</tr>';
            });
            $('.tbody').html(html);
        },
        error: function (errormessage) {
            alert(errormessage.responseText);
        }
    });
}  

function Add() {
    var obj = {
        CategoryName: $('#CategoryName').val(),
        Description: $('#Description').val(),
        CategoryID: $('#CategoryID').val(),
    };
    $.ajax({
        url: "/Category/Add",
        data: JSON.stringify(obj),
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        success: function (result) {
            var txtSearch = $("#searchValue").val();
            if (txtSearch != "") {
                loadData(txtSearch);
            } else {
                loadData();
            }
            $('#myModal').modal('hide');
        },
        error: function (errormessage) {
            alert(errormessage.responseText);
        }
    });
}

function getbyID(CategoryID) {
    $.ajax({
        url: "/Category/Input/" + CategoryID,
        typr: "GET",
        contentType: "application/json",
        dataType: "json",
        success: function (result) {
            $('#CategoryName').val(result.CategoryName);
            $('#Description').val(result.Description);
            $('#CategoryID').val(result.CategoryID);
            $('#myModal').modal('show');
            $('#btnUpdate').show();
            $('#btnAdd').hide();
        },
        error: function (errormessage) {
            alert(errormessage.responseText);
        }
    });
}

function Update() {
    var obj = {
        CategoryID: $('#CategoryID').val(),
        CategoryName: $('#CategoryName').val(),
        Description: $('#Description').val(),
    };
    $.ajax({
        url: "/Category/Input",
        data: JSON.stringify(obj),
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        success: function (result) {
            var txtSearch = $("#searchValue").val();
            if (txtSearch != "") {
                loadData(txtSearch);
            } else
            {
                loadData();
            }
            $('#myModal').modal('hide');
        },
        error: function (errormessage) {
            alert(errormessage.responseText);
        }
    });
}  


function Delete(CategoryID) {
    if (confirm('Do you really want delete this Category?')) {
        $.ajax({
            url: "/Category/Delete/" + CategoryID,
            type: "GET",
            contentType: "application/json",
            dataType: "json",
            success: function (result) {
                var txtSearch = $("#searchValue").val();
                if (txtSearch != "") {
                    loadData(txtSearch);
                } else {
                    loadData();
                }
            },
            error: function (errormessage) {
                alert(errormessage.responseText);
            }
        });
    }
}  

function clearTextBox() {
    $('#CategoryName').val("");
    $('#Description').val("");
}

$("#search").click(function () {
    var txtSearch = $("#searchValue").val();
    if (txtSearch != "") {
        loadData(txtSearch);
    }
    else {
        loadData();
    }

});
