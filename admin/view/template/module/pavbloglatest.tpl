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
        <button type="submit" form="form-category" class="btn btn-primary" onclick="$('#form').submit();"><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
        <button  class="btn btn-danger " onclick="location = '<?php echo $cancel; ?>';"><i class="fa fa-times"></i> <?php echo $button_cancel; ?></button>
      </div>
      <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    </div>
     <div class="panel-body">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
         <ul class="nav nav-tabs">
            <?php $module_row = 1; ?>
            <?php foreach ($modules as $module) { ?>
            <li class="<?php if($module_row == 1): ?>active<?php endif; ?>">
            <a href="#tab-module-<?php echo $module_row; ?>" data-toggle="tab"><?php echo $tab_module . ' ' . $module_row; ?>
            <i class="fa fa-times" onclick="$('.tab-content > div').removeClass('active');$(this).parent().parent().parent().children().removeClass('active'); $(this).parent().parent().next().addClass('active');$(this).parent().parent().remove();$('#tab-module-<?php print $module_row; ?>').next().addClass('active');$('#tab-module-<?php print $module_row; ?>').remove(); "></i>
            </a>
            </li>
            <?php $module_row++; ?>
            <?php } ?>
            <button id="module-add" type="button" onclick="addModule();" class="btn btn-primary"><i class="fa fa-plus-circle"></i><?php echo $button_add_module; ?></button>
        </ul>
        <div class="tab-content">
        <?php $module_row = 1; ?>
        <?php foreach ($modules as $module) { ?>
        <div id="tab-module-<?php echo $module_row; ?>"  class="tab-pane <?php if( $module_row == 1): ?> active <?php endif; ?>">
          <ul class="nav nav-tabs" id="language-<?php echo $module_row; ?>">
            <?php $i=0; foreach ($languages as $language) { ?>
            <li class="<?php if( $i == 0): ?> active <?php endif; ?>"><a href="#tab-language-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
            <?php $i++; } ?>
          </ul> 
          <div class="tab-content"> 
            <?php $i=0; foreach ($languages as $language) { ?>
            <div id="tab-language-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>" class="tab-pane <?php if ($i == 0): ?> active <?php endif; ?>" >
            <table class="table table-striped table-bordered table-hover">
              <tr>
                <td><?php echo $entry_description; ?></td>
                <td><textarea name="pavbloglatest_module[<?php echo $module_row; ?>][description][<?php echo $language['language_id']; ?>]" id="description-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>"><?php echo isset($module['description'][$language['language_id']]) ? $module['description'][$language['language_id']] : ''; ?></textarea></td>
              </tr>
            </table>
          </div>
          <?php $i++; } ?>
          </div>
          <table class="table table-striped table-bordered table-hover">
			<tr>
				<td>
				<?php echo $entry_tabs;?>
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
				 <td class="left"><?php echo $entry_carousel; ?></td>
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
      </form>
    </div>
  </div>
</div>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<script type="text/javascript"><!--
<?php $module_row = 1; ?>
<?php foreach ($modules as $module) { ?>
<?php foreach ($languages as $language) { ?>
CKEDITOR.replace('description-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>', {
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
var module_row = <?php echo $module_row; ?>;

function addModule() {  
    html  = '<div id="tab-module-' + module_row + '" class="tab-pane active">';
    html += '  <ul class="nav nav-tabs" id="language-' + module_row + '">';
    <?php $i= 0; foreach ($languages as $language) { ?>
    html += '    <li class="<?php if($i==0) :?> active <?php endif; ?>"><a data-toggle="tab" href="#tab-language-'+ module_row + '-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>';
     <?php $i++;} ?>
    html += '  </ul>';
     html += '  <div class="tab-content">';  
   <?php $i= 0; foreach ($languages as $language) { ?>
    html += '    <div id="tab-language-'+ module_row + '-<?php echo $language['language_id']; ?>" class="tab-pane <?php if($i==0) :?> active <?php endif; ?>">';
    html += '      <table class="table table-striped table-bordered table-hover">';
    html += '        <tr>';
    html += '          <td><?php echo $entry_description; ?></td>';
    html += '          <td><textarea name="pavbloglatest_module[' + module_row + '][description][<?php echo $language['language_id']; ?>]" id="description-' + module_row + '-<?php echo $language['language_id']; ?>"></textarea></td>';
    html += '        </tr>';
    html += '      </table>';
    html += '    </div>';
     <?php $i++;} ?>
      html += '    </div>';
    html += '  <table class="table table-striped table-bordered table-hover">';
        html += '  <tr>';
    html += '      <td><?php echo $entry_tabs; ?></td>';        
    html += '    <td class="left"><select class="form-control" name="pavbloglatest_module[' + module_row + '][tabs]"  >';
    <?php foreach ($tabs as $tab => $tabName ) { ?>
    html += '      <option value="<?php echo $tab; ?>"><?php echo addslashes($tabName); ?></option>';
    <?php } ?>
    html += '    </select></td>';
        html += '    <tr>';
    html += '      <td><?php echo $entry_dimension; ?></td>';
    html += '    <td class="left"><input type="text" class="form-control" name="pavbloglatest_module[' + module_row + '][width]" value="" size="3" /> <input type="text" class="form-control" name="pavbloglatest_module[' + module_row + '][height]" value="" size="3" /></td>';
    html += '    <tr>';
    html += '    </tr>';
    html += '      <td><?php echo $entry_carousel; ?></td>';
    html += '    <td class="left"><input type="text" class="form-control" name="pavbloglatest_module[' + module_row + '][cols]" value="4" size="3" /> - <input type="text" class="form-control" name="pavbloglatest_module[' + module_row + '][limit]" value="16" size="3" /></td>';
    html += '    </tr>';
    html += '    <tr>';
    html += '      <td><?php echo $entry_layout; ?></td>';
    html += '      <td><select class="form-control" name="pavbloglatest_module[' + module_row + '][layout_id]">';
    <?php foreach ($layouts as $layout) { ?>
    html += '           <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
    <?php } ?>
    html += '      </select></td>';
    html += '    </tr>';
    html += '    <tr>';
    html += '      <td><?php echo $entry_position; ?></td>';
    html += '      <td><select class="form-control" name="pavbloglatest_module[' + module_row + '][position]">';
    <?php foreach( $positions as $pos ) { ?>
    html += '<option value="<?php echo $pos;?>"><?php echo $this->language->get('text_'.$pos); ?></option>';      
    <?php } ?>      html += '      </select></td>';
    html += '    </tr>';
    html += '    <tr>';
    html += '      <td><?php echo $entry_status; ?></td>';
    html += '      <td><select class="form-control" name="pavbloglatest_module[' + module_row + '][status]">';
    html += '        <option value="1"><?php echo $text_enabled; ?></option>';
    html += '        <option value="0"><?php echo $text_disabled; ?></option>';
    html += '      </select></td>';
    html += '    </tr>';
    html += '    <tr>';
    html += '      <td><?php echo $entry_sort_order; ?></td>';
    html += '      <td><input type="text" class="form-control" name="pavbloglatest_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
    html += '    </tr>';
    html += '  </table>'; 
    html += '</div>';
    
        $('#form > .nav-tabs > li').removeClass('active');
        $('#form > .tab-content > .tab-pane').removeClass('active');
        
        $('#form > .tab-content').append(html); 
    
    <?php foreach ($languages as $language) { ?>
    CKEDITOR.replace('description-' + module_row + '-<?php echo $language['language_id']; ?>', {
        filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
        filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
        filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
        filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
        filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
        filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
    });  
    <?php } ?>
    
    $('#language-' + module_row + ' a').tabs();
    
$('#module-add').before('<li class="active"><a href="#tab-module-' + module_row + '" modid ="' + module_row + '" id="module-' + module_row + '"  data-toggle="tab"><?php echo $tab_module; ?> ' + module_row + '<i class="fa fa-times" onclick="$(this).parent().parent().next().addClass(\'active\');$(this).parent().parent().remove();$(\'#tab-module-' + module_row + '\').next().addClass(\'active\');$(\'#tab-module-' + module_row + '\').remove();"></i></a></li>');
        
    $('.vtabs a').tabs();
    
    $('#module-' + module_row).trigger('click');
    
    module_row++;
}
//--></script> 
<script type="text/javascript"><!--
$('.vtabs a').tabs();
//--></script> 
<script type="text/javascript"><!--
<?php $module_row = 1; ?>
<?php foreach ($modules as $module) { ?>
$('#language-<?php echo $module_row; ?> a').tabs();
<?php $module_row++; ?>
<?php } ?> 
//--></script> 
<?php echo $footer; ?>