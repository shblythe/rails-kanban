function loadInit() {
    /* Activating Best In Place */
    $('.best_in_place').best_in_place();
    $('.datepicker').datepicker();
    $.datepicker.setDefaults({dateFormat: 'yy-mm-dd' });
}

$(document).ready(function() {
    loadInit();
});
$(document).on("turbolinks:load",function() {
    loadInit();
});
