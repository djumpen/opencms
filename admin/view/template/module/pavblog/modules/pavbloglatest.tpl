<?php
$module_key = isset($module_key)?$module_key:'pavbloglatest';
?>
    <div id="<?php echo $module_key; ?>">
         <ul class="nav nav-tabs">
          <?php $module_row = 1; ?>
          <?php foreach ($modules as $module) { ?>
          <li class="<?php if($module_row == 1): ?>active<?php endif; ?>">
          <a href="#tab-module-<?php echo $module_key; ?>-<?php echo $module_row; ?>" id="module-<?php echo $module_key; ?>-<?php echo $module_row; ?>" data-toggle="tab"><?php echo $this->language->get("tab_module") . ' ' . $module_row; ?>
            <i class="fa fa-times" onclick="$('#pavbloglatest .tab-content  > div').removeClass('active');$(this).parent().parent().parent().removeClass('active'); $(this).parent().parent().next().addClass('active');$(this).parent().parent().remove();$('#tab-module-<?php print $module_row; ?>').next().addClass('active');$('#tab-module-pavblogcategory-<?php print $module_row; ?>').remove(); "></i>
          </a>
            </li>
          <?php $module_row++; ?>
          <?php } ?>
              <button  id="module-add-<?php echo $module_key; ?>" type="button" onclick="addModuleLatest();" class="btn btn-primary"><i class="fa fa-plus-circle"></i><?php echo $button_add_module; ?></button>
          </ul>
          <div class="tab-content">
        <?php $module_row = 1; ?>
        <?php foreach ($modules as $module) { ?>
        <div id="tab-module-<?php echo $module_key; ?>-<?php echo $module_row; ?>" class="tab-pane <?php if( $module_row == 1): ?> active <?php endif; ?>">
          <ul id="language-<?php echo $module_key; ?>-<?php echo $module_row; ?>" class="nav nav-tabs">
             <?php $i=0; foreach ($languages as $language) { ?>
              <li class="<?php if( $i == 0): ?> active <?php endif; ?>"><a href="#tab-language-<?php echo $module_key; ?>-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
            <?php $i++; } ?>
          </ul>
           <div class="tab-content"> 
          <?php $i=0; foreach ($languages as $language) { ?>
          <div id="tab-language-<?php echo $module_key; ?>-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>" class="tab-pane <?php if ($i == 0): ?> active <?php endif; ?>">
            <table  class="table table-striped table-bordered">
              <tr>
                <td><?php echo $this->language->get("entry_description"); ?></td>
                <td><textarea name="pavbloglatest_module[<?php echo $module_row; ?>][description][<?php echo $language['language_id']; ?>]" id="description-<?php echo $module_key; ?>-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>"><?php echo isset($module['description'][$language['language_id']]) ? $module['description'][$language['language_id']] : ''; ?></textarea></td>
              </tr>
            </table>
          </div>
          <?php $i++; } ?>
          </div>
          <table  class="table table-striped table-bordered">
			<tr>
				<td>
				<?php echo $this->language->get("entry_tabs");?>
				</td>
				<td>
				  <select class="form-control" name="pavbloglatest_module[<?php echo $module_row; ?>][tabs]">
                  <?php foreach ($tabs as $tab => $tabName) { ?>
                  <?php if ( in_array($tab,(array)$module['tabs']) ) { ?>
                  <option value="<?php echo $tab; ?>" selected="selected"><?php echo $tabName; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $tab; ?>"><?php echo $tabName; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
				</td>
			</tr>
			<tr>
				<td><?php echo $entry_dimension; ?></td>
				<td class="left"><input type="text" class="form-control" name="pavbloglatest_module[<?php echo $module_row; ?>][width]" value="<?php echo $module['width']; ?>" size="3" />
                <input type="text" class="form-control" name="pavbloglatest_module[<?php echo $module_row; ?>][height]" value="<?php echo $module['height']; ?>" size="3"/>
                <?php if (isset($error_dimension[$module_row])) { ?>
                <span class="error"><?php echo $error_dimension[$module_row]; ?></span>
                <?php } ?></td>	
			</tr>
			<tr>
				 <td class="left"><?php echo $this->language->get("entry_carousel"); ?></td>
				  <td class="left">
                <input type="text" class="form-control" name="pavbloglatest_module[<?php echo $module_row; ?>][cols]" value="<?php echo $module['cols']; ?>" size="3"/> - 
				<input type="text" class="form-control" name="pavbloglatest_module[<?php echo $module_row; ?>][limit]" value="<?php echo $module['limit']; ?>" size="3"/>
                <?php if (isset($error_carousel[$module_row])) { ?>
                <span class="error"><?php echo $error_carousel[$module_row]; ?></span>
                <?php } ?></td>
			</tr>
            <tr>
              <td><?php echo $entry_layout; ?></td>
              <td><select class="form-control" name="pavbloglatest_module[<?php echo $module_row; ?>][layout_id]">
                 <?php foreach ($layouts as $layout) { ?>
                  <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                  <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_position; ?></td>
              <td><select class="form-control" name="pavbloglatest_module[<?php echo $module_row; ?>][position]">
                  <?php foreach( $positions as $pos ) { ?>
                  <?php if ($module['position'] == $pos) { ?>
                  <option value="<?php echo $pos;?>" selected="selected"><?php echo $this->language->get('text_'.$pos); ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $pos;?>"><?php echo $this->language->get('text_'.$pos); ?></option>
                  <?php } ?>
                  <?php } ?> 
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_status; ?></td>
              <td><select class="form-control" name="pavbloglatest_module[<?php echo $module_row; ?>][status]">
                  <?php if ($module['status']) { ?>
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
              <td><input type="text" class="form-control" name="pavbloglatest_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
            </tr>
          </table>
        </div>
        <?php $module_row++; ?>
        <?php } ?>
        </div>
      </div>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 

<script type="text/javascript"><!--
<?php $module_row = 1; ?>
<?php foreach ($modules as $module) { ?>
<?php foreach ($languages as $language) { ?>
CKEDITOR.replace('description-<?php echo $module_key; ?>-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>', {
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
<?php } ?>
<?php $module_row++; ?>
<?php } ?>
//--></script> 
<script type="text/javascript"><!--
var module_row_latest = <?php echo $module_row; ?>;

function addModuleLatest() {	
	html  = '<div id="tab-module-<?php echo $module_key; ?>-' + module_row_latest + '" class="vtabs-content">';
	html += '  <ul id="language-<?php echo $module_key; ?>-' + module_row_latest + '" class="nav nav-tabs">';
    <?php $i= 0; foreach ($languages as $language) { ?>
    html += '    <li class="<?php if($i==0) :?> active <?php endif; ?>"><a href="#tab-language-<?php echo $module_key; ?>-'+ module_row_latest + '-<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>';
    <?php $i++;} ?>
	html += '  </ul>';
    html += '  <div class="tab-content">';  
	<?php $i= 0; foreach ($languages as $language) { ?>
	html += '    <div id="tab-language-<?php echo $module_key; ?>-'+ module_row_latest + '-<?php echo $language['language_id']; ?>" class="tab-pane <?php if($i==0) :?> active <?php endif; ?>">';
	html += '      <table  class="table table-striped table-bordered">';
	html += '        <tr>';
	html += '          <td><?php echo $this->language->get("entry_description"); ?></td>';
	html += '          <td><textarea name="pavbloglatest_module[' + module_row_latest + '][description][<?php echo $language['language_id']; ?>]" id="description-<?php echo $module_key; ?>-' + module_row_latest + '-<?php echo $language['language_id']; ?>"></textarea></td>';
	html += '        </tr>';
	html += '      </table>';
	html += '    </div>';
	<?php $i++;} ?>
    html += '    </div>';
	html += '  <table  class="table table-striped table-bordered">';
		html += '  <tr>';
	html += '      <td><?php echo $this->language->get("entry_tabs"); ?></td>';		
	html += '    <td class="left"><select class="form-control" name="pavbloglatest_module[' + module_row_latest + '][tabs]"  >';
	<?php foreach ($tabs as $tab => $tabName ) { ?>
	html += '      <option value="<?php echo $tab; ?>"><?php echo addslashes($tabName); ?></option>';
	<?php } ?>
	html += '    </select></td>';
		html += '    <tr>';
	html += '      <td><?php echo $entry_dimension; ?></td>';
	html += '    <td class="left"><input type="text" class="form-control" name="pavbloglatest_module[' + module_row_latest + '][width]" value="" size="3" /> <input type="text" class="form-control" name="pavbloglatest_module[' + module_row_latest + '][height]" value="" size="3" /></td>';
	html += '    <tr>';
	html += '    </tr>';
	html += '      <td><?php echo $this->language->get("entry_carousel"); ?></td>';
	html += '    <td class="left"><input type="text" class="form-control" name="pavbloglatest_module[' + module_row_latest + '][cols]" value="4" size="3" /> - <input type="text" class="form-control" name="pavbloglatest_module[' + module_row_latest + '][limit]" value="16" size="3" /></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_layout; ?></td>';
	html += '      <td><select class="form-control" name="pavbloglatest_module[' + module_row_latest + '][layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	html += '           <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
	<?php } ?>
	html += '      </select></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_position; ?></td>';
	html += '      <td><select class="form-control" name="pavbloglatest_module[' + module_row_latest + '][position]">';
	<?php foreach( $positions as $pos ) { ?>
	html += '<option value="<?php echo $pos;?>"><?php echo $this->language->get('text_'.$pos); ?></option>';      
	<?php } ?>		html += '      </select></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_status; ?></td>';
	html += '      <td><select class="form-control" name="pavbloglatest_module[' + module_row_latest + '][status]">';
	html += '        <option value="1"><?php echo $text_enabled; ?></option>';
	html += '        <option value="0"><?php echo $text_disabled; ?></option>';
	html += '      </select></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_sort_order; ?></td>';
	html += '      <td><input type="text" class="form-control" name="pavbloglatest_module[' + module_row_latest + '][sort_order]" value="" size="3" /></td>';
	html += '    </tr>';
	html += '  </table>'; 
	html += '</div>';
	
	  $('#pavbloglatest .nav-tabs > li').removeClass('active');
    $('#pavbloglatest .tab-content .tab-pane').removeClass('active');
   $('#pavbloglatest .tab-content').append(html); 
    
    
    
    $('#module-add-<?php echo $module_key; ?>').before('<li class="active"><a href="#tab-module-<?php echo $module_key; ?>-' + module_row_latest + '" id="module-<?php echo $module_key; ?>-' + module_row_latest + '"  data-toggle="tab"><?php echo $this->language->get("tab_module"); ?> ' + module_row_latest  + '<i class="fa fa-times" onclick="$(this).parent().parent().next().addClass(\'active\');$(this).parent().parent().remove();$(\'#tab-module-' + module_row_latest + '\').next().addClass(\'active\');$(\'#tab-module-<?php echo $module_key; ?>-' + module_row_latest + '\').remove();"></i></a></li>');
    
    
	
	
	<?php foreach ($languages as $language) { ?>
	CKEDITOR.replace('description-<?php echo $module_key; ?>-' + module_row_latest + '-<?php echo $language['language_id']; ?>', {
		filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
	});  
	<?php } ?>
	
	 
	
	
	module_row_latest++;
}
//--></script> 
<script type="text/javascript"><!--
$('#<?php echo $module_key; ?> .vtabs a').tabs();
//--></script> 
<script type="text/javascript"><!--
<?php $module_row = 1; ?>
<?php foreach ($modules as $module) { ?>
$('#language-<?php echo $module_key; ?>-<?php echo $module_row; ?> a').tabs();
<?php $module_row++; ?>
<?php } ?> 
//--></script> 