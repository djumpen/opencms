<?php $module_key = isset($module_key)?$module_key:'pavblogcomment'; ?>

      <div id="<?php echo $module_key; ?>">
           <ul class="nav nav-tabs">
          <?php $module_row = 1; ?>
          <?php foreach ($modules as $module) { ?>
          <li class="<?php if($module_row == 1): ?>active<?php endif; ?>">
          <a href="#tab-module-<?php echo $module_key; ?>-<?php echo $module_row; ?>" id="module-<?php echo $module_key; ?>-<?php echo $module_row; ?>" data-toggle="tab"><?php echo $this->language->get("tab_module") . ' ' . $module_row; ?>
            <i class="fa fa-times" onclick="$('#pavblogcomment .tab-content  > div').removeClass('active');$(this).parent().parent().parent().removeClass('active'); $(this).parent().parent().next().addClass('active');$(this).parent().parent().remove();$('#tab-module-<?php print $module_row; ?>').next().addClass('active');$('#tab-module-comment-<?php print $module_row; ?>').remove(); "></i>
          </a>
            </li>
          <?php $module_row++; ?>
          <?php } ?>
              <button  id="module-add-<?php echo $module_key; ?>" type="button" onclick="addModuleComment();" class="btn btn-primary"><i class="fa fa-plus-circle"></i><?php echo $button_add_module; ?></button>
          </ul>
            <div class="tab-content">
        <?php $module_row = 1; ?>
        <?php foreach ($modules as $module) { ?>
        <div id="tab-module-<?php echo $module_key; ?>-<?php echo $module_row; ?>" class="tab-pane <?php if( $module_row == 1): ?> active <?php endif; ?>">
         
		
          <table  class="table table-striped table-bordered">
		
			<tr>
				 <td class="left"><?php echo $this->language->get("entry_carousel"); ?></td>
				  <td class="left">
        
				<input type="text" class="form-control" name="pavblogcomment_module[<?php echo $module_row; ?>][limit]" value="<?php echo $module['limit']; ?>" size="3"/>
                <?php if (isset($error_carousel[$module_row])) { ?>
                <span class="error"><?php echo $error_carousel[$module_row]; ?></span>
                <?php } ?></td>
			</tr>
            <tr>
              <td><?php echo $entry_layout; ?></td>
              <td><select class="form-control" name="pavblogcomment_module[<?php echo $module_row; ?>][layout_id]">
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
              <td><select class="form-control" name="pavblogcomment_module[<?php echo $module_row; ?>][position]">
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
              <td><select class="form-control" name="pavblogcomment_module[<?php echo $module_row; ?>][status]">
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
              <td><input type="text" class="form-control" name="pavblogcomment_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
            </tr>
          </table>
        </div>
        <?php $module_row++; ?>
        <?php } ?>
        </div>
      </div>
<script type="text/javascript"><!--
var module_row_comment = <?php echo $module_row; ?>;

function addModuleComment() {	
	html  = '<div id="tab-module-<?php echo $module_key; ?>-' + module_row_comment + '" class="tab-pane active">';
	html += '  <table  class="table table-striped table-bordered">';

	html += '      <td><?php echo $this->language->get("entry_carousel"); ?></td>';
	html += '    <td class="left"><input type="text" class="form-control"  <input type="text" class="form-control" name="pavblogcomment_module[' + module_row_comment + '][limit]" value="6" size="3" /></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_layout; ?></td>';
	html += '      <td><select class="form-control" name="pavblogcomment_module[' + module_row_comment + '][layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	html += '           <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
	<?php } ?>
	html += '      </select></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_position; ?></td>';
	html += '      <td><select class="form-control" name="pavblogcomment_module[' + module_row_comment + '][position]">';
	<?php foreach( $positions as $pos ) { ?>
	html += '<option value="<?php echo $pos;?>"><?php echo $this->language->get('text_'.$pos); ?></option>';      
	<?php } ?>		html += '      </select></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_status; ?></td>';
	html += '      <td><select class="form-control" name="pavblogcomment_module[' + module_row_comment + '][status]">';
	html += '        <option value="1"><?php echo $text_enabled; ?></option>';
	html += '        <option value="0"><?php echo $text_disabled; ?></option>';
	html += '      </select></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_sort_order; ?></td>';
	html += '      <td><input type="text" class="form-control" name="pavblogcomment_module[' + module_row_comment + '][sort_order]" value="" size="3" /></td>';
	html += '    </tr>';
	html += '  </table>'; 
	html += '</div>';
	
	$('#pavblogcomment .nav-tabs > li').removeClass('active');
    $('#pavblogcomment .tab-content .tab-pane').removeClass('active');
    $('#pavblogcomment .tab-content').append(html); 
    
    
    
    $('#module-add-<?php echo $module_key; ?>').before('<li class="active"><a href="#tab-module-<?php echo $module_key; ?>-' + module_row_comment + '" id="module-<?php echo $module_key; ?>-' + module_row_comment + '"  data-toggle="tab"><?php echo $this->language->get("tab_module"); ?> ' + module_row_comment  + '<i class="fa fa-times" onclick="$(this).parent().parent().next().addClass(\'active\');$(this).parent().parent().remove();$(\'#tab-module-' + module_row_comment + '\').next().addClass(\'active\');$(\'#tab-module-<?php echo $module_key; ?>-' + module_row_comment + '\').remove();"></i></a></li>');
    
	$('#<?php echo $module_key; ?> .vtabs a').tabs();
	
	$('#module-<?php echo $module_key; ?>-' + module_row_comment).trigger('click');
	
	module_row_comment++;
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
