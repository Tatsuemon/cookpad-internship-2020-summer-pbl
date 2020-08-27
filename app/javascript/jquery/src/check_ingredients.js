import $ from 'jquery';
$(function(){
    $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
        var token;
        if (!options.crossDomain) {
        token = $('meta[name="csrf-token"]').attr('content');
           if (token) {
              return jqXHR.setRequestHeader('X-CSRF-Token', token);
            }
         }
     });
    
    $('input[name="group_ingredient[ingredient_ids]"]').change(function(){
        let id = $(this).attr('title');
        let is_checked = $(this).prop('checked');

        $.ajax({
            url: '/ingredients/checked',
            dataType: 'json',
            type: 'POST',
            data: {
                id: id,
                checked: is_checked
            }
        }).fail(function(err){
            console.error(err.statusText);
        });
    })
})
