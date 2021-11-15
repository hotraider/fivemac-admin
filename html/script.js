fivemac = {}

$(function() {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })

    $("#yazi").click(function() {
        let inputValue = $("#yazi").val()
        return;
    })
})

$(document).on('keydown', function() {
    switch (event.keyCode) {
        case 27:
            fivemac.Close();
            break;
    }
});

fivemac.Close = function() {
    $("#container").fadeOut(175);
    $.post('http://fivemac-admin/close');
}


$("#exit").click(function() {
    fivemac.Close();

});


$("#vehicleremove").click(function() {
    $.post('https://fivemac-admin/deletevehicle', JSON.stringify({}));
});

$("#noperm").click(function() {
    $.post('http://fivemac-admin/close', JSON.stringify({}));
});


$("#deleteped").click(function() {
    $.post('https://fivemac-admin/deleteped', JSON.stringify({}));
});

$("#deleteobject").click(function() {
    $.post('https://fivemac-admin/deleteobject', JSON.stringify({}));
});

$("#communitydelete").click(function() {
    $.post('https://fivemac-admin/deletecom', JSON.stringify({}));
});

$("#deletebil").click(function() {
    $.post('https://fivemac-admin/deletebilling', JSON.stringify({}));
});

$("#deleteuser").click(function() {
    $.post('https://fivemac-admin/deleteuser', JSON.stringify({}));
});

$("#deleteuserinventory").click(function() {
    $.post('https://fivemac-admin/deleteuserinventory', JSON.stringify({}));
});

$("#deleteownedvehicles").click(function() {
    $.post('https://fivemac-admin/deleteownedvehicles', JSON.stringify({}));
});
