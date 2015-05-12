<?php print $header; ?>
<div id="content" class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php print $breadcrumb['href']; ?>"><?php print $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if (!empty($errors)) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php print $error_warning; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div class="panel panel-default">
    <div class="panel-heading">
      <div class="pull-right">
      <h1 class="panel-title"><?php print $heading_title; ?></h1>
    </div>
    <div class="panel-body">
      <form action="<?php print $action; ?>" method="post" enctype="multipart/form-data" id="form-oc_menu">
        <table id="module" class="table table-striped table-bordered table-hover">
          <thead>
            <tr>
              <td class="text-left width-20"><?php print $entry_layout; ?></td>
              <td class="text-left" style="width: 150px;"><?php print $entry_position; ?></td>
              <td class="text-left" style="width: 150px;"><?php print $entry_status; ?></td>
              <td class="text-left width-20"><?php print $entry_note; ?></td>
              <td class="text-left width-20"><?php print $entry_sort_order; ?></td>
              <td class="text-right width-30"><?php print $entry_actions; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php $group_id = 0; ?>
            <?php foreach ($modules as $module) { ?>
            <tr id="module-row<?php print $module['group_id']; ?>" group-id="<?php print $module['group_id']; ?>">
              <input type="hidden" name="oc_menu_module[<?php print $module['group_id']; ?>][group_id]" value="<?php print $module['group_id']; ?>" />
              <td class="text-left"><select name="oc_menu_module[<?php print $module['group_id']; ?>][layout_id]" class="form-control">
                  <?php foreach ($layouts as $layout) { ?>
                  <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                  <option value="<?php print $layout['layout_id']; ?>" selected="selected"><?php print $layout['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php print $layout['layout_id']; ?>"><?php print $layout['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
              <td class="text-left"><select name="oc_menu_module[<?php print $module['group_id']; ?>][position]" class="form-control">
                  <?php if ($module['position'] == 'mainmenu') { ?>
                  <option value="mainmenu" selected="selected"><?php print $text_mainmenu; ?></option>
                  <?php } else { ?>
                  <option value="mainmenu"><?php print $text_mainmenu; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'slideshow') { ?>
                  <option value="slideshow" selected="selected"><?php print $text_slideshow; ?></option>
                  <?php } else { ?>
                  <option value="slideshow"><?php print $text_slideshow; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'information_menu') { ?>
                  <option value="information_menu" selected="selected"><?php print $text_information_menu; ?></option>
                  <?php } else { ?>
                  <option value="information_menu"><?php print $text_information_menu; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'content_top') { ?>
                  <option value="content_top" selected="selected"><?php print $text_content_top; ?></option>
                  <?php } else { ?>
                  <option value="content_top"><?php print $text_content_top; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'content_bottom') { ?>
                  <option value="content_bottom" selected="selected"><?php print $text_content_bottom; ?></option>
                  <?php } else { ?>
                  <option value="content_bottom"><?php print $text_content_bottom; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'column_left') { ?>
                  <option value="column_left" selected="selected"><?php print $text_column_left; ?></option>
                  <?php } else { ?>
                  <option value="column_left"><?php print $text_column_left; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'column_right') { ?>
                  <option value="column_right" selected="selected"><?php print $text_column_right; ?></option>
                  <?php } else { ?>
                  <option value="column_right"><?php print $text_column_right; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'footer') { ?>
                  <option value="footer" selected="selected"><?php print $text_footer; ?></option>
                  <?php } else { ?>
                  <option value="footer"><?php print $text_footer; ?></option>
                  <?php } ?>
                </select></td>
              <td class="text-left"><select name="oc_menu_module[<?php print $module['group_id']; ?>][status]" class="form-control">
                  <?php if ($module['status']) { ?>
                  <option value="1" selected="selected"><?php print $text_enabled; ?></option>
                  <option value="0"><?php print $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php print $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php print $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
              <td class="text-left">
              <textarea class="form-control" style="width: 100%;height: 50px;resize: none;" name="oc_menu_module[<?php print $module['group_id']; ?>][note]"><?php print $module['note']; ?></textarea>
              </td>
              <td class="text-left">
              	<input class="form-control" name="oc_menu_module[<?php print $module['group_id']; ?>][sort_order]" value="<?php print $module['sort_order']; ?>">
              </td>
              <td class="text-right actions">
              	<button type="button" group-id="<?php print $module['group_id']; ?>" class="btn btn-warning edit"><i class="fa fa-pencil-square-o"></i> <?php print $button_edit; ?></button>
              	<button type="button" group-id="<?php print $module['group_id']; ?>" class="btn btn-danger delete"><i class="fa fa-minus-circle"></i> <?php print $button_remove; ?></button>
              </td>
            </tr>
            <?php $group_id = $module['group_id']; ?>
            <?php } ?>
          </tbody>
          <tfoot>
            <tr>
              <td colspan="5"></td>
              <td class="text-right">
              	<button type="button" class="btn btn-success save-list"><i class="fa fa-save"></i> <?php print $button_apply; ?></button>
              	<button type="button" onclick="addModule();" class="btn btn-primary"><i class="fa fa-plus-circle"></i> <?php print $button_add_module; ?></button>
              </td>
            </tr>
          </tfoot>
        </table>
      </form>
    </div>
  </div>
</div>

<?php /* Some scripts */ ?>
<script type="text/javascript"><!--
var module_row = <?php print $group_id; ?>;
module_row++;
function addModule() {	
	html  = '<tr id="module-row' + module_row + '">';
	html += '<input type="hidden" name="oc_menu_module[' + module_row + '][group_id]" value="' + module_row + '" />';
	html += '  <td class="text-left"><select name="oc_menu_module[' + module_row + '][layout_id]" class="form-control">';
	<?php foreach ($layouts as $layout) { ?>
	html += '    <option value="<?php print $layout['layout_id']; ?>"><?php print addslashes($layout['name']); ?></option>';
	<?php } ?>
	html += '  </select></td>';
	html += '  <td class="text-left"><select name="oc_menu_module[' + module_row + '][position]" class="form-control">';
	html += '    <option value="mainmenu"><?php print $text_mainmenu;?></option>';
	html += '    <option value="slideshow"><?php print $text_slideshow;?></option>';
	html += '    <option value="information_menu"><?php print $text_information_menu; ?></option>';
	html += '    <option value="content_top"><?php print $text_content_top; ?></option>';
	html += '    <option value="content_bottom"><?php print $text_content_bottom; ?></option>';
	html += '    <option value="column_left"><?php print $text_column_left; ?></option>';
	html += '    <option value="column_right"><?php print $text_column_right; ?></option>';
	html += '    <option value="footer"><?php print $text_footer; ?></option>';
	html += '  </select></td>';
	html += '  <td class="text-left"><select name="oc_menu_module[' + module_row + '][status]" class="form-control">';
    html += '    <option value="1" selected="selected"><?php print $text_enabled; ?></option>';
    html += '    <option value="0"><?php print $text_disabled; ?></option>';
    html += '  </select></td>';
    html += '  <td class="text-left"><textarea class="form-control" style="width: 100%;height: 50px;resize: none;" name="oc_menu_module[' + module_row + '][note]"></textarea></td>';
    html += '  <td class="text-left"><input class="form-control" name="oc_menu_module[' + module_row + '][sort_order]" value="0"></td>';
	html += '  <td class="text-right actions"><button type="button" group-id="' + module_row + '" class="btn btn-warning edit hidden"><i class="fa fa-pencil-square-o"></i> <?php print $button_edit; ?></button>&nbsp;<button type="button" group-id="' + module_row + '" class="btn btn-danger delete"><i class="fa fa-minus-circle"></i> <?php print $button_remove; ?></button></td>';
	html += '</tr>';
	
	$('#module tbody').append(html);
	
	module_row++;
}
//--></script>
<?php /* Some scripts */ ?>

<?php print $footer; ?>