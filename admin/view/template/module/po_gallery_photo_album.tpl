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
    <a onclick="$('#form').submit();" class="btn btn-success"><i class="fa fa-check"></i> <span><?php echo $button_save; ?></span></a>
    <a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
     <h1 class="panel-title"><?php echo $heading_title; ?></h1>
    </div>
  </div>
  <div class="content">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      <table id="module" class="table table-striped table-bordered table-hover">
        <thead>
          <tr>
          	<td class="left"><?php echo $entry_title; ?></td>
            <td class="left"><?php echo $entry_album_per_row; ?></td>
            <td class="left"><?php echo $entry_sort; ?></td>
            <td class="left"><?php echo $entry_limit; ?></td>
            <td class="left"><?php echo $entry_layout; ?></td>
            <td class="left"><?php echo $entry_position; ?></td>
            <td class="left"><?php echo $entry_status; ?></td>
            <td class="right"><?php echo $entry_sort_order; ?></td>
            <td></td>
          </tr>
        </thead>
        <?php $module_row = 0; ?>
        <?php foreach ($modules as $module) { ?>
        <tbody id="module-row<?php echo $module_row; ?>">
          <tr>
          	<td class="left"><input class="form-control" type="text" name="po_gallery_photo_album_module[<?php echo $module_row; ?>][title]" value="<?php echo $module['title']; ?>" size="40" /></td>
            <td class="left"><select class="form-control" name="po_gallery_photo_album_module[<?php echo $module_row; ?>][apr]">
                <?php if ($module['apr'] == 50) { ?>
                <option value="50" selected="selected">2 Albums</option>
                <option value="33">3 Albums</option>
                <option value="25">4 Albums</option>
                <option value="20">5 Albums</option>
                <option value="16.6">6 Albums</option>
                <?php } ?>
                <?php if ($module['apr'] == 33) { ?>
                <option value="50">2 Albums</option>
                <option value="33" selected="selected">3 Albums</option>
                <option value="25">4 Albums</option>
                <option value="20">5 Albums</option>
                <option value="16.6">6 Albums</option>
                <?php } ?>
                <?php if ($module['apr'] == 25) { ?>
                <option value="50">2 Albums</option>
                <option value="33">3 Albums</option>
                <option value="25" selected="selected">4 Albums</option>
                <option value="20">5 Albums</option>
                <option value="16.6">6 Albums</option>
                <?php } ?>
                <?php if ($module['apr'] == 20) { ?>
                <option value="50">2 Albums</option>
                <option value="33">3 Albums</option>
                <option value="25">4 Albums</option>
                <option value="20" selected="selected">5 Albums</option>
                <option value="16.6">6 Albums</option>
                <?php } ?>
                <?php if ($module['apr'] == 16.6) { ?>
                <option value="50">2 Albums</option>
                <option value="33">3 Albums</option>
                <option value="25">4 Albums</option>
                <option value="20">5 Albums</option>
                <option value="16.6" selected="selected">6 Albums</option>
                <?php } ?>
              </select></td>
            <td class="left"><select class="form-control" name="po_gallery_photo_album_module[<?php echo $module_row; ?>][sort]">
                <?php if ($module['sort'] == 'latest') { ?>
                <option value="latest" selected="selected">Latest</option>
                <option value="viewed">Viewed</option>
                <option value="name">Name</option>
                <option value="rating">Rating</option>
                <?php } ?>
                <?php if ($module['sort'] == 'viewed') { ?>
                <option value="latest">Latest</option>
                <option value="viewed" selected="selected">Viewed</option>
                <option value="name">Name</option>
                <option value="rating">Rating</option>
                <?php } ?>
                <?php if ($module['sort'] == 'name') { ?>
                <option value="latest">Latest</option>
                <option value="viewed">Viewed</option>
                <option value="name" selected="selected">Name</option>
                <option value="rating">Rating</option>
                <?php } ?>
                <?php if ($module['sort'] == 'rating') { ?>
                <option value="latest">Latest</option>
                <option value="viewed">Viewed</option>
                <option value="name">Name</option>
                <option value="rating" selected="selected">Rating</option>
                <?php } ?>
              </select></td>
            <td class="left"><input class="form-control" type="text" name="po_gallery_photo_album_module[<?php echo $module_row; ?>][limit]" value="<?php echo $module['limit']; ?>" size="1" /></td>
            <td class="left"><select class="form-control" name="po_gallery_photo_album_module[<?php echo $module_row; ?>][layout_id]">
                <?php foreach ($layouts as $layout) { ?>
                <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
            <td class="left"><select class="form-control" name="po_gallery_photo_album_module[<?php echo $module_row; ?>][position]">
                <?php if ($module['position'] == 'content_top') { ?>
                <option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
                <?php } else { ?>
                <option value="content_top"><?php echo $text_content_top; ?></option>
                <?php } ?>
                <?php if ($module['position'] == 'content_bottom') { ?>
                <option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
                <?php } else { ?>
                <option value="content_bottom"><?php echo $text_content_bottom; ?></option>
                <?php } ?>
                <?php if ($module['position'] == 'column_left') { ?>
                <option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
                <?php } else { ?>
                <option value="column_left"><?php echo $text_column_left; ?></option>
                <?php } ?>
                <?php if ($module['position'] == 'column_right') { ?>
                <option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
                <?php } else { ?>
                <option value="column_right"><?php echo $text_column_right; ?></option>
                <?php } ?>
              </select></td>
            <td class="left"><select class="form-control" name="po_gallery_photo_album_module[<?php echo $module_row; ?>][status]">
                <?php if ($module['status']) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
            <td class="right"><input class="form-control" type="text" name="po_gallery_photo_album_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
            <td class="left"><button type="button" onclick="addModule();" class="btn btn-primary"><i class="fa fa-plus-circle"></i> <?php echo $button_add_module; ?></button></td>
          </tr>
        </tbody>
        <?php $module_row++; ?>
        <?php } ?>
        <tfoot>
          <tr>
            <td colspan="8"></td>
            <td class="text-left"><button type="button" onclick="addModule();" class="btn btn-primary"><i class="fa fa-plus-circle"></i> <?php echo $button_add_module; ?></button></td>
          </tr>
        </tfoot>
      </table>
    </form>
  </div>
</div>
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {	
	html  = '<tbody id="module-row' + module_row + '">';
	html += '  <tr>';
	html += '    <td class="left"><input class="form-control" type="text" name="po_gallery_photo_album_module[' + module_row + '][title]" value="Gallery Photo Album ' + module_row + ' " size="40" /></td>';
	html += '    </select></td>';
	html += '    <td class="left"><select class="form-control" name="po_gallery_photo_album_module[' + module_row + '][apr]">';
    html += '      <option value="50">2 Albums</option>';
    html += '      <option value="33">3 Albums</option>';
	html += '      <option value="25">4 Albums</option>';
	html += '      <option value="20" selected="selected">5 Albums</option>';
	html += '      <option value="16.6">6 Albums</option>';
    html += '    </select></td>';
	html += '    </select></td>';
	html += '    <td class="left"><select class="form-control" name="po_gallery_photo_album_module[' + module_row + '][sort]">';
    html += '      <option value="latest" selected="selected">Latest</option>';
	html += '      <option value="viewed">Viewed</option>';
	html += '      <option value="name">Name</option>';
	html += '      <option value="rating">Rating</option>';
    html += '    </select></td>';
	html += '    <td class="left"><input class="form-control" type="text" name="po_gallery_photo_album_module[' + module_row + '][limit]" value="5" size="1" /></td>';
	html += '    <td class="left"><select class="form-control" name="po_gallery_photo_album_module[' + module_row + '][layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="left"><select class="form-control" name="po_gallery_photo_album_module[' + module_row + '][position]">';
	html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
	html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
	html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
	html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
	html += '    </select></td>';
	html += '    <td class="left"><select class="form-control" name="po_gallery_photo_album_module[' + module_row + '][status]">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></td>';
	html += '    <td class="right"><input class="form-control" type="text" name="po_gallery_photo_album_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
	html += '    <td class="left"><button type="button" onclick="$(\'#module-row' + module_row + '\').remove();" class="btn btn-danger"><i class="fa fa-minus-circle"></i> <?php echo $button_remove; ?></button></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#module tfoot').before(html);
	
	module_row++;
}
//--></script>
<?php echo $footer; ?>