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
            <div class="row">
                <div class="container">
                    <h1 class="panel-title pull-left"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
                    <div class="pull-right">
                        <button type="submit" form="form-category" class="btn btn-primary" onclick="$('#form').submit();">
                            <i class="fa fa-check"></i> <?php echo $button_save; ?>
                        </button>
                        <button  class="btn btn-danger " onclick="location = '<?php echo $cancel; ?>';">
                            <i class="fa fa-times"></i> <?php echo $button_cancel; ?> 
                        </button>
                    </div>
                </div>
            </div>
        </div>
    <div class="panel-body">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <ul class="nav nav-tabs">
            <?php $module_row = 1; ?>
            <?php foreach ($modules as $module) { ?>
            <li class="<?php if($module_row == 1): ?>active<?php endif; ?>">
                <a href="#tab-module-<?php echo $module_row; ?>"   data-toggle="tab"><?php echo $tab_slider . ' ' . $module_row; ?>
                <i class="fa fa-times" onclick="$('.tab-content > div').removeClass('active');$(this).parent().parent().parent().children().removeClass('active'); $(this).parent().parent().next().addClass('active');$(this).parent().parent().remove();$('#tab-module-<?php print $module_row; ?>').next().addClass('active');$('#tab-module-<?php print $module_row; ?>').remove(); "></i> 
                </a>
            </li>
            <?php $module_row++; ?>
            <?php } ?>
            <button id="module-add" type="button" onclick="addModule();" class="btn btn-primary"><i class="fa fa-plus-circle"></i><?php echo $button_add_slider; ?></button>
        </ul>
        <div class="tab-content">
        <?php $module_row = 1; ?>
        <?php foreach ($modules as $module) { ?>
        <div id="tab-module-<?php echo $module_row; ?>" class="tab-pane <?php if($module_row == 1): ?> active<?php endif; ?> " >
          <table class="table table-striped table-bordered table-hover">
            <tr>
              <td colspan="2"><h3><?php echo $entry_slider_settings; ?></h3></td>
            </tr>
            <tr>
              <td><?php echo $entry_status; ?></td>
              <td><select class="form-control" name="flexslider_module[<?php echo $module_row; ?>][status]">
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
              <td><?php echo $entry_banner; ?></td>
              <td><select class="form-control" name="flexslider_module[<?php echo $module_row; ?>][banner_id]">
                  <?php foreach ($banners as $banner) { ?>
                  <?php if ($banner['banner_id'] == $module['banner_id']) { ?>
                  <option value="<?php echo $banner['banner_id']; ?>" selected="selected"><?php echo $banner['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $banner['banner_id']; ?>"><?php echo $banner['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_dimension; ?> <span class="required">*</span></td>
              <td><input type="text" class="form-control" name="flexslider_module[<?php echo $module_row; ?>][width]" value="<?php echo $module['width']; ?>" size="3" />
                <input type="text" class="form-control" name="flexslider_module[<?php echo $module_row; ?>][height]" value="<?php echo $module['height']; ?>" size="3"/>
                <?php if (isset($error_dimension[$module_row])) { ?>
                <span class="error"><?php echo $error_dimension[$module_row]; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_layout; ?></td>
              <td><select class="form-control" name="flexslider_module[<?php echo $module_row; ?>][layout_id]">
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
              <td><select class="form-control" name="flexslider_module[<?php echo $module_row; ?>][position]">
                  <?php if ($module['position'] == 'mainmenu') { ?>
                  <option value="mainmenu" selected="selected">Mainmenu</option>
                  <?php } else { ?>
                  <option value="mainmenu">Mainmenu</option>
                  <?php } ?>
                  <?php if ($module['position'] == 'slideshow') { ?>
                  <option value="slideshow" selected="selected">Slideshow</option>
                  <?php } else { ?>
                  <option value="slideshow">Slideshow</option>
                  <?php } ?>
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
                  <?php if ($module['position'] == 'footer') { ?>
                  <option value="footer" selected="selected">Footer</option>
                  <?php } else { ?>
                  <option value="footer">Footer</option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_sort_order; ?></td>
              <td><input type="text" class="form-control" name="flexslider_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
            </tr>
            <tr>
              <td colspan="2"><h3><?php echo $entry_slider_effects; ?></h3></td>
            </tr>
            <tr>
              <td><?php echo $entry_slideshow; ?></td>
              <td><select class="form-control" name="flexslider_module[<?php echo $module_row; ?>][slideshow]">
                  <?php if ($module['slideshow'] == 'true') { ?>
                  <option value="true" selected="selected"><?php echo $text_enabled; ?></option>
                  <?php } else { ?>
                  <option value="true"><?php echo $text_enabled; ?></option>
                  <?php } ?>
                  <?php if ($module['slideshow'] == 'false') { ?>
                  <option value="false" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="false"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_animation; ?></td>
              <td><select class="form-control" name="flexslider_module[<?php echo $module_row; ?>][animation]">
                  <?php if ($module['animation'] == 'fade') { ?>
                  <option value="fade" selected="selected">Fade</option>
                  <?php } else { ?>
                  <option value="fade">Fade</option>
                  <?php } ?>
                  <?php if ($module['animation'] == 'slide') { ?>
                  <option value="slide" selected="selected">Slide</option>
                  <?php } else { ?>
                  <option value="slide">Slide</option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_speed; ?></td>
              <td><input type="text" class="form-control" name="flexslider_module[<?php echo $module_row; ?>][speed]" value="<?php echo $module['speed']; ?>" size="3"/>
                <input type="text" class="form-control" name="flexslider_module[<?php echo $module_row; ?>][duration]" value="<?php echo $module['duration']; ?>" size="3"/></td>
            </tr>
            <tr>
              <td><?php echo $entry_direction; ?></td>
              <td><select class="form-control" name="flexslider_module[<?php echo $module_row; ?>][direction]">
                  <?php if ($module['direction'] == 'horizontal') { ?>
                  <option value="horizontal" selected="selected"><?php echo $text_horizontal; ?></option>
                  <?php } else { ?>
                  <option value="horizontal"><?php echo $text_horizontal; ?></option>
                  <?php } ?>
                  <?php if ($module['direction'] == 'vertical') { ?>
                  <option value="vertical" selected="selected"><?php echo $text_vertical; ?></option>
                  <?php } else { ?>
                  <option value="vertical"><?php echo $text_vertical; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_pause; ?></td>
              <td><select class="form-control" name="flexslider_module[<?php echo $module_row; ?>][pause]">
                  <?php if ($module['pause'] == 'true') { ?>
                  <option value="true" selected="selected"><?php echo $text_enabled; ?></option>
                  <?php } else { ?>
                  <option value="true"><?php echo $text_enabled; ?></option>
                  <?php } ?>
                  <?php if ($module['pause'] == 'false') { ?>
                  <option value="false" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="false"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td colspan="2"><h3><?php echo $entry_slider_navigation; ?></h3></td>
            </tr>
            <tr>
              <td><?php echo $entry_direction_nav; ?></td>
              <td><select class="form-control" name="flexslider_module[<?php echo $module_row; ?>][direction_nav]">
                  <?php if ($module['direction_nav'] == 'true') { ?>
                  <option value="true" selected="selected"><?php echo $text_enabled; ?></option>
                  <?php } else { ?>
                  <option value="true"><?php echo $text_enabled; ?></option>
                  <?php } ?>
                  <?php if ($module['direction_nav'] == 'false') { ?>
                  <option value="false" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="false"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_control_nav; ?></td>
              <td><select class="form-control" name="flexslider_module[<?php echo $module_row; ?>][control_nav]">
                  <?php if ($module['control_nav'] == 'true') { ?>
                  <option value="true" selected="selected"><?php echo $text_enabled; ?></option>
                  <?php } else { ?>
                  <option value="true"><?php echo $text_enabled; ?></option>
                  <?php } ?>
                  <?php if ($module['control_nav'] == 'false') { ?>
                  <option value="false" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="false"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_touch; ?></td>
              <td><select class="form-control" name="flexslider_module[<?php echo $module_row; ?>][touch]">
                  <?php if ($module['touch'] == 'true') { ?>
                  <option value="true" selected="selected"><?php echo $text_enabled; ?></option>
                  <?php } else { ?>
                  <option value="true"><?php echo $text_enabled; ?></option>
                  <?php } ?>
                  <?php if ($module['touch'] == 'false') { ?>
                  <option value="false" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="false"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_mousewheel; ?></td>
              <td><select class="form-control" name="flexslider_module[<?php echo $module_row; ?>][mousewheel]">
                  <?php if ($module['mousewheel'] == 'true') { ?>
                  <option value="true" selected="selected"><?php echo $text_enabled; ?></option>
                  <?php } else { ?>
                  <option value="true"><?php echo $text_enabled; ?></option>
                  <?php } ?>
                  <?php if ($module['mousewheel'] == 'false') { ?>
                  <option value="false" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="false"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td colspan="2"><h3><?php echo $entry_slider_thumbnails; ?></h3></td>
            </tr>
            <tr>
              <td><?php echo $entry_thumbnails; ?></td>
              <td><select class="form-control" name="flexslider_module[<?php echo $module_row; ?>][thumbnails]">
                  <?php if ($module['thumbnails']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_item_width; ?></td>
              <td><input type="text" class="form-control" name="flexslider_module[<?php echo $module_row; ?>][item_width]" value="<?php echo $module['item_width']; ?>" size="3"/></td>
            </tr>
            <tr>
              <td><?php echo $entry_max_items; ?></td>
              <td><input type="text" class="form-control" name="flexslider_module[<?php echo $module_row; ?>][max_items]" value="<?php echo $module['max_items']; ?>" size="3"/></td>
            </tr>
            <tr>
              <td><?php echo $entry_min_items; ?></td>
              <td><input type="text" class="form-control" name="flexslider_module[<?php echo $module_row; ?>][min_items]" value="<?php echo $module['min_items']; ?>" size="3"/></td>
            </tr>
            <tr>
              <td colspan="2"><h3><?php echo $entry_slider_caption; ?></h3></td>
            </tr>
            <tr>
              <td><?php echo $entry_caption; ?></td>
              <td><select class="form-control" name="flexslider_module[<?php echo $module_row; ?>][caption]">
                  <?php if ($module['caption']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_caption_position; ?></td>
              <td><select class="form-control" name="flexslider_module[<?php echo $module_row; ?>][caption_position]">
                  <?php if ($module['caption_position'] == 'caption-left') { ?>
                  <option value="caption-left" selected="selected"><?php echo $text_left; ?></option>
                  <?php } else { ?>
                  <option value="caption-left"><?php echo $text_left; ?></option>
                  <?php } ?>
                  <?php if ($module['caption_position'] == 'caption-right') { ?>
                  <option value="caption-right" selected="selected"><?php echo $text_right; ?></option>
                  <?php } else { ?>
                  <option value="caption-right"><?php echo $text_right; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_caption_button; ?></td>
              <td><select class="form-control" name="flexslider_module[<?php echo $module_row; ?>][caption_button]">
                  <?php if ($module['caption_button']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_button_text; ?></td>
              <td><?php foreach ($languages as $language) { ?>
                <input type="text" class="form-control" name="flexslider_module[<?php echo $module_row; ?>][caption_button_text][<?php echo $language['language_id']; ?>]" value="<?php echo isset($module['caption_button_text'][$language['language_id']]) ? $module['caption_button_text'][$language['language_id']] : ''; ?>" size="15"/>
                <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></br>
                <?php } ?></td>
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

<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {
  html  = '<div id="tab-module-' + module_row + '" class="tab-pane active">';
  html += '  <table class="table table-striped table-bordered table-hover">';
  html += '    <tr>';
  html += '      <td colspan="2"><h3><?php echo $entry_slider_settings; ?></h3></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_status; ?></td>';
  html += '      <td><select class="form-control" name="flexslider_module[' + module_row + '][status]">';
  html += '        <option value="1"><?php echo $text_enabled; ?></option>';
  html += '        <option value="0"><?php echo $text_disabled; ?></option>';
  html += '      </select></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_banner; ?></td>';
  html += '      <td><select class="form-control" name="flexslider_module[' + module_row + '][banner_id]">';
  <?php foreach ($banners as $banner) { ?>
  html += '        <option value="<?php echo $banner['banner_id']; ?>"><?php echo addslashes($banner['name']); ?></option>';
  <?php } ?>
  html += '      </select></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_dimension; ?> <span class="required">*</span></td>';
  html += '      <td><input type="text" class="form-control" name="flexslider_module[' + module_row + '][width]" value="980" size="3" /> <input type="text" class="form-control" name="flexslider_module[' + module_row + '][height]" value="280" size="3" /></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_layout; ?></td>';
  html += '      <td><select class="form-control" name="flexslider_module[' + module_row + '][layout_id]">';
  <?php foreach ($layouts as $layout) { ?>
  html += '           <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
  <?php } ?>
  html += '      </select></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_position; ?></td>';
  html += '      <td><select class="form-control" name="flexslider_module[' + module_row + '][position]">';
  html += '        <option value="mainmenu">Mainmenu</option>';
  html += '        <option value="slideshow">Slideshow</option>';
  html += '        <option value="content_top"><?php echo $text_content_top; ?></option>';
  html += '        <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
  html += '        <option value="column_left"><?php echo $text_column_left; ?></option>';
  html += '        <option value="column_right"><?php echo $text_column_right; ?></option>';
  html += '        <option value="footer">Footer</option>';
  html += '      </select></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_sort_order; ?></td>';
  html += '      <td><input type="text" class="form-control" name="flexslider_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td colspan="2"><h3><?php echo $entry_slider_effects; ?></h3></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_slideshow; ?></td>';
  html += '      <td><select class="form-control" name="flexslider_module[' + module_row + '][slideshow]">';
  html += '        <option value="true"><?php echo $text_enabled; ?></option>';
  html += '        <option value="false"><?php echo $text_disabled; ?></option>';
  html += '      </select></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_animation; ?></td>';
  html += '      <td><select class="form-control" name="flexslider_module[' + module_row + '][animation]">';
  html += '        <option value="fade">Fade</option>';
  html += '        <option value="slide">Slide</option>';
  html += '      </select></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_speed; ?></td>';
  html += '      <td><input type="text" class="form-control" name="flexslider_module[' + module_row + '][speed]" value="5000" size="3" /> <input type="text" class="form-control" name="flexslider_module[' + module_row + '][duration]" value="600" size="3" /></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_direction; ?></td>';
  html += '      <td><select class="form-control" name="flexslider_module[' + module_row + '][direction]">';
  html += '        <option value="horizontal"><?php echo $text_horizontal; ?></option>';
  html += '        <option value="vertical"><?php echo $text_vertical; ?></option>';
  html += '      </select></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_pause; ?></td>';
  html += '      <td><select class="form-control" name="flexslider_module[' + module_row + '][pause]">';
  html += '        <option value="true"><?php echo $text_enabled; ?></option>';
  html += '        <option value="false"><?php echo $text_disabled; ?></option>';
  html += '      </select></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td colspan="2"><h3><?php echo $entry_slider_navigation; ?></h3></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_direction_nav; ?></td>';
  html += '      <td><select class="form-control" name="flexslider_module[' + module_row + '][direction_nav]">';
  html += '        <option value="true"><?php echo $text_enabled; ?></option>';
  html += '        <option value="false"><?php echo $text_disabled; ?></option>';
  html += '      </select></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_control_nav; ?></td>';
  html += '      <td><select class="form-control" name="flexslider_module[' + module_row + '][control_nav]">';
  html += '        <option value="true"><?php echo $text_enabled; ?></option>';
  html += '        <option value="false"><?php echo $text_disabled; ?></option>';
  html += '      </select></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_touch; ?></td>';
  html += '      <td><select class="form-control" name="flexslider_module[' + module_row + '][touch]">';
  html += '        <option value="true"><?php echo $text_enabled; ?></option>';
  html += '        <option value="false"><?php echo $text_disabled; ?></option>';
  html += '      </select></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_mousewheel; ?></td>';
  html += '      <td><select class="form-control" name="flexslider_module[' + module_row + '][mousewheel]">';
  html += '        <option value="true"><?php echo $text_enabled; ?></option>';
  html += '        <option value="false"><?php echo $text_disabled; ?></option>';
  html += '      </select></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td colspan="2"><h3><?php echo $entry_slider_thumbnails; ?></h3></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_thumbnails; ?></td>';
  html += '      <td><select class="form-control" name="flexslider_module[' + module_row + '][thumbnails]">';
  html += '        <option value="0"><?php echo $text_disabled; ?></option>';
  html += '        <option value="1"><?php echo $text_enabled; ?></option>';
  html += '      </select></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_item_width; ?></td>';
  html += '      <td><input type="text" class="form-control" name="flexslider_module[' + module_row + '][item_width]" value="200" size="3" /></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_max_items; ?></td>';
  html += '      <td><input type="text" class="form-control" name="flexslider_module[' + module_row + '][max_items]" value="5" size="3" /></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_min_items; ?></td>';
  html += '      <td><input type="text" class="form-control" name="flexslider_module[' + module_row + '][min_items]" value="2" size="3" /></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td colspan="2"><h3><?php echo $entry_slider_caption; ?></h3></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_caption; ?></td>';
  html += '      <td><select class="form-control" name="flexslider_module[' + module_row + '][caption]">';
  html += '        <option value="1"><?php echo $text_enabled; ?></option>';
  html += '        <option value="0"><?php echo $text_disabled; ?></option>';
  html += '      </select></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_caption_position; ?></td>';
  html += '      <td><select class="form-control" name="flexslider_module[' + module_row + '][caption_position]">';
  html += '        <option value="caption-left"><?php echo $text_left; ?></option>';
  html += '        <option value="caption-right"><?php echo $text_right; ?></option>';
  html += '      </select></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_caption_button; ?></td>';
  html += '      <td><select class="form-control" name="flexslider_module[' + module_row + '][caption_button]">';
  html += '        <option value="1"><?php echo $text_enabled; ?></option>';
  html += '        <option value="0"><?php echo $text_disabled; ?></option>';
  html += '      </select></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_button_text; ?></td>';
  html += '      <td>';
  <?php foreach ($languages as $language) { ?>
  html += '        <input type="text" class="form-control" name="flexslider_module[' + module_row + '][caption_button_text][<?php echo $language['language_id']; ?>]" value="Read More" size="15" /> <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></br>';
  <?php } ?>
  html += '      </td>';
  html += '    </tr>';
  html += '  </table>';
  html += '</div>';
  $('.nav-tabs > li').removeClass('active');
  $('.tab-pane').removeClass('active');
  $('#form > .tab-content').append(html);

  $('#module-add').before('<li class="active"><a href="#tab-module-' + module_row + '" id="module-' + module_row + '"  data-toggle="tab" "><?php echo $tab_slider; ?> ' + module_row + '                <i class="fa fa-times" onclick="$(this).parent().parent().next().addClass(\'active\');$(this).parent().parent().remove();$(\'#tab-module-' + module_row + '\').next().addClass(\'active\');$(\'#tab-module-' + module_row + '\').remove();"></i></a></li>');


  $('#module-' + module_row).trigger('click');

  module_row++;
  }
//--></script> 
<script type="text/javascript"><!--
$('.vtabs a').tabs();
//--></script>
<?php echo $footer; ?>