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
        <button type="submit" form="form-banner" class="btn btn-primary "><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
      <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-banner" class="form-horizontal">
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
          <label class="col-xs-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
          <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($status == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="status" value="1" <?php if ($status == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_enabled; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($status == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="status" value="0" <?php if ($status == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_disabled; ?>
  			</label>
		</div>
          </div>
        </div>
	<div class="table-responsive">
        <table id="images" class="table table-striped table-bordered table-hover">
          <thead>
            <tr>
              <td class="text-left" style="width: 30%"><?php echo $entry_title; ?></td>
              <td class="text-left" style="width: 30%"><?php echo $entry_link; ?></td>
              <td class="text-center" style="width: 30%"><?php echo $entry_image; ?></td>
              <td></td>
            </tr>
          </thead>

		<?php $image_row = 0; ?>
		<?php foreach ($banner_images as $key => $banner_image) { ?>
		<?php $image_row = $key; ?>
		<tbody id="image-row<?php echo $image_row; ?>">
			<tr>
				<td class="text-left">
					<?php foreach ($languages as $language) { ?>
						<div class="input-group pull-left inputGrup"> 
							<span class="input-group-addon">
								<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
							</span>
							<input type="text" 
							       name="banner_image[<?php echo $image_row; ?>][<?php echo $language['language_id']; ?>][title]" 
								   value="<?php echo isset($banner_image[$language['language_id']]) ? $banner_image[$language['language_id']]['title'] : ''; ?>" 
								   class="form-control" />
								   
						</div>
	                	<?php if(isset($error_banner_image[$image_row][$language['language_id']])) { ?>
	                		<div class="text-danger"><?php echo $error_banner_image[$image_row][$language['language_id']]; ?></div>
	                	<?php } ?>
	                <?php } ?>
				</td>

              	<td class="text-left">
              		<?php foreach ($languages as $language) { ?>
						<div class="input-group pull-left inputGrup"> 
							<span class="input-group-addon">
								<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
							</span>
							<input type="text" 
								   name="banner_image[<?php echo $image_row; ?>][<?php echo $language['language_id']; ?>][link]" 
								   value="<?php echo isset($banner_image[$language['language_id']]) ? $banner_image[$language['language_id']]['link'] : ''; ?>" 
								   class="form-control"/>
						</div>
					<?php } ?>
				</td>
				
				<td class="text-center imageUpload">
					<?php foreach ($languages as $language) { ?>
						<div style="overflow: hidden;">
							<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>"  style="float: left;"/>
							<img src="<?php echo isset($banner_image[$language['language_id']]['thumb']) ? $banner_image[$language['language_id']]['thumb'] : $no_image; ?>" id="thumb<?php echo $image_row; ?>_<?php echo $language['language_id'];?>" class="img-thumbnail" style="float: left;"/>
							<input type="hidden" 
								   name="banner_image[<?php echo $image_row; ?>][<?php echo $language['language_id'];?>][image]" 
								   value="<?php echo isset($banner_image[$language['language_id']]['image']) ? $banner_image[$language['language_id']]['image'] : ''; ?>" 
								   id="image<?php echo $image_row; ?>_<?php echo $language['language_id'];?>" />
		                    <br/>
							<div style="float: right;">
								<button onclick="image_upload('image<?php echo $image_row; ?>_<?php echo $language['language_id'];?>', 'thumb<?php echo $image_row; ?>_<?php echo $language['language_id'];?>');" 
										class="btn-info btn" data-toggle="modal" data-target="#dialog">
										<i class="fa fa-edit"></i><?php echo $text_browse; ?></button>
										<br>
								<button class="btn btn-danger" 
										onclick="$('#thumb<?php echo $image_row; ?>_<?php echo $language['language_id'];?>').attr('src', '<?php echo $no_image; ?>'); $('#image<?php echo $image_row; ?>_<?php echo $language['language_id'];?>').attr('value', ''); return false;">
										<i class="fa fa-trash-o"></i> <?php echo $text_clear; ?></button>
							</div>
						</div>
					<?php } ?>
				</td>
              <td class="text-center"><button type="button" onclick="$('#image-row<?php echo $image_row; ?>').remove();" class="btn btn-danger"><i class="fa fa-minus-circle"></i> <?php echo $button_remove; ?></button></td>
            </tr>
          </tbody>
          <?php } ?>
          <?php $image_row++; ?>
          <tfoot>
            <tr>
              <td colspan="3"></td>
              <td class="text-left"><button type="button" onclick="addImage();" class="btn btn-primary"><i class="fa fa-plus-circle"></i> <?php echo $button_add_banner; ?></button></td>
            </tr>
          </tfoot>
        </table>
	</div>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
var image_row = <?php echo $image_row; ?>;

function addImage() {
	html  = '<tbody id="image-row' + image_row + '">';
    html += '  <tr>';
    html += '  <td class="text-left">';
   <?php foreach ($languages as $language) { $l_id = $language['language_id']; ?>
	html += '    <div class="input-group pull-left inputGrup"> ';
	html += '      <span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span><input type="text" name="banner_image[' + image_row + '][<?php echo $l_id;?>][title]" value="" class="form-control" />';
    html += '    </div>';
   <?php } ?>
	html += '  </td>';
	html += '  <td class="text-left">';
   <?php foreach ($languages as $language) { $l_id = $language['language_id']; ?>
	html += '<div class="input-group pull-left inputGrup"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span><input type="text" name="banner_image[' + image_row + '][<?php echo $l_id;?>][link]" value=\"\" class="form-control" /></div>';	
	<?php } ?>
	html += '</td>';	
	html += '  <td class="text-center imageUpload">';
   <?php foreach ($languages as $language) { $l_id = $language['language_id']; ?>
	html += '<div style="overflow: hidden;">';
	html += '<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>"  style="float: left;"/>';
	html += '<img src="<?php echo $no_image; ?>" alt="" class="img-thumbnail" id="thumb' + image_row + '_<?php echo $l_id;?>" style="float: left;"/><input type="hidden" name="banner_image[' + image_row + '][<?php echo $l_id;?>][image]" value="" id="image' + image_row + '_<?php echo $l_id;?>"/>';
	html += '  <br /><div style="float: right;"><button type="button" data-toggle="modal" data-target="#dialog" class="btn btn-info" onclick="image_upload(\'image' + image_row + '_<?php echo $l_id;?>\', \'thumb' + image_row + '_<?php echo $l_id;?>\');">';
	html += '<i class="fa fa-edit"></i> <?php echo $text_browse; ?></button><br><button class="btn btn-danger" onclick="$(\'#thumb' + image_row + '_<?php echo $l_id;?>\').attr(\'src\', \'<?php echo $no_image; ?>\');$(\'#image' + image_row + '_<?php echo $l_id;?>\').attr(\'value\', \'\');return false">';
	html += '<i class="fa fa-trash-o"></i> <?php echo $text_clear; ?></button></div></div>';
   <?php } ?>
	html += '</td>';
	html += '  <td class="text-center"><i style="float:right">*</i><button type="button" onclick="$(\'#image-row' + image_row  + '\').remove(); return false;" class="btn btn-danger"><i class="fa fa-minus-circle"></i> <?php echo $button_remove; ?></button></td>';
	html += '</tr>';
	html += '</tbody>';
	
	/* $('#images tfoot').append(html);*/
	$('#images tfoot').before(html);
	
	image_row++;
}
//--></script> 
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
					$('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '" style="float: left;">');
				}
			});
		}
		$('#dialog').attr('data-field', '');
		$('#dialog').attr('data-thumb', '');
		$('#dialog #fm-iframe').attr('src', '');
	});
</script>
<?php echo $footer; ?>