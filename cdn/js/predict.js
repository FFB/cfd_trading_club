/* Javascript for the prediction page */

/* Predictor functions */

// Updates display of arrows on predictor
function updateArrows(arrow_clicked) {
    $(arrow_clicked).parent().children().removeClass('selected');
    $(arrow_clicked).addClass('selected');
}

// ON CLICK of UP ARROW
$('.up-arrow').click(function() {
    updateArrows(this);
    $(this).parents('form').find('input[value="up"]').attr("checked", true);
    clearStatus(this);
});

// ON CLICK of DOWN ARROW
$('.down-arrow').click(function() {
    updateArrows(this);
    $(this).parents('form').find('input[value="down"]').attr("checked", true);
    clearStatus(this);
});

// Resets status message
function clearStatus(obj) {
    $(obj).parents('form').find('.status-msg p').html('Not saved');
}

// RESET BUTTON
$('input.reset').click(function() {
    $(this).parents('form').find('.arrow').removeClass('selected');
    $(this).parents('form').find('input:radio').attr("checked", false);
    clearStatus(this);
});

//// Controls hover shit
//$(".arrow").hover(
//    function() {
//        $(this).addClass("hover");
//    },
//    function() {
//        $(this).removeClass("hover");
//    }
//);
