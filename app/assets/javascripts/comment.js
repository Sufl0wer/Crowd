$(function() {
    $('#new_comment').on('ajax:success', function(a, b,c ) {
        $(this).find('input[type="text"]').val('');
    });
});
