<?php echo $header; ?>
<div id="content" class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if ($error_warning) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div class="panel panel-default">
    <div class="panel-heading">
    <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    <div class="btn-group">
        <a onclick="$('#form').submit();" class="btn btn-success"><span><?php echo $button_save; ?></span></a>
        <a onclick="location = '<?php echo $cancel; ?>';" class="btn btn-danger"><span><?php echo $button_cancel; ?></span></a>
    </div>
  </div>
  <div class="panel-body">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      <table class="table table-striped table-bordered table-hover">
        <tr>
          <td><span class="required">*</span> <?php echo $entry_promo_text; ?></td>
          <td>
          	<input type="hidden" value="0" name="promo_direction" />
            <input class="form-control" name="promo_text" value="<?php echo $promo_text; ?>" size="30" />
            <?php if ($error_promo_text) { ?>
            <span class="error"><?php echo $error_promo_text; ?></span>
            <?php } ?>
        </td>
	    </tr>
        <tr>
          <td><?php echo $entry_sort_order; ?></td>
          <td><input class="form-control" name="sort_order" value="<?php echo $sort_order; ?>" size="1" /></td>
        </tr>
		
		<?php foreach($languages as $language){ ?>
		<tr>
          <td><?php echo $entry_image; ?> [<?php echo strtoupper($language['code']);?>]</td>
          <td><div class="image"><img src="<?php echo $images[$language['language_id']]; ?>" alt="" id="thumb_<?php echo $language['language_id']?>" />
          <input type="hidden" name="images[<?php echo $language['language_id']?>]" value="<?php echo $images_values[$language['language_id']]; ?>" id="image_<?php echo $language['language_id']?>" />
          <div class="btn-group">
          <a class="btn btn-info" data-toggle="modal" data-target="#dialog" onclick="image_upload('image_<?php echo $language['language_id']?>', 'thumb_<?php echo $language['language_id']?>');"><span class="fa fa-pencil"></span> <?php echo $text_browse; ?></a>
          <a class="btn btn-danger" onclick="$('#thumb_<?php echo $language['language_id']?>').attr('src', '<?php echo $no_image; ?>'); $('#image_<?php echo $language['language_id']?>').attr('value', '');"><span class="fa fa-trash-o"></span> <?php echo $text_clear; ?></a>
          </div>
          </div></td>
        </tr>
		<?php } ?>        
        
      </table>
      
	  
      
      
      
      
      
      
      
      
      
    </form>
  </div>
</div>
<script type="text/javascript"><!--
	function RemoveImage() {
		document.getElementById('pimage').value = '';
		$('#thumb1').replaceWith('<img src="../image/cache/no_image-100x100.jpg" alt="" id="thumb1" class="image" onclick="image_upload(\'pimage\',\'thumb1\')" />');
	}
//--></script>

<script type="text/javascript"><!--
function image_upload(field, thumb) {
	$('#dialog').remove();
	
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	
	$('#dialog').dialog({
		title: '<?php echo $text_image_manager; ?>',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).val()),
					dataType: 'text',
					success: function(data) {
						$('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '" />');
					}
				});
			}
		},	
		bgiframe: false,
		width: 800,
		height: 400,
		resizable: false,
		modal: false
	});
};
//--></script> 
<script>
var isCtrl = false;
$(document).keyup(function (e) {
 if(e.which == 17) isCtrl=false;
}).keydown(function (e) {
    if(e.which == 17) isCtrl=true;
    if(e.which == 83 && isCtrl == true) {
        $('#content > div > div.panel-heading > div > a.btn.btn-success').trigger('click');
    return false;
 }
});
</script>
<div class="modal fade" id="dialog" data-field="" data-thumb="">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><?php echo $text_image_manager; ?></h4>
            </div>
            <div class="modal-body">
                <iframe id="fm-iframe" style="display:block; border:0; padding:0; margin:0; width:100%; height:360px; overflow:auto;"></iframe>
            </div>
            <div class="modal-footer">
                <a href="#" id="dialog-confirm" class="btn btn-success hide"><i class="fa fa-thumbs-up"></i> Confirm</a>
                <a href="#" class="btn btn-success" data-dismiss="modal" aria-hidden="true">Close</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
function image_upload(field, thumb) {

$('#dialog').attr('data-field', field);
$('#dialog').attr('data-thumb', thumb);
$('#dialog #fm-iframe').attr('src', 'index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field));
};

$(document.body).on('show.bs.modal', '#dialog', function () {
$(this).find('#dialog-confirm').addClass('hide');
});

$(document.body).on('hidden.bs.modal', '#dialog', function () {
var field = $(this).attr('data-field');
var thumb = $(this).attr('data-thumb');

if ($('#' + field).attr('value')) {
$.ajax({
url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).val()),
dataType: 'text',
success: function(data) {
$('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '">');
}
});
}
$('#dialog').attr('data-field', '');
$('#dialog').attr('data-thumb', '');
$('#dialog #fm-iframe').attr('src', '');
});
</script>
<?php echo $footer; ?>