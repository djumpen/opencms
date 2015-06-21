function getLink(link, get){
    var token = $('#current_token').val();
    if(typeof get != 'undefined') {
        if(!token) {
            return '/index.php?route=' + link + '&' + get;
        } else {
            return '/index.php?route=' + link + '&token=' + token + '&' + get;
        }
    } else {
        if(!token) {
            return '/index.php?route=' + link;
        } else {
            return '/index.php?route=' + link + '&token=' + token;
        }
    }
}

$.fn.serializeObject = function() {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name]) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};
jQuery.fn.exist = function () {
    var exist;
    this.length >= 1 ? exist = true : exist = false;
    return exist;
};

$(document).ready(function(){
     $('#login-btn').on('click', function(){
         $('#top-module-container').slideToggle('fast');
     });


    $(window).on('resize', function () {
    });
});
