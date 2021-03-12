$(document).ready(function () {
    loadData();
});

function loadData() {
    $.ajax({
        url: "/Category/List",
        type: "GET",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function (result) {
            var html = '';
            var i = 1;
            $.each(result, function (key, item) {
                html += '<tr>';
                html += '<td>' + '<input type="checkbox" name="customerIDs" value='+item.CategoryID+' />' + '</td>';
                html += '<td>' + (i++) + '</td>';
                html += '<td>' + item.CategoryName + '</td>';
                html += '<td>' + item.Description + '</td>';
                html += '<td> <a href="#" onclick ="return getbyID('+ item.CategoryID+') " class="btn btn-success mr-3"><i class="fa fa-edit"></i></a> <button name="customerIDs" value=' + item.CategoryID + ' class="btn btn-danger mr-3" type = "submit" ><i class="fa fa-remove"></i></button ></td>';
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
    };
    $.ajax({
        url: "/Category/Add",
        data: JSON.stringify(obj),
        type: "POST",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function (result) {
            loadData();
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
        contentType: "application/json;charset=UTF-8",
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
    return false;
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
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function (result) {
            loadData();
            $('#myModal').modal('hide');
            $('#CategoryID').val("");
            $('#CategoryName').val("");
            $('#Description').val("");
        },
        error: function (errormessage) {
            alert(errormessage.responseText);
        }
    });
}  