$(document).ready(function () {
    LoadDasboard();
});
$('#OrderStatistic').change(LoadDasboard = function () {
    var year = $("#OrderStatistic").val();
    $.ajax({
        type: "GET",
        url: "/Dashboard/Input",
        data: "year=" + year,
        contentType: "application/json",
        dataType: "json",
        success: function (result) {
            var ctx = document.getElementById('myChart').getContext('2d');
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
                    var chart = new Chart(ctx, {
                        type: 'line',
                        data: {
                            labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                            datasets: [{
                                label: 'Monthly revenue Chart in ' + year,
                                backgroundColor:'rgba(0, 255, 255)',   
                                borderColor: 'rgb(0, 0, 255)',
                                data: [dashboard.January, dashboard.February, dashboard.March, dashboard.April, dashboard.May, dashboard.June, dashboard.July, dashboard.August, dashboard.September, dashboard.October, dashboard.November, dashboard.December]
                            }]
                        },
                    });
                });

                $('#titleChart').html('Sales: 1 Jan ' + year + ' - 30 Dec '+year);
            }
            else {
                alert("Non data!");
            }
        }
    });
});
