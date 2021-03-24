$(document).ready(function () {
    LoadDasboard();
});
$('#OrderStatistic').change(LoadDasboard = function () {
    var year = $("#OrderStatistic").val();
    if (year == null) {
        year = 2021;
    }
    const url = 'http://localhost:49990/api/Dashboard/GetRevenueByYear?year=' + year;
    const url1 = 'http://localhost:49990/api/Dashboard/GetDiscountStatisticsByYear?year=' + year;
    const url2 = 'http://localhost:49990/api/Dashboard/GetOrderStaticByYear?year=' + year;
    var sumR = 0;
    var sumD = 0;
    var sumO = 0;
    fetch(url2)
        .then((response) => response.json())
        .then((data) => {
            sumO = data.January + data.February + data.March + data.April + data.May + data.June + data.July + data.August + data.September + data.October + data.November + data.December;
        })
    fetch(url1)
        .then((response) => response.json())
        .then((data) => { sumD=data.January + data.February + data.March + data.April + data.May + data.June + data.July + data.August + data.September + data.October + data.November + data.December ;
                         })
    var ctx = document.getElementById('myChart').getContext('2d');
    fetch(url)
        .then((response) => response.json())
        .then((data) => {
            $('td').remove();
            sumR = data.January + data.February + data.March + data.April + data.May + data.June + data.July + data.August + data.September + data.October + data.November + data.December;
            $('.Torder').text(sumO);
            $('.TTotal').text(sumR + '$');
            $('.Tdiscount').text(sumD + '$');
            $('.TRevenue').text(sumR - sumD + '$');
            $('#titleThongKe').text('STATISTICS OF MONTHLY REVENUE IN ' + year)
            $('#titleChart').html('Sales: 1 Jan ' + year + ' - 30 Dec ' + year);
            $('#OrderStatistics').append("<td>" + data.January + "$" + "</td>");
            $('#OrderStatistics').append("<td>" + data.February + "$" + "</td>");
            $('#OrderStatistics').append("<td>" + data.March + "$" + "</td>");
            $('#OrderStatistics').append("<td>" + data.April + "$" + "</td>");
            $('#OrderStatistics').append("<td>" + data.May + "$" + "</td>");
            $('#OrderStatistics').append("<td>" + data.June + "$" + "</td>");
            $('#OrderStatistics').append("<td>" + data.July + "$" + "</td>");
            $('#OrderStatistics').append("<td>" + data.August + "$" + "</td>");
            $('#OrderStatistics').append("<td>" + data.September + "$" + "</td>");
            $('#OrderStatistics').append("<td>" + data.October + "$" + "</td>");
            $('#OrderStatistics').append("<td>" + data.November + "$" + "</td>");
            $('#OrderStatistics').append("<td>" + data.December + "$" + "</td>");

            var chart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    datasets: [{
                        label: 'Monthly revenue Chart in ' + year,
                        backgroundColor: 'rgba(0, 255, 255)',
                        borderColor: 'rgb(0, 0, 255)',
                        data: [data.January, data.February, data.March, data.April, data.May, data.June, data.July, data.August, data.September, data.October, data.November, data.December]
                    }]
                },
            });
        })
});
