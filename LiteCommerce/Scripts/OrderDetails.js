$(document).ready(function () {
    
});
function getDetailByID(OrderID) {
    $.ajax({
        url: "/Order/GetOrderDetailByID",
        data: { OrderID: OrderID },
        type: "GET",
        contentType: "application/json",
        dataType: "json",
        success: function (result) {
            console.log(result);
            var total = 0;
            var html = '';
            var i = 1;
            $.each(result, function (key, item) {
                total += ((item.UnitPrice * item.Quantity) - (item.UnitPrice * item.Quantity) * item.Discount);
                html += '<tr>';
                html += '<td>' + (i++) + '</td>';
                html += '<td>' + item.ProductName + '</td>';
                html += '<td>' + item.UnitPrice + '</td>';
                html += '<td>' + item.Quantity + '</td>';
                html += '<td>' + item.Discount + '</td>';
                html += '<td>' +'<strong style="color:red">'+ ((item.UnitPrice * item.Quantity) - (item.UnitPrice * item.Quantity) * item.Discount) +'</strong>'+ '</td>';
                html += '</tr>';
            });
            console.log(total);
            $('.ordertfoot').append('<strong style="color:red">'+total+'</strong>');
            $('.ordertbody').html(html);
            $('#OrderModal').modal('show');
        },
        error: function (errormessage) {
            alert(errormessage.responseText);
        }
    });
}