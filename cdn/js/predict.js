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
    $(this).parents('form').find('input[value="up"]').click();
    clearStatus(this);
});

// ON CLICK of DOWN ARROW
$('.down-arrow').click(function() {
    updateArrows(this);
    $(this).parents('form').find('input[value="down"]').click();
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

// When a prediction is saved, submit form using ajax
$('.predictor-form').submit(function() {
    var $status_msg = $(this).find('.status-msg p');
    var ticker      = $(this).find('input[name=ticker]').val();
    var prediction  = $(this).find("input[type=radio]:checked").val();
    $status_msg.html('saving');

    $.ajax({
        type:       'POST',
        url:        predict.ajax_url,
        dataType:   'json',
        cache:      false,
        data:       {
            'ticker'    : ticker,
            'prediction': prediction,
        },
        success: function(json) {
            $status_msg.html(json.status_msg);
        }
    });
    return false;
});
