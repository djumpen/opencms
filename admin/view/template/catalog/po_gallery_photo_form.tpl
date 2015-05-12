<?php echo $header; ?>
<div id="content" class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="panel panel-default">
    <div class="panel-heading">
      <div class="pull-right">
       <button id="submitPhoto" type="submit" form="form-product" class="btn btn-primary "><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
       <script type="text/javascript">
        $(document).ready(function(){
         $('#submitPhoto').on('click', function(){
          $('#form').submit();
        });
       });
      </script>
      <a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
      <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">

        <ul class="nav nav-tabs" id="language-general">
          <?php $l=0;foreach ($languages as $language) { ?>
          <li class="<?php if(!$l) { print 'active';} ?>"><a  href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
          <?php $l++;} ?>
        </ul>
        <div class="tab-content">
         <?php $l=0;foreach ($languages as $language) { ?>
         <div id="language<?php echo $language['language_id']; ?>" class="tab-pane <?php if(!$l) { print 'active';} ?>">
          <table class="table table-striped table-bordered table-hover">
            <tr>
              <td><span class="required">*</span> <?php echo $entry_name; ?></td>
              <td><input type="text" class="form-control" name="photo_description[<?php echo $language['language_id']; ?>][name]" size="100" value="<?php echo isset($photo_description[$language['language_id']]) ? $photo_description[$language['language_id']]['name'] : ''; ?>" />
                <?php if (isset($error_name[$language['language_id']])) { ?>
                <span class="error"><?php echo $error_name[$language['language_id']]; ?></span>
                <?php } ?></td>
              </tr>
            </table>
          </div>
          <?php $l++;} ?>
        </div>
        <table class="table table-striped table-bordered table-hover">
          <tr>
            <td><?php echo $entry_image; ?></td>
            <td><div class="image"><img src="<?php echo $thumb; ?>" alt="" id="thumb" class="img-thumbnail" />
              <input type="hidden" name="image" value="<?php echo $image; ?>" id="image" />
              <span style="vertical-align: middle;" class="btn-group">
                <a class="btn btn-info" style="cursor:pointer;" data-toggle="modal" data-target="#dialog" onclick="image_upload('image', 'thumb');"><span class="fa fa-pencil"> Просмотр файлов</span></a>
                <a class="btn btn-danger" style="cursor:pointer;" onclick="$('#thumb').attr('src', '<?php echo $no_image; ?>'); $('#image').attr('value', '');"><span class="fa fa-trash-o"> Убрать изображение</span></a></span></div></td>
              </tr>
              <tr>
                <td><?php echo $entry_status; ?></td>
                <td><select style="width: 200px" class="form-control" name="status">
                  <?php if ($status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
              </tr>
              <tr>
                <td><?php echo $entry_sort_order; ?></td>
                <td><input type="text" class="form-control" name="sort_order" value="<?php echo $sort_order; ?>" size="2" /></td>
              </tr>
              <tr>
                <td><?php echo $entry_album; ?></td>
                <td><div class="scrollbox">
                  <?php $class = 'odd'; ?>
                  <?php foreach ($albums as $album) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array($album['album_id'], $photo_album)) { ?>
                    <input type="checkbox" name="photo_album[]" value="<?php echo $album['album_id']; ?>" checked="checked" />
                    <?php echo $album['name']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="photo_album[]" value="<?php echo $album['album_id']; ?>" />
                    <?php echo $album['name']; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
                </div>
                <div class="btn-group">
                  <a class="btn btn-info" style="cursor:pointer;" onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a>
                  <a class="btn btn-danger" style="cursor:pointer;" onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a>
                </div>
              </td>
            </tr>
            <tr>
              <td>Магазин</td>
              <td><div class="scrollbox">
                <?php $class = 'even'; ?>
                <div class="<?php echo $class; ?>">
                  <?php if (in_array(0, $photo_store)) { ?>
                  <input type="checkbox" name="photo_store[]" value="0" checked="checked" />
                  По умолчанию
                  <?php } else { ?>
                  <input type="checkbox" name="photo_store[]" value="0" />
                  <?php echo $text_default; ?>
                  <?php } ?>
                </div>
                <?php foreach ($stores as $store) { ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div class="<?php echo $class; ?>">
                  <?php if (in_array($store['store_id'], $photo_store)) { ?>
                  <input type="checkbox" name="photo_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                  <?php echo $store['name']; ?>
                  <?php } else { ?>
                  <input type="checkbox" name="photo_store[]" value="<?php echo $store['store_id']; ?>" />
                  <?php echo $store['name']; ?>
                  <?php } ?>
                </div>
                <?php } ?>
              </div></td>
            </tr>
          </table>
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
<?php /* ?>
<script type="text/javascript"><!--
function image_upload(field, thumb) {
	$('#dialog').remove();
	
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	
	$('#dialog').dialog({
		title: '<?php echo $text_image_manager; ?>',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).attr('value')),
					dataType: 'text',
					success: function(text) {
						$('#' + thumb).replaceWith('<img src="' + text + '" alt="" id="' + thumb + '" />');
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
//--></script><?php */ ?>
<script type="text/javascript"><!--
  $('#tabs a').tabs(); 
  $('#languages a').tabs(); 
  //--></script> 
  <?php echo $footer; ?>