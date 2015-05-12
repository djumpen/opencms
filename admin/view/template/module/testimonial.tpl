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
        <button type="button" class="close" data-dismiss="alert">
            &times;
        </button> 
    </div>
    <?php } ?>
    <div class="panel panel-default">
        <div class="panel-heading">
            <div class="pull-right btn-group">
                <a href="<?php echo $edit_testimonials_path; ?>" class="btn btn-info"><?php echo $text_edit_testimonials; ?></a>
                <a onclick="$('#form').submit();" class="btn btn-success"><?php echo $button_save; ?></a>
                <a onclick="location = '<?php echo $cancel; ?>';" class="btn btn-danger"><?php echo $button_cancel; ?></a>
            </div>
            <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
        </div>
       <div class="panel-body">
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
                 <ul class="nav nav-tabs rootNav">
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
            <table id="module" class="table table-striped table-bordered table-hover">
                <tr>
                    <td width=10></td>
                    <td><?php echo $entry_admin_approved; ?></td>
                    <td> <?php if (isset($testimonial_admin_approved)) { ?>
                    <input type="checkbox" name="testimonial_admin_approved" value="0" checked="checked" />
                    <?php } else { ?>
                    <input type="checkbox" name="testimonial_admin_approved" value="0" />
                    <?php } ?> </td>
                </tr>
                <?php if (!isset($testimonial_default_rating)) $testimonial_default_rating = '3'; ?>
                <tr>
                    <td width=10></td>
                    <td><?php echo $entry_default_rating; ?></td>
                    <td><span><?php echo $entry_bad; ?></span>&nbsp;
                    <input type="radio" name="testimonial_default_rating" value="1" style="margin: 0;" <?php if ( $testimonial_default_rating == 1 ) echo 'checked="checked"';?> />
                    &nbsp;
                    <input type="radio" name="testimonial_default_rating" value="2" style="margin: 0;" <?php if ( $testimonial_default_rating == 2 ) echo 'checked="checked"';?> />
                    &nbsp;
                    <input type="radio" name="testimonial_default_rating" value="3" style="margin: 0;" <?php if ( $testimonial_default_rating == 3 ) echo 'checked="checked"';?> />
                    &nbsp;
                    <input type="radio" name="testimonial_default_rating" value="4" style="margin: 0;" <?php if ( $testimonial_default_rating == 4 ) echo 'checked="checked"';?> />
                    &nbsp;
                    <input type="radio" name="testimonial_default_rating" value="5" style="margin: 0;" <?php if ( $testimonial_default_rating == 5 ) echo 'checked="checked"';?> />
                    &nbsp; <span><?php echo $entry_good; ?></span></td>
                </tr>
                <tr>
                    <td width=10></td>
                    <td><?php echo $entry_send_to_admin; ?></td>
                    <td> <?php if (isset($testimonial_send_to_admin)) { ?>
                    <input type="checkbox" name="testimonial_send_to_admin" value="0" checked="checked" />
                    <?php } else { ?>
                    <input type="checkbox" name="testimonial_send_to_admin" value="0" />
                    <?php } ?> </td>
                </tr>
                <tr>
                    <td width=10></td>
                    <td><?php echo $entry_all_page_limit; ?></td>
                    <td>
                    <input class="form-control" type="text" name="testimonial_all_page_limit" value="<?php if (isset($testimonial_all_page_limit)) echo $testimonial_all_page_limit; else echo "20"; ?>" size="3" />
                    </td>
                </tr>
            </table>
            <br>
            <?php $module_row = 1; ?>
                <?php foreach ($modules as $module) { ?>
                 <div id="tab-module-<?php echo $module_row; ?>"  class="tab-pane <?php if ($module_row == 1): ?> active <?php endif; ?> rootTabs" >
                   <ul class="nav nav-tabs" id="language-<?php echo $module_row; ?>">
                        <?php $i=0; foreach ($languages as $language) { ?>
                        <li class="<?php if($i==0): ?> active <?php endif; ?>">
                            <a href="#tab-language-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                        </li>
                        <?php $i++; } ?>
                    </ul>
                    <div class="tab-content">
                    <?php $i=0; foreach ($languages as $language) { ?>
                    <div id="tab-language-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>" class="tab-pane <?php if ($i == 0): ?> active <?php endif; ?>" >
                       <table class="table table-striped table-bordered table-hover">
                            <tr>
                                <td><?php echo $entry_title; ?></td>
                                <td>
                                <input class="form-control" type="text" name="testimonial_module[<?php echo $module_row; ?>][testimonial_title][<?php echo $language['language_id']; ?>]" id="description-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>"  value="<?php echo isset($module['testimonial_title'][$language['language_id']]) ? $module['testimonial_title'][$language['language_id']] : ''; ?>" size="30" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <?php $i++;} ?>
                    </div>
                   <table class="table table-striped table-bordered table-hover">
                        <tr>
                            <td><?php echo $entry_limit; ?></td>
                            <td>
                            <input class="form-control" type="text" name="testimonial_module[<?php echo $module_row; ?>][testimonial_limit]" value="<?php echo $module['testimonial_limit']; ?>" size="2" />
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_random; ?></td>
                            <?php if (isset($module['testimonial_random'])) { ?>
                            <td>
                            <input type="checkbox" name="testimonial_module[<?php echo $module_row; ?>][testimonial_random]" value="0" checked="checked"  />
                            </td>
                            <?php } else { ?>
                            <td>
                            <input type="checkbox" name="testimonial_module[<?php echo $module_row; ?>][testimonial_random]" value="0"   />
                            </td>
                            <?php } ?>
                        </tr>
                        <tr>
                            <td><?php echo $entry_character_limit; ?></td>
                            <td>
                            <input class="form-control" type="text" name="testimonial_module[<?php echo $module_row; ?>][testimonial_character_limit]" value="<?php if (isset($module['testimonial_character_limit'])) echo $module['testimonial_character_limit']; else echo ""; ?>" size="2" />
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_layout; ?></td>
                            <td>
                            <select class="form-control" name="testimonial_module[<?php echo $module_row; ?>][layout_id]">
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
                            <td>
                            <select class="form-control" name="testimonial_module[<?php echo $module_row; ?>][position]">
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
                        </tr>
                        <tr>
                            <td><?php echo $entry_status; ?></td>
                            <td>
                            <select class="form-control" name="testimonial_module[<?php echo $module_row; ?>][status]">
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
                            <td>
                            <input class="form-control" type="text" name="testimonial_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" />
                            </td>
                        </tr>
                    </table>
                
                <?php $module_row++; ?>
                <?php } ?>
                </div>
            </form>

        </div>
    </div>
</div>

<script type="text/javascript">
	<!--
var module_row = <?php echo $module_row; ?>;

function addModule() {
html  = '<div id="tab-module-' + module_row + '" class="tab-pane active rootTabs">';
html += '  <div id="language-' + module_row + '" class="htabs">';
    html += '  <ul class="nav nav-tabs">';
                       <?php $i= 0; foreach ($languages as $language) { ?>
    html += '    <li class="<?php if($i==0) :?> active <?php endif; ?>"><a href="#tab-language-'+ module_row + '-<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>';
                        <?php $i++;} ?>
    html += '  </ul>';
html += '  </div>';

<?php $l = 0; foreach ($languages as $language) { ?>
html += '    <div id="tab-language-'+ module_row + '-<?php echo $language['language_id']; ?>" class="<?php if(!$l) {?> active <?php } ?>">';
html += '     <table class="table table-striped table-bordered table-hover">';
html += '       <tr>';
html += '          <td><?php echo $entry_title; ?></td>';
html += '          <td><input class="form-control" type="text" name="testimonial_module[' + module_row + '][testimonial_title][<?php echo $language['language_id']; ?>]" value="" size="30" id="description-' + module_row + '-<?php echo $language['language_id']; ?>"/></td>';
html += '       </tr>';
html += '      </table>';
html += '    </div>';
<?php $l++; } ?>

html += ' <table class="table table-striped table-bordered table-hover">';

html += '  <tr>';
html += '      <td><?php echo $entry_limit; ?></td>';
html += '      <td><input class="form-control" type="text" name="testimonial_module[' + module_row + '][testimonial_limit]" value="10" size="2" /></td>';
html += '  </tr>';

html += '  <tr>';
html += '            <td><?php echo $entry_random; ?></td>';
html += '            <td><input type="checkbox" name="testimonial_module[' + module_row + '][testimonial_random]" value="0"  /></td>';
html += '  </tr>';

html += '  <tr>';
html += '      <td><?php echo $entry_character_limit; ?></td>';
html += '      <td><input class="form-control" type="text" name="testimonial_module[' + module_row + '][testimonial_character_limit]" value="100" size="2" /></td>';
html += '  </tr>';

html += '    <tr>';
html += '      <td><?php echo $entry_layout; ?></td>';
html += '      <td><select class="form-control" name="testimonial_module[' + module_row + '][layout_id]">';
<?php foreach ($layouts as $layout) { ?>
html += '           <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
<?php } ?>
html += '      </select></td>';
html += '    </tr>';

html += '    <tr>';
html += '      <td><?php echo $entry_position; ?></td>';
html += '      <td><select class="form-control" name="testimonial_module[' + module_row + '][position]">';
html += '        <option value="content_top"><?php echo $text_content_top; ?></option>';
html += '        <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
html += '        <option value="column_left"><?php echo $text_column_left; ?></option>';
html += '        <option value="column_right"><?php echo $text_column_right; ?></option>';
html += '      </select></td>';
html += '    </tr>';

html += '    <tr>';
html += '      <td><?php echo $entry_status; ?></td>';
html += '      <td><select class="form-control" name="testimonial_module[' + module_row + '][status]">';
html += '        <option value="1"><?php echo $text_enabled; ?></option>';
html += '        <option value="0"><?php echo $text_disabled; ?></option>';
html += '      </select></td>';
html += '    </tr>';

html += '    <tr>';
html += '      <td><?php echo $entry_sort_order; ?></td>';
html += '      <td><input class="form-control" type="text" name="testimonial_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
html += '    </tr>';
html += '  </table>';
html += '</div>';

    $('.rootNav > li').removeClass('active');
    $('.rootTabs').removeClass('active');
    $('#form > .tab-content').append(html); 

$('#module-add').before('<li class="active"><a href="#tab-module-' + module_row + '" modid ="' + module_row + '" id="module-' + module_row + '"  data-toggle="tab"><?php echo $tab_module; ?> ' + module_row + '<i class="fa fa-times" onclick="$(this).parent().parent().next().addClass(\'active\');$(this).parent().parent().remove();$(\'#tab-module-' + module_row + '\').next().addClass(\'active\');$(\'#tab-module-' + module_row + '\').remove();"></i></a></li>');
    

module_row++;
}
//-->
</script>
<?php echo $footer; ?>