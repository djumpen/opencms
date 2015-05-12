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
      <div class="pull-right">
        <button type="submit" form="form-theme-voucher" class="btn btn-primary "><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
      <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-theme-voucher" class="form-horizontal">
        <div class="form-group required">
          <label class="col-xs-2 control-label"><?php echo $entry_name; ?></label>
          <div class="col-xs-10">
            <?php foreach ($languages as $language) { ?>
            <div class="input-group"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
              <input type="text" name="voucher_theme_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($voucher_theme_description[$language['language_id']]) ? $voucher_theme_description[$language['language_id']]['name'] : ''; ?>" placeholder="<?php echo $entry_name; ?>" class="form-control" />
            </div>
            <?php if (isset($error_name[$language['language_id']])) { ?>
            <div class="text-danger"><?php echo $error_name[$language['language_id']]; ?></div>
            <?php } ?>
            <?php } ?>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-image"><?php echo $entry_image; ?></label>
          <div class="col-xs-10 image"><img src="<?php echo $thumb; ?>" alt="" id="thumb"/>
            <input type="hidden" name="image" value="<?php echo $image; ?>" id="image"/>
            <br />
            <br />
            <div class="btn-group">
		<a class="btn btn-info" title="<?php echo $text_browse; ?>" data-toggle="modal" data-target="#dialog" onclick="image_upload('image', 'thumb');"><span class="fa fa-pencil"></span> <?php echo $text_browse; ?></a>
              <button type="button" onclick="$(this).parent().parent().find('img').attr('src', '<?php echo $no_image; ?>'); $(this).parent().parent().find('input').attr('value', '');" class="btn btn-danger"><span class="fa fa-trash-o"></span> <?php echo $text_clear; ?></button>
            </div>
            <?php if ($error_image) { ?>
            <div class="text-danger"><?php echo $error_image; ?></div>
            <?php } ?>
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
<script>
function image_upload(field, thumb) {

	$('#dialog').attr('data-field', field);
	$('#dialog').attr('data-thumb', thumb);
	$('#dialog #fm-iframe').attr('src', 'index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field));
};

jQuery(document).ready(function($) {

	$('#dialog').on('show.bs.modal', function () {
		$(this).find('#dialog-confirm').addClass('hide');
	});

	$('#dialog').on('hidden.bs.modal', function () {
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
});
</script>
<!--FILEMANAGER-->

<!--CONFIRM-DIALOG-->
  <div class="modal fade" id="confirm-dialog" data-field="" data-thumb="">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4 class="modal-title"><i class="fa fa-attention"></i></h4>
        </div>
        <div class="modal-body">
         <p>Delete/Uninstall cannot be undone! Are you sure you want to do this?</p>
        </div>
        <div class="modal-footer">
		<button data-dismiss="modal" id="confirm-dialog-btn-cancel" class="btn" aria-hidden="true">Cancel</button>
		<button data-dismiss="modal" id="confirm-dialog-btn-confirm" class="btn">Confirm</button>
        </div>
	<input id="confirm-dialog-action" type="hidden" name="confirm-dialog-action" value="">
      </div>
    </div>
  </div>
<!--CONFIRM-DIALOG-->
<?php echo $footer; ?>