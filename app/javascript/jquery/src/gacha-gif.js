import $ from 'jquery';
$(document).on('turbolinks:load', function(){
    $('.gacha-gif').hide();
    $('.gacha').show();
    $('.gacha-button').on('click', function(){
        $('.gacha-gif').show();
        $('.gacha').hide();
    })
})
