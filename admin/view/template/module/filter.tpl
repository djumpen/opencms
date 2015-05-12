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
  <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $success; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
    <div class="panel panel-default">
     <div class="panel-heading">
         <div class="row">
             <div class="container">
      <h1 class="panel-title pull-left"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
      <div class="button-group pull-right">
        <?php if ($installed) { ?>
        <button onclick="$('#form').submit();" class="btn btn-info"><?php echo $button_save; ?></button>
        <button onclick="$('#form').attr('action','<?php echo $action; ?>&return=1').submit();" class="btn btn-success"><?php echo $button_apply; ?></button>
        <?php } ?>
        <button onclick="location = '<?php echo $cancel; ?>';" class="btn btn-danger"><?php echo $button_cancel; ?></button>
      </div>
     </div>
     </div>
     </div>
    <div class="panel-body">
      <?php if (!$installed) { ?>
      <div id="install"><p><?php echo $text_create; ?><br /><a onclick="location = '<?php echo $create; ?>';" class="button"><?php echo $button_create; ?></a></div>
      <?php } ?>
      <div id="tabs" class="tab-pane active">
          <ul class="nav nav-tabs">
            <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
            <li><a href="#tab-option" data-toggle="tab"><?php echo $tab_option; ?></a></li>
            <li><a href="#tab-price-filtering" data-toggle="tab"><?php echo $tab_price_filtering; ?></a></li>
            <li><a href="#tab-other" data-toggle="tab"><?php echo $tab_other; ?></a></li>
            <li><a href="#tab-copy" data-toggle="tab">Связи</a></li>
        </ul>
      </div>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div class="tab-content">
        <input type="hidden" name="filter_module[0][position]" value="<?php echo $position; ?>" />
        <div  class="tab-pane active" id="tab-general">
          <table id="settings" class="table table-striped table-bordered table-hover">
            <tr><td><?php echo $entry_status; ?></td><td><label<?php echo ($status ? ' class="checked"' : ''); ?>><input type="checkbox" name="filter_module[0][status]" value="1" <?php echo ($status ? 'checked="checked" ' : ''); ?>/></td><td><div class="notice"><?php echo $notice_status; ?></div></td></tr>
            <tr>
              <td><?php echo $entry_position; ?></td>
              <td>
                <div id="position">
                  <?php foreach ($positions as $item) { ?>
                  <a class="<?php echo $item . ($position == $item ? ' selected' : ''); ?>" rel="<?php echo $item; ?>" title="<?php echo ${'text_' . $item}; ?>"><?php echo ${'text_' . $item}; ?></a>
                  <?php } ?>
                </div>
              </td>
              <td><div class="notice"><?php echo $notice_position; ?></div></td>
            </tr>
            <tr><td><?php echo $entry_sort_order; ?></td><td><input type="text"  class="form-control"  name="filter_module[0][sort_order]" value="<?php echo $sort_order; ?>" size="2" /></td><td><div class="notice"><?php echo $notice_sort_order; ?></div></td></tr>
          </table>
        </div>
        <div  class="tab-pane" id="tab-option">
          <table id="settings" class="table table-striped table-bordered table-hover">
            <tr><td><?php echo $entry_show_selected; ?></td><td><label<?php echo ($show_selected ? ' class="checked"' : ''); ?>><input type="checkbox" name="filter_module[0][show_selected]" value="1" <?php echo ($show_selected ? 'checked="checked" ' : ''); ?>/></label></td><td><div class="notice"><?php echo $notice_show_selected; ?></div></td></tr>
            <tr><td><?php echo $entry_show_button; ?></td><td><label<?php echo ($show_button ? ' class="checked"' : ''); ?>><input type="checkbox" name="filter_module[0][show_button]" value="1" <?php echo ($show_button ? 'checked="checked" ' : ''); ?>/></label></td><td><div class="notice"><?php echo $notice_show_button; ?></div></td></tr>
            <tr><td><?php echo $entry_show_price; ?></td><td><label<?php echo ($show_price ? ' class="checked"' : ''); ?>><input type="checkbox" name="filter_module[0][show_price]" value="1" <?php echo ($show_price ? 'checked="checked" ' : ''); ?>/></label></td><td><div class="notice"><?php echo $notice_show_price; ?></div></td></tr>
            <tr><td><?php echo $entry_show_counter; ?></td><td><label<?php echo ($show_counter ? ' class="checked"' : ''); ?>><input type="checkbox" name="filter_module[0][show_counter]" value="1" <?php echo ($show_counter ? 'checked="checked" ' : ''); ?>/></label></td><td><div class="notice"><?php echo $notice_show_counter; ?></div></td></tr>
            <tr>
              <td><?php echo $entry_manufacturer; ?></td>
              <td>
                <label<?php echo ($manufacturer ? ' class="checked"' : ''); ?>><input type="checkbox" name="filter_module[0][manufacturer]" value="1" <?php echo ($manufacturer ? 'checked="checked" ' : ''); ?>/></label>
                <div style="<?php echo ($manufacturer ? 'display:block;' : 'display:none;'); ?>">
                  <?php echo $entry_manufacturer_type; ?>
                  <select class="form-control" name="filter_module[0][manufacturer_type]">
                    <?php foreach ($types as $item) { ?>
                    <option value="<?php echo $item; ?>" <?php echo ($manufacturer_type == $item ? 'selected="selected" ' : ''); ?>><?php echo ucfirst($item); ?></option>
                    <?php } ?>
                  </select>
                </div>
              </td>
              <td><div class="notice"><?php echo $notice_manufacturer; ?></div></td>
            </tr>
            <tr>
              <td><?php echo $entry_stock_status; ?></td>
              <td>
                <label<?php echo ($stock_status ? ' class="checked"' : ''); ?>><input type="checkbox" name="filter_module[0][stock_status]" value="1" <?php echo ($stock_status ? 'checked="checked" ' : ''); ?>/></label>
                <div style="<?php echo ($stock_status ? 'display:block;' : 'display:none;'); ?>">
                  <?php echo $entry_stock_status_type; ?>
                  <select class="form-control" name="filter_module[0][stock_status_type]">
                    <?php foreach ($types as $item) { ?>
                    <option value="<?php echo $item; ?>" <?php echo ($stock_status_type == $item ? 'selected="selected" ' : ''); ?>><?php echo ucfirst($item); ?></option>
                    <?php } ?>
                  </select>
                </div>
              </td>
              <td><div class="notice"><?php echo $notice_stock_status; ?></div></td>
            </tr>
          </table>
        </div>
        <div  class="tab-pane" id="tab-price-filtering">
          <table id="settings" class="table table-striped table-bordered table-hover">
            <tr><td><?php echo $entry_show_diagram; ?></td><td><label<?php echo ($show_diagram ? ' class="checked"' : ''); ?>><input type="checkbox" name="filter_module[0][show_diagram]" value="1" <?php echo ($show_diagram ? 'checked="checked" ' : ''); ?>/></label></td><td><div class="notice"><?php echo $notice_show_diagram; ?></div></td></tr>
            <tr><td><?php echo $entry_consider_discount; ?></td><td><label<?php echo ($consider_discount ? ' class="checked"' : ''); ?>><input type="checkbox" name="filter_module[0][consider_discount]" value="1" <?php echo ($consider_discount ? 'checked="checked" ' : ''); ?>/></label></td><td><div class="notice"><?php echo $notice_consider_discount; ?></div></td></tr>
            <tr><td><?php echo $entry_consider_special; ?></td><td><label<?php echo ($consider_special ? ' class="checked"' : ''); ?>><input type="checkbox" name="filter_module[0][consider_special]" value="1" <?php echo ($consider_special ? 'checked="checked" ' : ''); ?>/></label></td><td><div class="notice"><?php echo $notice_consider_special; ?></div></td></tr>
          </table>
        </div>
        <div class="tab-pane"  id="tab-other">
          <table id="settings" class="table table-striped table-bordered table-hover">
            <tr>
              <td><?php echo $entry_pco_show_type; ?></td>
              <td>
                <select class="form-control" name="filter_module[0][pco_show_type]">
                  <?php if ($pco_show_type == 'inline') { ?>
                  <option value="inline" selected="selected"><?php echo $text_inline; ?></option>
                  <option value="list"><?php echo $text_list; ?></option>
                  <?php } else { ?>
                  <option value="inline"><?php echo $text_inline; ?></option>
                  <option value="list" selected="selected"><?php echo $text_list; ?></option>
                  <?php } ?>
                </select>
              </td>
              <td><div class="notice"><?php echo $notice_pco_show_type; ?></div></td>
            </tr>
            <tr><td><?php echo $entry_pco_show_limit; ?></td><td><input type="text"  class="form-control"  name="filter_module[0][pco_show_limit]" value="<?php echo $pco_show_limit; ?>" size="4" /></td><td><div class="notice"><?php echo $notice_pco_show_limit; ?></div></td></tr>
            <tr>
              <td><?php echo $entry_hide_options; ?></td>
              <td>
                <label<?php echo ($hide_options ? ' class="checked"' : ''); ?>><input type="checkbox" name="filter_module[0][hide_options]" value="1" <?php echo ($hide_options ? 'checked="checked" ' : ''); ?>/></label>
                <div style="<?php echo ($hide_options ? 'display:block;' : 'display:none;'); ?>">
                  <?php echo $entry_hide_options_limit; ?>
                  <input type="text"  class="form-control"  name="filter_module[0][hide_options_limit]" value="<?php echo $hide_options_limit; ?>" size="4" />
                </div>
              </td>
              <td><div class="notice"><?php echo $notice_hide_options; ?></div></td>
            </tr>
          </table>
        </div>
        <div  class="tab-pane" id="tab-copy">
          <?php if(isset($global_categories) && !empty($global_categories)) { ?>
          <table class="table table-striped table-bordered table-hover">
          <?php foreach ($global_categories as $g_category) { ?>
          <tr>
          <td><b><?php print $g_category['name']; ?>:</b></td>
          <td>
          <?php if(isset($global_options) && !empty($global_options)) { ?>
          <table class="table table-striped table-bordered table-hover">
          <?php foreach ($global_options as $global_option) { ?>
          <tr>
          <td>
          <label>
          <input 
          value="<?php print $global_option['option_id']; ?>" 
          type="checkbox" 
          name="filter_category_options[<?php print $g_category['category_id']; ?>][<?php print $global_option['option_id']; ?>]" 
          <?php if(
          isset($setted_options[$g_category['category_id']]) && 
          in_array($global_option['option_id'], $setted_options[$g_category['category_id']])
          ) { ?>
          checked="checked"
          <?php } ?>
          >
          <?php print $global_option['name'];?>
          </label>
          </td>
          </tr>
          <?php } ?>
          </table>
          <?php } ?>
          </td>
          </tr>
          <?php } ?>
          </table>
          <?php } ?>
          <button id="select_all_options" class="btn btn-info">Отметить все опции</button>
        </div>
        </div>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
  $('input[type=\'checkbox\']').change(function(){
    var label = $(this).parent('label');
    label.next('div').fadeToggle(250);
    label.toggleClass('checked');
  });

  $('input[name=\'filter_module[0][show_price]\']').change(function(){
    if (!$(this).prop('checked')) {
      $('a[href=\'#tab-price-filtering\']').addClass('disabled').animate({opacity: 0.3}, {duration: 300, queue: false});
      $('#tab-price-filtering input').prop('disabled', true);
    } else {
      $('#tabs .disabled').removeClass('disabled').animate({opacity: 1}, {duration: 300, queue: false});
      $('#tab-price-filtering input').prop('disabled', false);
    }
  });

  <?php if (!$installed) { ?>
  setTimeout(function(){ $('#install').animate({opacity: 1}, 2000); }, 1000);
  <?php } else { ?>
  $('#position a').click(function(){
    var el = $(this), position = el.attr('rel');
    $('input[name=\'filter_module[0][position]\']').val(position);
    $('#position a').removeClass('selected');
    el.addClass('selected');
  });
  <?php } ?>
//--></script>
<script>
$(document).on('click', '#select_all_options', function(event){
    $('#tab-copy > table > tbody > tr > td > table > tbody > tr > td > label > input[type=checkbox]').each(function(){
        $(this).attr('checked', true);
        event.preventDefault();
    });
})
</script>
<?php echo $footer; ?>