
$(document).ready(function()
{
$(".edit_tr").click(function()
{
var ID=$(this).attr('id');
$("#keyword_"+ID).hide();
$("#meta_keyword_"+ID).hide();
$("#custom_title_"+ID).hide();
$("#meta_description_"+ID).hide();
$("#tags_"+ID).hide();
$("#keyword_input_"+ID).show();
$("#meta_keyword_input_"+ID).show();
$("#custom_title_input_"+ID).show();
$("#meta_description_input_"+ID).show();
$("#tags_input_"+ID).show();
}).change(function()
{
var ID=$(this).attr('id');

var keyword = $("#keyword_input_"+ID).val();
var meta_keyword = $("#meta_keyword_input_"+ID).val();
var custom_title = $("#custom_title_input_"+ID).val();
var meta_description = $("#meta_description_input_"+ID).val();
var tags = $("#tags_input_"+ID).val();
var lang = $("#lang_input_"+ID).val();
var dataString = 'id='+ encodeURIComponent(ID) + '&keyword=' + encodeURIComponent(keyword) + '&custom_title=' + encodeURIComponent(custom_title) + '&meta_keyword=' + encodeURIComponent(meta_keyword) + '&meta_description=' + encodeURIComponent(meta_description) + '&tags=' + encodeURIComponent(tags) + '&lang=' + encodeURIComponent(lang);
$("#first_"+ID).html('<img src="view/stylesheet/load.gif" />'); // Loading image

//if(first.length>0&& last.length>0)
{

$.ajax({
type: "POST",
url: "index.php?route=catalog/seoedit&token=" + $("#token").val(),
data: dataString,
cache: false,
success: function(html)
{
$("#keyword_"+ID).html(keyword);
$("#meta_keyword_"+ID).html(meta_keyword);
$("#custom_title_"+ID).html(custom_title);
$("#meta_description_"+ID).html(meta_description);
$("#tags_"+ID).html(tags);
}
});
}
//else
//{
//alert('Enter something.');
//}

});

// Edit input box click action
$(".editbox").mouseup(function()
{
return false
});

// Outside click action
$(document).mouseup(function()
{
$(".editbox").hide();
$(".text").show();
});

});



