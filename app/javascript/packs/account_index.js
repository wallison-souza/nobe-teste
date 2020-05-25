require("bootstrap");
$('#btn-account').click( function(){
    get_form($(this))
});
$(document).on('click', '.btn-edit', function(){
    get_form($(this))
});

function get_form($form){
    $.ajax({
        method: "GET",
        url: $form.attr('action'),
        dataType: 'JSON',
    })
        .done(function( data ) {
            $("#js-result").html("").append(data['html']);
            $('#new-account').modal('show');
        })
        .fail(function( data ) {
            alert('Erro ao carregar solicitação.')
            console.log(data)
        });
}

$('#js-result').on('submit','#form-account', function(event){
    event.preventDefault();
    $.ajax({
        method: "POST",
        url: $(this).attr('action'),
        data: $(this).serialize(),
        dataType: 'JSON',
    })
        .done(function( data ) {
            location.reload();
        })
        .fail(function( data ) {
            $('#js-result').prepend(data.responseText);
            $('#new-account').modal('show');
        });
});

