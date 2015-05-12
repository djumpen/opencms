jQuery(document).ready(function($){
    
    $('.rating').on('mouseout', function(e){
        var curentRaiting = $(this).children('.rating-radio-div').children('.curentRating').val();
        $(this).children('.rating-radio-div').children('label').each(function(i, v) {
            if(i <= curentRaiting) {
                $(this).children('i').first('i').removeClass('fa-star-o');
                $(this).children('i').first('i').addClass('fa-star');
            } else {
                $(this).children('i').first('i').removeClass('fa-star');
                $(this).children('i').first('i').addClass('fa-star-o');
            }
        });
    });
    $('.rating-radio-div > label').hover(function(){
        var curentIndex = $(this).index();
        $(this).parent('.rating-radio-div').children('label').each(function(i, v) {
            if(i <= curentIndex) {
                $(this).children('i').first('i').removeClass('fa-star-o');
                $(this).children('i').first('i').addClass('fa-star');
            }
        });
    }, function(){
        $(this).parent('.rating-radio-div').children('label').each(function(i, v) {
            $(this).children('i').first('i').removeClass('fa-star');
            $(this).children('i').first('i').addClass('fa-star-o');
        });
    });
    $('.rating-radio-div > label').on('click', function(e){
        var curentRaiting = $(this).index();
        $(this).parent().children('.curentRating').val(curentRaiting);
        console.log(curentRaiting);
        $(this).parent('.rating-radio-div').children('label').each(function(i, v) {
            if(i <= curentRaiting) {
                $(this).children('i').first('i').removeClass('fa-star-o');
                $(this).children('i').first('i').addClass('fa-star');
            } else {
                $(this).children('i').first('i').removeClass('fa-star');
                $(this).children('i').first('i').addClass('fa-star-o');
            }
        });
    });
});