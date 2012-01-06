/*
 * Javascript methods for implenting a countdown
 */

// Variables used for the countdown
var countingDown = false;
var hours = 0;
var mins  = 0;
var secs  = 0;

function count_down_next() {
    secs -= 1;
    if (secs < 0) {
        secs = 59;
        mins -= 1;
        if (mins < 0) {
            mins = 59;
            hours -= 1;
            if (hours < 0) {
                // Do some intense shit
                return;
            }
        }
    }
    var hour_html = addLeadingZero(hours);
    var min_html = addLeadingZero(mins);
    var sec_html = addLeadingZero(secs);
    $("#hours").html(hour_html);
    $("#mins").html(min_html);
    $("#secs").html(sec_html);
    setTimeout("count_down_next()", 1000);
}

function startCountDown(time) {
    if (!countingDown) {
        countingDown = true;
        hours = time.hours;
        mins  = time.mins;
        secs  = time.secs;
        count_down_next();
    }
}

// Pads the front of the number with one or two zeros if necessary
function addLeadingZero(num) {
    num = String(num);
    while (num.length < 2) {
        num = "0" + num;
    }
    return num;
}
