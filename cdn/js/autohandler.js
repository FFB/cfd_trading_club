/*
 * Implements autohandler specific login processing then delegates
 * additional processing to individual pages
 */
function process_login(data) {
    $("#login_b").html( $(data).find("#login_content") );
}

/*
 * Implements autohandler specific logout processing then delegates
 * additional processing to individual pages
 */
function process_logout(data) {
    $("#login_b").html( $(data).find("#login_content") );
}
