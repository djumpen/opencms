<?php echo $header; ?>
<div id="content" class="container">
    <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
    </ul>
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger">
        <i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
        <div class="panel-heading">

            <div class="pull-right">
                <a onclick="$('#form').submit();" class="btn btn-primary "><i class="fa fa-check"></i><span><?php echo $button_save; ?></span></a>
                <a onclick="location = '<?php echo $cancel; ?>';" class="btn btn-danger "> <i class="fa fa-times"></i><span><?php echo $button_cancel; ?></span></a>
            </div>
            <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
        </div>
        <div class="panel-body">
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
               <table id="module" class="table table-striped table-bordered table-hover">
                    <thead>
                        <tr>
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
                            <td class="left">
                            <select  class="form-control"  name="categoryhome_module[<?php echo $module_row; ?>][layout_id]">
                                <?php foreach ($layouts as $layout) { ?>
                                <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                                <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                                <?php } else { ?>
                                <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                                <?php } ?>
                                <?php } ?>
                            </select></td>
                            <td class="left">
                            <select  class="form-control"  name="categoryhome_module[<?php echo $module_row; ?>][position]">
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

                            </select></td>
                            <td class="left">
                            <select  class="form-control"  name="categoryhome_module[<?php echo $module_row; ?>][status]">
                                <?php if ($module['status']) { ?>
                                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                <option value="0"><?php echo $text_disabled; ?></option>
                                <?php } else { ?>
                                <option value="1"><?php echo $text_enabled; ?></option>
                                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                <?php } ?>
                            </select></td>
                            <td class="right">
                            <input type="text"  class="form-control"  name="categoryhome_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" />
                            </td>
                            <td class="left"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="btn btn-danger"><span><?php echo $button_remove; ?></span></a></td>
                        </tr>
                    </tbody>
                    <?php $module_row++; ?>
                    <?php } ?>
                    <tfoot>
                        <tr>
                            <td colspan="4"></td>
                            <td class="left"><a onclick="addModule();" class="btn btn-success"><span><?php echo $button_add_module; ?></span></a></td>
                        </tr>
                    </tfoot>
                </table>
                <table class="form">
                    <tr>
                        <td><?php echo $entry_category; $a= $categoryhome_category; ?></td>
                        <td>
                        <p class="radio" ><input  name="categoryhome_category" type="radio" value="0" <?php if($categoryhome_category==0 || $categoryhome_category='' ){?>checked<?php } ?> />
                        Root Category</p>
                        <br/>
                        <?php foreach ($categories as $category ){ ?>
                             <p class="radio" ><input   name="categoryhome_category" type="radio" value="<?php echo $category['category_id']; ?>" <?php if(strval($a)==strval($category['category_id'])){?>checked<?php } ?> />
                        <?php echo $category['name'] ?>
                      </p>
                        <?php } ?> </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
    <script type="text/javascript">
		<!--
var module_row = <?php echo $module_row; ?>;

function addModule() {
html  = '<tbody id="module-row' + module_row + '">';
html += '  <tr>';
html += '    <td class="left"><select  class="form-control"  name="categoryhome_module[' + module_row + '][layout_id]">';
<?php foreach ($layouts as $layout) { ?>
html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
<?php } ?>
html += '    </select></td>';
html += '    <td class="left"><select  class="form-control"  name="categoryhome_module[' + module_row + '][position]">';
html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
html += '    </select></td>';
html += '    <td class="left"><select  class="form-control"  name="categoryhome_module[' + module_row + '][status]">';
html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
html += '      <option value="0"><?php echo $text_disabled; ?></option>';
html += '    </select></td>';
html += '    <td class="right"><input type="text"  class="form-control"  name="categoryhome_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
html += '    <td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="button"><span><?php echo $button_remove; ?></span></a></td>';
html += '  </tr>';
html += '</tbody>';

$('#module tfoot').before(html);

module_row++;
}
//-->
    </script>
    <?php echo $footer; ?>
