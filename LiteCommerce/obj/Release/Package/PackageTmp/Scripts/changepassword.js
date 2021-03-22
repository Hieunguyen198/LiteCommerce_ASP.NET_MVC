$(document).ready(function () {
    $('#subChange').click(function (e) {
        e.preventDefault();
        $('#resultcurrentpassword').html("");
        $('#resultconfirmpassword').html("");
        $('#resultnewpassword').html("");
        if ($('#currentpassword').val() != "" && $('#newpassword').val() != "" && $('#confirmpassword').val() != "") {
            var data = {
                "id": $("#userID").val(),
                "newPWd": $("#newpassword").val(),
                "currentPWd": $("#currentpassword").val()
            };
            if ($('#newpassword').val() == $('#confirmpassword').val()) {
                $.ajax({
                    type: "POST",
                    url: "/Account/ChangePassword",
                    contentType: "application/json",
                    dataType: "json",
                    data: JSON.stringify(data),
                    success: function (response) {
                        console.log(response);
                        if (response.status == true) {
                            $('#newpassword').val("");
                            $('#currentpassword').val("");
                            $('#confirmpassword').val("");
                            alert("Update password success!");
                        }
                        else {
                            $('#resultcurrentpassword').html('<i class="fa fa-exclamation-circle"></i> current password not right');
                        }
                    }
                });
            }
            else {
                $('#resultconfirmpassword').html('<i class="fa fa-exclamation-circle"></i> Confirm password not right!');
            }
        } else {
            $('#resultcurrentpassword').html('<i class="fa fa-exclamation-circle"></i> Please fill out the field');
            $('#resultconfirmpassword').html('<i class="fa fa-exclamation-circle"></i> Please fill out the field');
            $('#resultnewpassword').html('<i class="fa fa-exclamation-circle"></i> Please fill out the field');
        }
    });    
});
