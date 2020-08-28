import $ from 'jquery';
$(document).on('turbolinks:load', function(){    
    $('input[name="recipes[recipe_ids]"]').change(function(){
        let id = $(this).attr('title');
        let is_checked = $(this).prop('checked');

        $.ajax({
            url: '/recipes/checked',
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
