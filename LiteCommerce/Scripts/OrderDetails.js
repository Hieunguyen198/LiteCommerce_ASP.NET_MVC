function getDetailByID(OrderID) {
    $.ajax({
        url: "/Order/GetOrderDetailByID",
        data: { OrderID: OrderID },
        type: "GET",
        contentType: "application/json",
        dataType: "json",
        success: function (result) {
            var total = 0;
            var html = '';
            var i = 1;
            $.each(result, function (key, item) {
                total += ((item.UnitPrice * item.Quantity) - (item.UnitPrice * item.Quantity) * item.Discount);
                html += '<tr>';
                html += '<td>' + (i++) + '</td>';
                html += '<td>' + item.ProductName + '</td>';
                html += '<td>' + item.UnitPrice + '$</td>';
                html += '<td>' + item.Quantity + '</td>';
                html += '<td>' + item.Discount + '</td>';
                html += '<td>' +'<strong style="color:red">'+ ((item.UnitPrice * item.Quantity) - (item.UnitPrice * item.Quantity) * item.Discount) +'$</strong>'+ '</td>';
                html += '</tr>';
            });    
            var html1 = '';
            html1 += '<tr>';
                html1 += '<td colspan="5" style="text-align:right" >' + '<strong style="color:red">Total amount:'+ '</strong>'+ '</td>';
            html1 += '<td>' + '<strong style="color:red;">'+ total + '$</strong>' + '</td>';
            html1 += '</tr>';
            $('#ordertfoot').html(html1);
            $('.ordertbody').html(html);       
            $('#OrderModal').modal('show');
        },
        error: function (errormessage) {
            alert(errormessage.responseText);
        }
    });
}