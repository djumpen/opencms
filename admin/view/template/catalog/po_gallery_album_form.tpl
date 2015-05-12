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
        <button type="submit" form="form-product" onclick="$('#form').submit();" class="btn btn-primary "><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
        <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
      </div>
      <div class="panel-body">
       <ul id="tabs" class="htabs nav nav-tabs style" id="language-general">
         <li class="active"><a href="#tab-general"><?php echo $tab_general; ?></a></li>
         <li><a href="#tab-data"><?php echo $tab_data; ?></a></li>
       </ul>
       <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
        <div id="tab-general">
          <ul id="languages" class="htabs nav nav-tabs style" id="language-general">
            <?php $l=0;foreach ($languages as $language) { ?>
            <li class="<?php if(!$l) { print 'active';} ?>">
             <a href="#language<?php echo $language['language_id']; ?>">
               <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
             </li>
             <?php $l++;} ?>
           </ul>
           <?php foreach ($languages as $language) { ?>
           <div id="language<?php echo $language['language_id']; ?>">
            <table class="table table-striped table-bordered table-hover">
              <tr>
                <td><span class="required">*</span> <?php echo $entry_name; ?></td>
                <td><input type="text" class="form-control" name="album_description[<?php echo $language['language_id']; ?>][name]" size="100" value="<?php echo isset($album_description[$language['language_id']]) ? $album_description[$language['language_id']]['name'] : ''; ?>" />
                  <?php if (isset($error_name[$language['language_id']])) { ?>
                  <span class="error"><?php echo $error_name[$language['language_id']]; ?></span>
                  <?php } ?></td>
                </tr>
                <tr>
                  <td><?php echo $entry_meta_description; ?></td>
                  <td><textarea class="form-control" name="album_description[<?php echo $language['language_id']; ?>][meta_description]" cols="40" rows="5"><?php echo isset($album_description[$language['language_id']]) ? $album_description[$language['language_id']]['meta_description'] : ''; ?></textarea></td>
                </tr>
                <tr>
                  <td><?php echo $entry_meta_keyword; ?></td>
                  <td><textarea class="form-control" name="album_description[<?php echo $language['language_id']; ?>][meta_keyword]" cols="40" rows="5"><?php echo isset($album_description[$language['language_id']]) ? $album_description[$language['language_id']]['meta_keyword'] : ''; ?></textarea></td>
                </tr>
                <tr>
                  <td><?php echo $entry_description; ?></td>
                  <td><textarea class="form-control" name="album_description[<?php echo $language['language_id']; ?>][description]" id="description<?php echo $language['language_id']; ?>"><?php echo isset($album_description[$language['language_id']]) ? $album_description[$language['language_id']]['description'] : ''; ?></textarea></td>
                </tr>
              </table>
            </div>
            <?php } ?>
          </div>
          <div id="tab-data">
            <table class="table table-striped table-bordered table-hover">
              <tr> 
                <td><?php echo $entry_store; ?></td>
                <td><div class="scrollbox">
                  <?php $class = 'even'; ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array(0, $album_store)) { ?>
                    <input type="checkbox" name="album_store[]" value="0" checked="checked" />
                    <?php echo $text_default; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="album_store[]" value="0" />
                    <?php echo $text_default; ?>
                    <?php } ?>
                  </div>
                  <?php foreach ($stores as $store) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array($store['store_id'], $album_store)) { ?>
                    <input type="checkbox" name="album_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                    <?php echo $store['name']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="album_store[]" value="<?php echo $store['store_id']; ?>" />
                    <?php echo $store['name']; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
                </div></td>
              </tr>
              <tr>
                <td><?php echo $entry_keyword; ?></td>
                <td><input type="text" class="form-control" name="keyword" value="<?php echo $keyword; ?>" /></td>
              </tr>
              <tr>
                <td><?php echo $entry_image; ?></td>
                <td valign="top"><div class="image"><img src="<?php echo $thumb; ?>" alt="" id="thumb" class="img-thumbnail" />
                  <input type="hidden" name="image" value="<?php echo $image; ?>" id="image" />
                  <div class="btn-group">
                    <a class="btn btn-success" data-toggle="modal" data-target="#dialog" onclick="image_upload('image', 'thumb');"><?php echo $text_browse; ?></a>
                    <a class="btn btn-danger" onclick="$('#thumb').attr('src', '<?php echo $no_image; ?>'); $('#image').attr('value', '');"><?php echo $text_clear; ?></a>
                  </div>
                </td>
              </tr>
              <tr>
                <td><?php echo $entry_sort_order; ?></td>
                <td><input type="text" class="form-control" name="sort_order" value="<?php echo $sort_order; ?>" size="1" /></td>
              </tr>
              <tr>
                <td><?php echo $entry_status; ?></td>
                <td><select name="status">
                  <?php if ($status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
              </tr>
            </table>
          </div>
        </form>
      </div>
    </div>
  </div>
  <script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
  <script type="text/javascript"><!--
    <?php foreach ($languages as $language) { ?>
      CKEDITOR.replace('description<?php echo $language['language_id']; ?>', {
       filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
       filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
       filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
       filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
       filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
       filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
     });
      <?php } ?>
      //--></script> 
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
<?php */ ?>
<script type="text/javascript"><!--
  $('#tabs a').tabs(); 
  $('#languages a').tabs();
  //--></script> 
  <?php echo $footer; ?>