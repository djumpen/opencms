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
                        <button onclick="location = '<?php echo $insert; ?>'" class="btn btn-success">
                            <?php echo $button_insert; ?>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    <div class="panel-body">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
       <table class="table table-striped table-bordered table-hover">
          <thead>
            <tr>
              <td width="1" align="center"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
              <td class="left" width="20%"><a href="<?php echo $sort_name; ?>" <?php echo ($sort == 'cod.name' ? 'class="' . strtolower($order) . '"' : ''); ?>><?php echo $column_name; ?></a></td>
              <td class="left" width="20%"><?php echo $column_values; ?></td>
              <td class="left"><?php echo $column_categories; ?></td>
              <td class="left" style="width: 145px;"><?php echo $column_type; ?></td>
              <td class="right"><a href="<?php echo $sort_order; ?>" <?php echo ($sort == 'co.sort_order' ? 'class="' . strtolower($order) . '"' : ''); ?>><?php echo $column_sort_order; ?></a></td>
              <td class="right"><?php echo $column_status; ?></td>
              <td class="right" width="100"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <tr class="filter">
              <td></td>
              <td><input type="text" class="form-control" name="filter_name" value="<?php echo $filter_name; ?>" /></td>
              <td></td>
              <td>
                <select  class="form-control"name="filter_category_id" style="width:190px;">
                  <option value=""><?php echo $text_none; ?></option>
                  <?php foreach ($categories as $category) { ?>
                  <?php if ($category['category_id'] == $filter_category_id) { ?>
                  <option value="<?php echo $category['category_id']; ?>" selected="selected" class="level-<?php echo $category['level']; ?>"><?php echo $category['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $category['category_id']; ?>" class="level-<?php echo $category['level']; ?>"><?php echo $category['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
              </td>
              <td>
                <select  class="form-control"name="filter_type">
                  <option value=""><?php echo $text_none; ?></option>
                  <?php foreach ($types as $key => $type) { ?>
                  <?php if ($key == $filter_type) { ?>
                  <option value="<?php echo $key; ?>" selected="selected"><?php echo $type; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $key; ?>"><?php echo $type; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
              </td>
              <td></td>
              <td>
                <select  class="form-control"name="filter_status">
                  <option value=""></option>
                  <?php if ($filter_status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <?php } ?>
                  <?php if (!is_null($filter_status) && !$filter_status) { ?>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </td>
              <td align="right"><button onclick="filter();" class="btn btn-default"><?php echo $button_filter; ?></button></td>
            </tr>
            <?php if ($options) { ?>
            <?php foreach ($options as $option) { ?>
            <tr>
              <td align="center"><input type="checkbox" name="selected[]" value="<?php echo $option['option_id']; ?>" /></td>
              <td class="left"><input type="text" class="form-control" name="name" value="<?php echo $option['name']; ?>" size="40" class="edit" style="float: left; width: 145px;"/>&nbsp;<button class="save btn btn-success" rel="<?php echo $option['option_id']; ?>">Save</button></td>
              <td class="left"><?php echo $option['values']; ?></td>
              <td class="left"><?php echo $option['categories']; ?></td>
              <td class="right">
                <select  class="form-control"name="type" onchange="edit.select($(this), <?php echo $option['option_id']; ?>);">
                  <option value="">-- select --</option>
                  <?php foreach ($types as $key => $type) { ?>
                  <option value="<?php echo $key; ?>"<?php echo ($key == $option['type'] ? ' selected="selected"' : ''); ?>><?php echo $type; ?></option>
                  <?php } ?>
                </select>
              </td>
              <td class="right"><?php echo $option['sort_order']; ?></td>
              <td class="right"><?php echo $option['status']; ?></td>
              <td>
                <?php foreach ($option['action'] as $action) { ?>
                <a href="<?php echo $action['href']; ?>" class="btn btn-info"><?php echo $action['text']; ?></a>
                <?php } ?>
              </td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr><td class="center" colspan="8"><?php echo $text_no_results; ?></td></tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>

<div id="list-actions">
  <div>
    <strong><span></span> option(s):</strong>
    <label><a onclick="$('#form').submit();" class="button"><?php echo $button_delete; ?></a></label>
  </div>
</div>
<script type="text/javascript"><!--
function filter() {
	var url = 'index.php?route=catalog/filter&token=<?php echo $token; ?>';

	<?php foreach ($filter_url_data as $key) { ?>
	var <?php echo $key; ?> = $('[name=\'<?php echo $key; ?>\']').val();

  if (<?php echo $key; ?> != '') {
		url += '&<?php echo $key; ?>=' + encodeURIComponent(<?php echo $key; ?>);
	}
	<?php } ?>

	location = url;
}
//--></script>
<script type="text/javascript"><!--
$('.filter input:not(.edit)').keydown(function(e) {
	if (e.keyCode == 13) filter();
});
//--></script>
<script type="text/javascript"><!--

$('.edit').keydown(function(e) {
	if (e.keyCode == 13) $(this).next('a').trigger('click');
});

$('.save').live('click', function() {
  var el = $(this), input = el.prev(), field = input.attr('name'), id = el.attr('rel');

  if (input.val()) {
    var value = input.val();
  } else {
    var value = el.parent().val();
  }

  el.fadeTo(250, 0.1);
  $.post('index.php?route=catalog/filter/edit&token=<?php echo $token; ?>', 'field=' + field + '&value=' + value + '&option_id=' + id, function(){el.css('color', '#BF0000').fadeTo(150, 1);});
});

$('.edit-checkbox').live('change', function() {
  var el = $(this), id = el.val(), field = el.attr('name'), td = el.parents('td');

  td.fadeTo(150, 0.1);
  $.post('index.php?route=catalog/filter/edit&token=<?php echo $token; ?>', 'field=' + field + '&value=' + (el.attr('checked') ? '1' : '0') + '&option_id=' + id, function(){ td.fadeTo(150, 1); });
});

$('#type').live('change', function() {
  var type = $(this).val();

  $('input[name*=\'selected\']:checked').each(function() {
    $.post('index.php?route=catalog/filter/edit&token=<?php echo $token; ?>', 'field=type&value=' + type + '&option_id=' + $(this).val());
  });
});

var edit = {
  select: function(select, option_id) {
    var value = select.val(), field = select.attr('name');

    select.fadeTo(250, 0.1, function(){
      select.css('border', '1px solid green');
      $.post('index.php?route=catalog/filter/edit&token=<?php echo $token; ?>', 'field=' + field + '&value=' + value + '&option_id=' + option_id, function(){ select.fadeTo(250, 1); });
    });
  }
}

//--></script>

<script type="text/javascript"><!--
$(document).ready(function() {
  if ($('input[name*=\'selected\']:checked').length > 1) {
    $('#list-actions').animate({top: 130, opacity: 1}, {duration: 250, queue: false});
  }
});

$('input[name*=\'selected\'], .list thead input:first').live('change', function() {
  var el = $('#list-actions'), l = $('input[name*=\'selected\']:checked').length, all = $('input[name*=\'selected\']').length, i = $(this);

  $('strong > span', el).text(l);

  if ((l == 1 || l == all) && i.attr('checked')) {
    el.animate({top: 130, opacity: 1}, {duration: 250, queue: false});
  } else if (l < 1) {
    el.animate({top: -75, opacity: 0}, {duration: 250, queue: false});
  }
});
//--></script>
<?php echo $footer; ?>