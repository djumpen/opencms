<?php echo $header; ?>
<div id="content" class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="panel panel-default">
        <div class="panel-heading">
            <div class="pull-right">
                <button type="submit" form="form-category" class="btn btn-primary ">
                    <i class="fa fa-check"></i> <?php echo $button_save; ?>
                </button>
                <a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a>
            </div>
            <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
        </div>
        <div class="panel-body">
        
		<form class="col-sm-10" action="/admin/index.php?route=tool/upload2&token=<?php echo($token);?>" method="post" enctype="multipart/form-data" id="file-uploader" style=" position: absolute !important; top: -9999px !important; left: -9999px !important;">
			<input type="file" id="image-input" name="image_file">
		</form>
    	    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-category" class="form-horizontal">
                <ul class="nav nav-tabs">
                    <li class="active">
                        <a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a>
                    </li>
                    <li>
                        <a href="#tab-seo" data-toggle="tab">SEO</a>
                    </li>
                    <li>
                        <a href="#tab-design" data-toggle="tab"><?php echo $tab_design; ?></a>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active" id="tab-general">
                        <div class="tab-content col-xs-4">
                            <ul class="nav nav-tabs" id="language">
                                <?php foreach ($languages as $language) { ?>
                                <li>
                                    <a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                                </li>
                                <?php } ?>
                            </ul>
                            <?php foreach ($languages as $language) { ?>
                            <div class="tab-pane row" id="language<?php echo $language['language_id']; ?>">
                                <div class="form-group required  col-xs-12">
                                    <label class="col-xs-12 control-label" for="input-name<?php echo $language['language_id']; ?>"><?php echo $entry_name; ?></label>
                                    <div class="col-xs-12">
                                        <input type="text" name="category_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['name'] : ''; ?>" id="input-name<?php echo $language['language_id']; ?>" class="form-control" />
                                    </div>
                                </div>
                            </div>
                            <?php } ?>
                        </div>
                        <div class="form-group col-xs-6 rootcat">
                        	 
                            <label class="col-xs-12 control-label" for="input-parent"><?php echo $entry_parent; ?></label>
                            <div class="col-xs-12">
                                <input type="text" name="path" value="<?php echo $path; ?>" id="input-parent" class="form-control" />
                                <input type="hidden" name="parent_id" value="<?php echo $parent_id; ?>" />
                            </div>
                        </div>
						<div class="form-group col-xs-2 sortorder"> 
                                <label class="col-xs-12 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
                                <div class="col-xs-12">
                                    <input type="text" name="sort_order" value="<?php echo $sort_order; ?>" id="input-sort-order" class="form-control" />
                                </div>
                         </div>
						<div class="row"></div>          
                        <div class="form-group col-xs-4">
                            <label class="col-xs-12 control-label"><?php echo $entry_image; ?></label>
                            <div class="col-xs-5"><img src="<?php echo $thumb; ?>" alt="" class="img-thumbnail" id="thumb"/></div>
                            <input type="hidden" name="image" value="<?php echo $image; ?>" id="image"/>
                            <div class="col-xs-7">
                                <button type="button"  class="btn btn-info" onclick="$('#image-input').click();return false;">
                                    <span class="fa fa-pencil"></span> <?php echo $text_browse; ?>
                                </button>
                                <br /> <br />
                                <button type="button" onclick="$(this).parent().parent().find('img').attr('src', '<?php echo $no_image; ?>'); $(this).parent().parent().find('input').attr('value', '');" class="btn btn-danger">
                                    <span class="fa fa-trash-o"></span> <?php echo $text_clear; ?>
                                </button>
                            </div>
                            
                        </div>
                        <div class="col-xs-6">
                            <div class="form-group ">
                                <label class="col-xs-5 control-label" for="input-top" data-toggle="tooltip" title="<?php print $text_is_information; ?>"><?php echo $entry_is_information; ?></label>
                                <div class="col-xs-7">
                                    <label class="checkbox">
                                        <?php if ($is_information) { ?>
                                        <input type="checkbox" name="is_information" value="1" checked="checked" id="input-top" />
                                        <?php } else { ?>
                                        <input type="checkbox" name="is_information" value="1" id="input-top" />
                                        <?php } ?> 
                                    </label>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-xs-5 control-label" for="input-status"><?php echo $entry_status; ?></label>
                                <div class="col-xs-7">
                                    <div class="btn-group" data-toggle="buttons">
                                        <label class="btn btn-success<?php if ($status == 1) { ?> active<?php } ?>"> <i class="fa fa-check"></i>
                                            <input type="radio" name="status" value="1" id="input-status" <?php if ($status == 1) { ?>checked<?php } ?>>
                                            <?php echo $text_enabled; ?> </label>
                                        <label class="btn btn-danger<?php if ($status == 0) { ?> active<?php } ?>"> <i class="fa fa-times"></i>
                                            <input type="radio" name="status" value="0" id="input-status" <?php if ($status == 0) { ?>checked<?php } ?>>
                                            <?php echo $text_disabled; ?> </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                         
                            <div class="clearfix"></div>
                            <div class="tab-content">
                                <ul class="nav nav-tabs" id="desc-language">
                                  <?php foreach ($languages as $language) { ?>
                                  <li>
                                    <a href="#desc-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                                  </li>
                                  <?php } ?>
                                </ul>
                                <?php foreach ($languages as $language) { ?>
                                <div class="tab-pane" id="desc-language<?php echo $language['language_id']; ?>">
                                    <?php if($this->config->get('config_full_category_description')) { ?>
                                    <div class="form-group">
                                        <label class="col-xs-2 control-label" for="input-description<?php echo $language['language_id']; ?>"><?php echo $entry_description; ?></label>
                                        <div class="col-xs-10">
                                            <textarea name="category_description[<?php echo $language['language_id']; ?>][description]" id="input-description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['description'] : ''; ?></textarea>
                                        </div>
                                    </div>
                                    <?php } ?>
                                    <?php if($this->config->get('config_short_category_description')) { ?>
                                    <div class="form-group">
                                        <label class="col-xs-2 control-label" for="input-short-description<?php echo $language['language_id']; ?>">Краткое описание</label>
                                        <div class="col-xs-10">
                                            <textarea name="category_description[<?php echo $language['language_id']; ?>][short_description]" id="input-short-description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['short_description'] : ''; ?></textarea>
                                        </div>
                                    </div>
                                    <?php } ?>
                                    <?php if($this->config->get('config_additional_category_description')) {?>
                                    <div class="form-group">
                                        <label class="col-xs-2 control-label" for="input-additional-description<?php echo $language['language_id']; ?>">Дополнительное описание</label>
                                        <div class="col-xs-10">
                                            <textarea name="category_description[<?php echo $language['language_id']; ?>][additional_description]" id="input-additional-description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['additional_description'] : ''; ?></textarea>
                                        </div>
                                    </div>
                                    <?php } ?>
                                </div>
                                <?php } ?>
                            </div>
                            <div class="tab-content">
                                <div class="tab-pane">
                                    <div class="form-group">
                                        <label class="col-xs-2 control-label"><?php echo $entry_store; ?></label>
                                        <div class="col-xs-10">
                                            <div class="checkbox">
                                                <label> <?php if (in_array(0, $category_store)) { ?>
                                                    <input type="checkbox" name="category_store[]" value="0" checked="checked" />
                                                    <?php echo $text_default; ?>
                                                    <?php } else { ?>
                                                    <input type="checkbox" name="category_store[]" value="0" />
                                                    <?php echo $text_default; ?>
                                                    <?php } ?> </label>
                                            </div>
                                            <?php foreach ($stores as $store) { ?>
                                            <div class="checkbox">
                                                <label> <?php if (in_array($store['store_id'], $category_store)) { ?>
                                                    <input type="checkbox" name="category_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                                                    <?php echo $store['name']; ?>
                                                    <?php } else { ?>
                                                    <input type="checkbox" name="category_store[]" value="<?php echo $store['store_id']; ?>" />
                                                    <?php echo $store['name']; ?>
                                                    <?php } ?> </label>
                                            </div>
                                            <?php } ?>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab-seo">
                          <div class="tab-content">
                            <ul class="nav nav-tabs" id="languageSEO">
                                <?php foreach ($languages as $language) { ?>
                                <li>
                                    <a href="#languageSEO<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                                </li>
                                <?php } ?>
                            </ul>
                            <?php foreach ($languages as $language) { ?>
                            <div class="tab-pane " id="languageSEO<?php echo $language['language_id']; ?>">
	                            <div class="form-group">
	                                <label class="col-xs-2 control-label" for="input-keyword">SEO URL</label>
	                                <div class="col-xs-10">
	                                    <input id="input-keyword<?php print $language['language_id']; ?>" class="width-50 form-control" type="text" name="keyword[<?php echo $language['language_id']; ?>]" value="<?php if (isset($keyword[$language['language_id']])) { echo $keyword[$language['language_id']]; } ?>" />
	                                </div>
	                            </div>
	                            <div class="form-group">
	                                <label class="col-xs-2 control-label" for="input-meta-description<?php echo $language['language_id']; ?>"><?php echo $entry_meta_description; ?></label>
	                                <div class="col-xs-10">
	                                    <textarea name="category_description[<?php echo $language['language_id']; ?>][meta_description]" rows="5" id="input-meta-description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['meta_description'] : ''; ?></textarea>
	                                </div>
	                            </div>
	                            <div class="form-group">
	                                <label class="col-xs-2 control-label" for="input-meta-keyword<?php echo $language['language_id']; ?>"><?php echo $entry_meta_keyword; ?></label>
	                                <div class="col-xs-10">
	                                    <input type="text" name="category_description[<?php echo $language['language_id']; ?>][meta_keyword]" rows="5" id="input-meta-keyword<?php echo $language['language_id']; ?>" value="<?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['meta_keyword'] : ''; ?>" class="width-50 form-control">
	                                </div>
	                            </div>
	                            <div class="form-group">
	                                <label class="col-xs-2 control-label" for="input-custom-title<?php echo $language['language_id']; ?>"><?php echo $entry_custom_title; ?></label>
	                                <div class="col-xs-10">
	                                    <input type="text" name="category_description[<?php echo $language['language_id']; ?>][custom_title]" rows="5" id="input-custom-title<?php echo $language['language_id']; ?>" size="100" value="<?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['custom_title'] : ''; ?>" class="width-50 form-control">
	                                </div>
	                            </div>
	                            <div class="form-group">
	                                <label class="col-xs-2 control-label" for="input-custom-h1<?php echo $language['language_id']; ?>">Custom h1</label>
	                                <div class="col-xs-10">
	                                    <input type="text" name="category_description[<?php echo $language['language_id']; ?>][custom_h1]" rows="5" id="input-custom-h1<?php echo $language['language_id']; ?>" size="100" value="<?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['custom_h1'] : ''; ?>" class="width-50 form-control">
	                                </div>
	                            </div>
	                         </div>
	                         <?php } ?>
                          </div>
                        </div>
                        <div class="tab-pane" id="tab-design">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <td class="text-left"><?php echo $entry_store; ?></td>
                                            <td class="text-left"><?php echo $entry_layout; ?></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="text-left"><?php echo $text_default; ?></td>
                                            <td class="text-left">
                                            <select name="category_layout[0][layout_id]" class="form-control">
                                                <option value=""></option>
                                                <?php foreach ($layouts as $layout) { ?>
                                                <?php if (isset($category_layout[0]) && $category_layout[0] == $layout['layout_id']) { ?>
                                                <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                                                <?php } else { ?>
                                                <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                                                <?php } ?>
                                                <?php } ?>
                                            </select></td>
                                        </tr>
                                        <?php foreach ($stores as $store) { ?>
                                        <tr>
                                            <td class="text-left"><?php echo $store['name']; ?></td>
                                            <td class="text-left">
                                            <select name="category_layout[<?php echo $store['store_id']; ?>][layout_id]" class="form-control">
                                                <option value=""></option>
                                                <?php foreach ($layouts as $layout) { ?>
                                                <?php if (isset($category_layout[$store['store_id']]) && $category_layout[$store['store_id']] == $layout['layout_id']) { ?>
                                                <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                                                <?php } else { ?>
                                                <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                                                <?php } ?>
                                                <?php } ?>
                                            </select></td>
                                        </tr>
                                        <?php } ?>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
            </form>
        </div>
    </div>
</div>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
	<!--
<?php foreach ($languages as $language) { ?>
<?php if($this->config->get('config_full_category_description')) { ?>
CKEDITOR.replace('input-description<?php echo $language['language_id']; ?>', {
filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
<?php } ?>
<?php if($this->config->get('config_short_category_description')) { ?>
CKEDITOR.replace('input-short-description<?php echo $language['language_id']; ?>', {
filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
<?php } ?>
<?php if($this->config->get('config_additional_category_description')) { ?>
CKEDITOR.replace('input-additional-description<?php echo $language['language_id']; ?>', {
filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
<?php } ?>
<?php } ?>
//-->
</script>
<script type="text/javascript">
<!--
$('input[name=\'path\']').autocomplete({
'source': function(request, response) {
$.ajax({
url: 'index.php?route=catalog/category/autocomplete&token=<?php echo $token; ?><?php print (isset($this->request->get['category_id'])?'&exclude_category=' . $this->request->get['category_id']:'');?>&filter_name=' +  encodeURIComponent(request),
dataType: 'json',
success: function(json) {
json.unshift({
'category_id': 0,
'name': '<?php echo $text_none; ?>'
});

response($.map(json, function(item) {
return {
label: item['name'],
value: item['category_id']
}
}));
}
});
},
'select': function(item) {
$('input[name=\'path\']').val(item['label']);
$('input[name=\'parent_id\']').val(item['value']);
}
});
//-->
</script>
<script type="text/javascript">
<!--
$('input[name=\'filter\']').autocomplete({
'source': function(request, response) {
$.ajax({
url: 'index.php?route=catalog/filter/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
dataType: 'json',
success: function(json) {
response($.map(json, function(item) {
return {
label: item['name'],
value: item['filter_id']
}
}));
}
});
},
'select': function(item) {
$('input[name=\'filter\']').val('');

$('#category-filter' + item['value']).remove();

$('#category-filter').append('<div id="category-filter' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="category_filter[]" value="' + item['value'] + '" /></div>');
}
});

$('#category-filter').delegate('.fa-minus-circle', 'click', function() {
$(this).parent().remove();
});
//-->
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

<link rel="stylesheet" href="view/javascript/bootstrap-tagsinput/bootstrap-tagsinput.css">
<script src="view/javascript/bootstrap-tagsinput/bootstrap-tagsinput.js"></script>

<script type="text/javascript">
function image_upload(field, thumb) {

// NOT USED

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
<script type="text/javascript">
	<!--
	$("input#input-keyword, input#input-meta-description<?php echo $language['language_id']; ?>").val();
	$('#language a:first').tab('show');
	$('#languageSEO a:first').tab('show');
	$('#desc-language a:first').tab('show');
	//-->
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
	var opts = {
    	title: 'Проверьте форму',
    	type: 'error',
	    styling: 'bootstrap3',
        addclass: 'oc_noty',
        icon: 'picon picon-32 picon-fill-color',
        opacity: .8,
        nonblock: {
        	nonblock: true
        }
	};
	/*** Проверка на название категории (RUS/ENG) ***/
	<?php foreach ($languages as $language) { ?>
		<?php if (isset($error_name[$language['language_id']])) { ?>
			$(function () {
				$('#input-name<?php echo $language['language_id']; ?>').css('border-color', '#F00');
				opts.text = '<?php echo $error_name[$language['language_id']]; ?> (Язык формы: <?php echo $language['name']; ?>)'
			    new PNotify(opts);
			});
		<?php } ?>
	<?php } ?>
</script>
<?php echo $footer; ?>