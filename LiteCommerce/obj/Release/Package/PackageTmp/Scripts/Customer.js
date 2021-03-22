$(document).ready(function () {
    loadCustomerData(null,2);
});
loadCustomerData = function (searchValue,page) {
    $.ajax({
        url: "/Customer/List",
        data: { searchValue: searchValue , page:page },
        type: "GET",
        contentType: "application/json",
        dataType: "json",
        success: function (result) {
            var html = '';
            var i = 1;
            $.each(result, function (key, item) {
                html += '<tr>';
                html += '<td>' + '<input type="checkbox" name="CategoryIDs" value=' + item.CustomerID + '/>' + '</td>';
                html += '<td>' + (i++) + '</td>';
                html += '<td>' + '<i class="fa fa-user"></i> ' + item.ContactName + '(<i>' + item.ContactTitle + '</i>)' +
                                  '<br> ' + '<i class="fa fa-university"></i> ' + item.CompanyName + '</td>';
                html += '<td>' + '<i class="fa fa-address-card"></i>'+ item.Address+
                                '<br>'+'<i class="fa fa-address-book"></i>'+ item.City+'<br>'+'<i class="fa fa-globe"></i>'+item.Country + '</td>';
                html += '<td>' + '<i class="fa fa-phone"></i> '+item.Phone+
                    '<br>' + '<i class="fa fa-fax"></i> ' + item.Fax + '</td>';
                html += '<td> <a href="Customer/Input/'+item.CustomerID+'" class="btn btn-success mr-3"><i class="fa fa-edit"></i></a> <button type="submit" name="categoryIDs" value=' + item.CustomerID + ' onclick="return confirm("Do you really want to delete the this Category?")" class="btn btn-danger mr-3" type = "button" ><i class="fa fa-remove"></i></button ></td>';
                html += '</tr>';
            });
            $('.tCustomerbody').html(html);
        },
        error: function (errormessage) {
            alert(errormessage.responseText);
        }
    });
}  
function Add() {
    var obj = {
        CustomerID: $('#CustomerID').val(),
        CompanyName: $('#CompanyName').val(),
        ContactName: $('#ContactName').val(),
        ContactTitle: $('#ContactTitle').val(),
        CategoryID: $('#Address').val(),
        CategoryID: $('#Phone').val(),
        CategoryID: $('#fax').val(),
    };
    $.ajax({
        url: "/Customer/Add",
        data: JSON.stringify(obj),
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        success: function (result) {
            loadCustomerData();
            $('#myCustomerModal').modal('hide');
        },
        error: function (errormessage) {
            alert(errormessage.responseText);
        }
    });
}