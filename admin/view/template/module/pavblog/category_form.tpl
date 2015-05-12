<?php

if( $menu ): 
$module_row= 'ss';
?>
<?php if( $menu['category_id'] > 0 ) { ?>
<h3><?php echo sprintf($text_edit_menu, $menu['title'], $menu['category_id']);?></h3>
<?php } else { ?>
<h3><?php echo $text_create_new;?></h3>
<?php } ?>
<div>
	<h4><?php echo $this->language->get('text_category_information');?></h4>
		 <ul id="language-<?php echo $module_row; ?>" class="nav nav-tabs">
            <?php  $i=0; foreach ($languages as $language) { ?>
            <li class="<?php if( $i == 0): ?> active <?php endif; ?>"><a data-toggle="tab" href="#tab-language-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
            <?php $i++; }  ?>
          </ul>
          <div class="tab-content">
          <?php $i=0; foreach ($languages as $language) { ?>
          <div id="tab-language-<?php echo $language['language_id']; ?>" class="tab-pane <?php if( $i == 0): ?> active <?php endif; ?>"> 
            <table class="table table-striped table-bordered table-hover">
              <tr>
				<td>Title</td>
				<td><input  class="form-control" name="pavblog_category_description[<?php echo $language['language_id'];?>][title]" value="<?php echo $menu_description[$language['language_id']]['title'];?>"/></td>
              </tr>
			   <tr>
				<td><?php echo $this->language->get('entry_description');?></td>
				<td>
					<textarea class="form-control"name="pavblog_category_description[<?php echo $language['language_id'];?>][description]" value=""><?php echo $menu_description[$language['language_id']]['description'];?></textarea>
				</td>
              </tr>
            </table>
          </div>
           <?php $i++; }   ?>
     </div>
	 <table class="form">
		<tr>
			<td><?php echo $this->language->get('entry_parent_id');?></td>
				
			<td>
				<?php echo $menus;?>
 			</td>
		</tr>
		 <tr>
              <td><?php echo $entry_image;  ?></td>
              <td valign="top">
                  <div class="image">
                      <img src="<?php echo $thumb; ?>" alt="" id="thumb" />
                      <input type="hidden" name="pavblog_category[image]" value="<?php echo $menu['image']; ?>" id="image" />
                  </div>
                  
                  <div class="btn-group">
                      <button type="button" data-toggle="modal" data-target="#dialog" class="btn btn-info" onclick="image_upload('image', 'thumb');"><span class="fa fa-pencil"></span> <?php echo $text_browse; ?></button>
                      <button type="button" onclick="$('#thumb').attr('src', '<?php echo $no_image; ?>'); $('#image').attr('value', '');return false;" class="btn btn-danger"><span class="fa fa-trash-o"></span><?php echo $text_clear; ?></button>
                </div>
              </td>
            </tr>
		<tr>
			<td><?php echo $this->language->get('entry_menuclass');?></td>
				
			<td>
				<input type="text" class="form-control" name="pavblog_category[menu_class]" value="<?php echo $menu['menu_class']?>"/>
 			</td>
		</tr>	
	
	 
	</table>
	
	<div id="tab-meta">
		<h3><?php echo $this->language->get('text_seo_data');?></h3>
		<div class="pav-content" style="width:100%">
			<table class="form">
				<tr>
              <td><?php echo $this->language->get('entry_keyword'); ?></td>
              <td><input type="text" class="form-control" name="pavblog_category[keyword]" value="<?php echo $menu['keyword'];?>" size="90"/></td>
            </tr>
				<tr>
					<td><?php echo $this->language->get('entry_meta_title');?></td>
					<td><input type="text" class="form-control" name="pavblog_category[meta_title]" value="<?php echo $menu['meta_title'];?>"/></td>
				</tr>
				<tr>
					<td><?php echo $this->language->get('entry_meta_keyword');?></td>
					<td><textarea class="form-control" name="pavblog_category[meta_keyword]"><?php echo $menu['meta_keyword'];?></textarea></td>
				</tr>
				<tr>
					<td><?php echo $this->language->get('entry_meta_description');?></td>
					<td><textarea class="form-control" name="pavblog_category[meta_description]" rows="6" cols="40"><?php echo $menu['meta_description'];?></textarea></td>
				</tr>
			
				
			</table>
		</div>
	</div>
	<input type="hidden" name="pavblog_category[category_id]" value="<?php echo $menu['category_id']?>"/>
</div>
<?php endif; ?>

<script type="text/javascript"> 
$("#type_submenu-"+$("#pavblog_category-type_submenu").val()).show();
$("#pavblog_category-type_submenu").change( function(){
	$(".type_submenu").hide();
	$("#type_submenu-"+$(this).val()).show();
} );


  <?php foreach ($languages as $language) { ?>
CKEDITOR.replace('pavblog_category_description[<?php echo $language['language_id']; ?>][description]', {
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
<?php } ?>



   $( ".htabs a" ).tabs();
   $(".pavblog_categorytype").hide();
   $("#pavblog_categorytype-"+ $("#pavblog_categorytype").val()).show();
   $("#pavblog_categorytype").change( function(){
		$(".pavblog_categorytype").hide();
		$("#pavblog_categorytype-"+$(this).val()).show();
   } );
   
   




$('input[name=\'pavblog_category-manufacturer\']').autocomplete({
	delay: 500,
	source: function(request, response) {		
		$.ajax({
			url: 'index.php?route=catalog/manufacturer/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				json.unshift({
					'manufacturer_id':  0,
					'name':  '<?php echo $text_none; ?>'
				});
				
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.manufacturer_id
					}
				}));
			}
		});
	},
	select: function(event, ui) {
		$('input[name=\'pavblog_category-manufacturer\']').val(ui.item.label);
		$('input[name=\'pavblog_category[item]\']').val(ui.item.value);
		
		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});

$("#pavblog_category-information").change( function(){ 
	$('input[name=\'pavblog_category[item]\']').val($(this).val());
} );

$('input[name=\'pavblog_category-product\']').autocomplete({
	delay: 500,
	source: function(request, response) {		
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				json.unshift({
					'product_id':  0,
					'name':  '<?php echo $text_none; ?>'
				});
				 
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.product_id
					}
				}));
			}
		});
	},
	select: function(event, ui) {
		$('input[name=\'pavblog_category-product\']').val(ui.item.label);
		$('input[name=\'pavblog_category[item]\']').val(ui.item.value);
		
		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});

   
$('input[name=\'path\']').autocomplete({
	delay: 500,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/category/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				json.unshift({
					'category_id':  0,
					'name':  '<?php echo $text_none; ?>'
				});
				
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.category_id
					}
				}));
			}
		});
	},
	select: function(event, ui) {
		$('input[name=\'path\']').val(ui.item.label);
		$('input[name=\'pavblog_category[item]\']').val(ui.item.value);
		
		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});
</script>