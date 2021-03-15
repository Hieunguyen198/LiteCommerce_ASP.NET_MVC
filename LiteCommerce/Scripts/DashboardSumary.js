$('#OrderStatistic').change(function () {
    var year = $("#OrderStatistic").val();
    $.ajax({
        type: "GET",
        url: "/Dashboard/Input",
        data: "year=" + year,
        contentType: "application/json",
        dataType: "json",
        success: function (result) {
            console.log(result);
            if (result != null) {
                $('td').remove();
                $.each(result, function (index, dashboard) {
                    $('.TTotal').text(dashboard.January + dashboard.February + dashboard.March + dashboard.April + dashboard.May + dashboard.June + dashboard.July + dashboard.August +
                        dashboard.September + dashboard.October + dashboard.November + dashboard.December + '$');
                    $('#titleThongKe').text('STATISTICS OF MONTHLY REVENUE IN ' + year)
                    $('#OrderStatistics').append("<td>" + dashboard.January + "$" + "</td>");
                    $('#OrderStatistics').append("<td>" + dashboard.February + "$" + "</td>");
                    $('#OrderStatistics').append("<td>" + dashboard.March + "$" + "</td>");
                    $('#OrderStatistics').append("<td>" + dashboard.April + "$" + "</td>");
                    $('#OrderStatistics').append("<td>" + dashboard.May + "$" + "</td>");
                    $('#OrderStatistics').append("<td>" + dashboard.June + "$" + "</td>");
                    $('#OrderStatistics').append("<td>" + dashboard.July + "$" + "</td>");
                    $('#OrderStatistics').append("<td>" + dashboard.August + "$" + "</td>");
                    $('#OrderStatistics').append("<td>" + dashboard.September + "$" + "</td>");
                    $('#OrderStatistics').append("<td>" + dashboard.October + "$" + "</td>");
                    $('#OrderStatistics').append("<td>" + dashboard.November + "$" + "</td>");
                    $('#OrderStatistics').append("<td>" + dashboard.December + "$" + "</td>");
                });
            }
            else {
                alert("Non data!");
            }
        }
    });
});