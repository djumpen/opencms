<?php echo $header; ?>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>
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
      <div class="pull-right">
        <button type="submit" form="form-manufacturer" class="btn btn-primary "><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
      <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
    
    <form class="col-sm-10" action="/admin/index.php?route=tool/upload2&token=<?php echo($token);?>" method="post" enctype="multipart/form-data" id="file-uploader" style=" position: absolute !important; top: -9999px !important; left: -9999px !important;">
			<input type="file" id="image-input" name="image_file">
		</form>
    
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-manufacturer" class="form-horizontal">
        <div class="form-group required">
          <label class="col-xs-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
          <div class="col-xs-10">
            <input type="text" name="name" value="<?php echo $name; ?>" id="input-name" class="form-control" />
            <?php if ($error_name) { ?>
            <div class="text-danger"><?php echo $error_name; ?></div>
            <?php } ?>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label"><?php echo $entry_store; ?></label>
          <div class="col-xs-10">
            <div class="checkbox">
              <label>
                <?php if (in_array(0, $manufacturer_store)) { ?>
                <input type="checkbox" name="manufacturer_store[]" value="0" checked="checked" />
                <?php echo $text_default; ?>
                <?php } else { ?>
                <input type="checkbox" name="manufacturer_store[]" value="0" />
                <?php echo $text_default; ?>
                <?php } ?>
              </label>
            </div>
            <?php foreach ($stores as $store) { ?>
            <div class="checkbox">
              <label>
                <?php if (in_array($store['store_id'], $manufacturer_store)) { ?>
                <input type="checkbox" name="manufacturer_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                <?php echo $store['name']; ?>
                <?php } else { ?>
                <input type="checkbox" name="manufacturer_store[]" value="<?php echo $store['store_id']; ?>" />
                <?php echo $store['name']; ?>
                <?php } ?>
              </label>
            </div>
            <?php } ?>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-keyword"><?php echo $entry_keyword; ?></label>
          <div class="col-xs-10">
            <?php foreach ($languages as $language) { ?>
			<input id="input-keyword<?php print $language['language_id']; ?>" data-role="tagsinput" class="width-50 form-control" type="text" name="keyword[<?php echo $language['language_id']; ?>]" value="<?php if (isset($keyword[$language['language_id']])) { echo $keyword[$language['language_id']]; } ?>" />
			<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br>
			<?php } ?>
            </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label"><?php echo $entry_image; ?></label>
          <div class="col-xs-10"><img src="<?php echo $thumb; ?>" alt="" class="img-thumbnail" id="thumb" />
            <input type="hidden" name="image" value="<?php echo $image; ?>" id="image"/>
            <br />
            <br />
            <div class="btn-group">
              <button type="button" class="btn btn-info" onclick="$('#image-input').click();return false;"><span class="fa fa-pencil"></span> <?php echo $text_browse; ?></button>
              <button type="button" onclick="$(this).parent().parent().find('img').attr('src', '<?php echo $no_image; ?>'); $(this).parent().parent().find('input').attr('value', '');return false;" class="btn btn-danger"><span class="fa fa-trash-o"></span> <?php echo $text_clear; ?></button>
            </div>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="text-description">Описание производителя</label>
          <div class="col-xs-10">
            <?php foreach ($languages as $language) { ?>
			<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br>
			<textarea id="text-description<?php print $language['language_id']; ?>"  class="width-50 form-control" name="manufacturer_description[<?php echo $language['language_id']; ?>][description]">
			<?php if (isset($manufacturer_description[$language['language_id']]['description'])) { echo $manufacturer_description[$language['language_id']]['description']; } ?>
			</textarea>
			<?php } ?>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
          <div class="col-xs-10">
            <input type="text" name="sort_order" value="<?php echo $sort_order; ?>" id="input-sort-order" class="form-control" />
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<div class="modal fade" id="dialog" data-field="" data-thumb="">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
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

<link rel="stylesheet" href="view/javascript/bootstrap-tagsinput/bootstrap-tagsinput.css">
<script src="view/javascript/bootstrap-tagsinput/bootstrap-tagsinput.min.js"></script>

<script type="text/javascript"><!--
<?php foreach ($languages as $language) { ?>
CKEDITOR.replace('text-description<?php echo $language['language_id']; ?>', {
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
<?php } ?>
//--></script> 
<script type="text/javascript">
$("input#input-keyword").val();

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
<script type="text/javascript">
var isCtrl = false;
$(document).keyup(function (e) {
 if(e.which == 17) isCtrl=false;
}).keydown(function (e) {
    if(e.which == 17) isCtrl=true;
    if(e.which == 83 && isCtrl == true) {
        $('#content > div > div.panel-heading > div > button').trigger('click');
    return false;
 }
});
</script>


<script type="text/javascript">
$(document).ready(function() {
	var $form3 = $('#file-uploader');
    // Instantiate Uploader
	var uploader3 = new Uploader({
		$form: $form3,
		postUrl: $form3.attr('action'),
	    onErrorCallback: function (result, file, $fileInput) {
	    	/*$fileInput.after($('<div />)', {
    			'class': 'file-name is-' + result.status,
				'text': file.name + ' could not be uploaded, because: ' + result.responseText
    		}));*/
    		alert('Не удается загрузить этот файл: ' + result.responseText);
	    },
	    onSuccessCallback: function (result, file, $fileInput) {
	    	console.log('success callback');
	    	if(result.fileName) {
	    		console.log(result.fileName);
	    		$('input[name="image"]').val(result.fileName);
	    		$('#thumb').attr('src', '/image/' + result.fileName);
	    	}
	    },
	    uploadFn: 'UploaderWithIframe'
	});
	$('input[type=file]', $form3).on('upload.input.start', function () {
		$('body').css('cursor', 'wait');
		$(this).closest('.form-control').addClass('is-uploading');
	});
	$('input[type=file]', $form3).on('upload.input.complete', function (evt, result) {
		$('body').css('cursor', 'default');
		$(this).closest('.form-control').removeClass('is-uploading');
	});
	// doUploadSingleInput on change
	$('input[type="file"]', $form3).on('change', function () {
		var results = uploader3.doUploadSingleInput($(this));
	});
});
</script>
<?php echo $footer; ?>