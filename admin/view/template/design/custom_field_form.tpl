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
        <button type="submit" form="form-download" class="btn btn-primary "><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" class="btn btn-danger"><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
      <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
         <div class="form-group required">
          <label class="col-xs-2 control-label"><?php echo $entry_name; ?></label>
          <div class="col-xs-10">
            <?php foreach ($languages as $language) { ?>
            <div class="input-group"> <span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
              <input type="text" name="custom_field_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($custom_field_description[$language['language_id']]) ? $custom_field_description[$language['language_id']]['name'] : ''; ?>" class="form-control" />
            </div>
            <?php if (isset($error_name[$language['language_id']])) { ?>
            <div class="text-danger"><?php echo $error_name[$language['language_id']]; ?></div>
            <?php } ?>
            <?php } ?>
          </div>
        </div>       
        <div class="form-group">
          <label class="col-xs-2 control-label"><?php echo $entry_type; ?></label>
          <div class="col-xs-10">
            <div class="input-group">
             <select name="type" class="form-control">
                <optgroup label="<?php echo $text_choose; ?>">
                <?php if ($type == 'select') { ?>
                <option value="select" selected><?php echo $text_select; ?></option>
                <?php } else { ?>
                <option value="select"><?php echo $text_select; ?></option>
                <?php } ?>
                <?php if ($type == 'radio') { ?>
                <option value="radio" selected><?php echo $text_radio; ?></option>
                <?php } else { ?>
                <option value="radio"><?php echo $text_radio; ?></option>
                <?php } ?>
                <?php if ($type == 'checkbox') { ?>
                <option value="checkbox" selected><?php echo $text_checkbox; ?></option>
                <?php } else { ?>
                <option value="checkbox"><?php echo $text_checkbox; ?></option>
                <?php } ?>
                </optgroup>
                <optgroup label="<?php echo $text_input; ?>">
                <?php if ($type == 'text') { ?>
                <option value="text" selected><?php echo $text_text; ?></option>
                <?php } else { ?>
                <option value="text"><?php echo $text_text; ?></option>
                <?php } ?>
                <?php if ($type == 'textarea') { ?>
                <option value="textarea" selected><?php echo $text_textarea; ?></option>
                <?php } else { ?>
                <option value="textarea"><?php echo $text_textarea; ?></option>
                <?php } ?>
                </optgroup>
                <optgroup label="<?php echo $text_file; ?>">
                <?php if ($type == 'file') { ?>
                <option value="file" selected><?php echo $text_file; ?></option>
                <?php } else { ?>
                <option value="file"><?php echo $text_file; ?></option>
                <?php } ?>
                </optgroup>
                <optgroup label="<?php echo $text_date; ?>">
                <?php if ($type == 'date') { ?>
                <option value="date" selected><?php echo $text_date; ?></option>
                <?php } else { ?>
                <option value="date"><?php echo $text_date; ?></option>
                <?php } ?>
                <?php if ($type == 'time') { ?>
                <option value="time" selected><?php echo $text_time; ?></option>
                <?php } else { ?>
                <option value="time"><?php echo $text_time; ?></option>
                <?php } ?>
                <?php if ($type == 'datetime') { ?>
                <option value="datetime" selected><?php echo $text_datetime; ?></option>
                <?php } else { ?>
                <option value="datetime"><?php echo $text_datetime; ?></option>
                <?php } ?>
                </optgroup>
              </select>
			  </div>
			</div>
		</div>
		            <div class="form-group" id="display-value">
              <label class="col-xs-2 control-label" for="input-sort-order"><?php echo $entry_value; ?></label>
              <div class="col-xs-10">
                <input type="text" name="value" value="<?php echo $value; ?>"  class="form-control" />
              </div>
            </div>
			
			            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-status"><?php echo $entry_required; ?></label>
              <div class="col-xs-10">

<div class="btn-group" data-toggle="buttons">
  <label class="btn btn-primary<?php if ($required == 1) { ?> active<?php } ?>">
    <i class="fa fa-check"></i> <input type="radio" name="required" value="1" id="input-status" <?php if ($required == 1) { ?>checked<?php } ?>>  <?php echo $text_yes; ?>
  </label>
  <label class="btn btn-primary<?php if ($required == 0) { ?> active<?php } ?>">
    <i class="fa fa-times"></i> <input type="radio" name="required" value="0" id="input-status" <?php if ($required == 0) { ?>checked<?php } ?>>  <?php echo $text_no; ?>
  </label>
</div>

              </div>
            </div>
			        <div class="form-group">
          <label class="col-xs-2 control-label"><?php echo $entry_location; ?></label>
          <div class="col-xs-10">
            <div class="input-group">
                <select name="location"  class="form-control">
                <?php if ($location == 'customer') { ?>
                <option value="customer" selected><?php echo $text_customer; ?></option>
                <?php } else { ?>
                <option value="customer"><?php echo $text_customer; ?></option>
                <?php } ?>
                <?php if ($location == 'address') { ?>
                <option value="address" selected><?php echo $text_address; ?></option>
                <?php } else { ?>
                <option value="address"><?php echo $text_address; ?></option>
                <?php } ?>
                <?php if ($location == 'payment_address') { ?>
                <option value="payment_address" selected><?php echo $text_payment_address; ?></option>
                <?php } else { ?>
                <option value="payment_address"><?php echo $text_payment_address; ?></option>
                <?php } ?>  
                <?php if ($location == 'shipping_address') { ?>
                <option value="shipping_address" selected><?php echo $text_shipping_address; ?></option>
                <?php } else { ?>
                <option value="shipping_address"><?php echo $text_shipping_address; ?></option>
                <?php } ?>                                
              </select></div>
          </div>
        </div>
					        <div class="form-group">
          <label class="col-xs-2 control-label"><?php echo $entry_position; ?></label>
          <div class="col-xs-10">
           <input type="text" name="position" value="<?php echo $position; ?>" class="form-control"/>
		   </div>
		   </div>
         					        <div class="form-group">
          <label class="col-xs-2 control-label"><?php echo $entry_sort_order; ?></label>
          <div class="col-xs-10">
           <input type="text" name="sort_order" value="<?php echo $sort_order; ?>" size="1" class="form-control" />
		   </div>
		   </div>
                  <div class="table-responsive">

        <table id="custom-field-value" class="table table-striped table-bordered table-hover">
          <thead>
            <tr>
              <td class="left"><span class="required">*</span> <?php echo $entry_custom_value; ?></td>
              <td class="right"><?php echo $entry_sort_order; ?></td>
              <td></td>
            </tr>
          </thead>
          <?php $custom_field_value_row = 0; ?>
          <?php foreach ($custom_field_values as $custom_field_value) { ?>
          <tbody id="custom-field-value-row<?php echo $custom_field_value_row; ?>">
            <tr>
              <td class="left"><input type="hidden" name="custom_field_value[<?php echo $custom_field_value_row; ?>][custom_field_value_id]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" class="form-control"/>
			  
                <?php foreach ($languages as $language) { ?>
                 <div class="input-group"> <span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span><input type="text" name="custom_field_value[<?php echo $custom_field_value_row; ?>][custom_field_value_description][<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($custom_field_value['custom_field_value_description'][$language['language_id']]) ? $custom_field_value['custom_field_value_description'][$language['language_id']]['name'] : ''; ?>" class="form-control" />
                </div><br />
                <?php if (isset($error_custom_field_value[$custom_field_value_row][$language['language_id']])) { ?>
                <span class="error"><?php echo $error_custom_field_value[$custom_field_value_row][$language['language_id']]; ?></span>
                <?php } ?>
                <?php } ?></div></div></td>
              <td class="right"><input type="text" name="custom_field_value[<?php echo $custom_field_value_row; ?>][sort_order]" value="<?php echo $custom_field_value['sort_order']; ?>" size="1" class="form-control" /></td>
              <td class="left"><a onclick="$('#custom-field-value-row<?php echo $custom_field_value_row; ?>').remove();" class="btn btn-danger"><i class="fa fa-minus-circle"></i><?php echo $button_remove; ?></a></td>
            </tr>
          </tbody>
          <?php $custom_field_value_row++; ?>
          <?php } ?>
          <tfoot>
            <tr>
              <td colspan="2"></td>
              <td class="left"><a onclick="addCustomFieldValue();" class="btn btn-primary"><i class="fa fa-plus-circle"></i> <?php echo $button_add_custom_field_value; ?></a></td>
            </tr>
          </tfoot>
        </table>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('select[name=\'type\']').on('change', function() {
	if (this.value == 'select' || this.value == 'radio' || this.value == 'checkbox') {
		$('#custom-field-value').show();
		$('#display-value').hide();
	} else {
		$('#custom-field-value').hide();
		$('#display-value').show();
	}
	
	$('input[name=\'value\']').attr('type', 'text');
	
	if (this.value == 'date') {
		 $('input[name=\'value\']').attr('type', 'date');
	} else if (this.value == 'time') {
		$('input[name=\'value\']').attr('type', 'time');
	} else if (this.value == 'datetime') {
		$('input[name=\'value\']').attr('type', 'datetime-local');
	}
});

$('select[name=\'type\']').trigger('change');

$('input[name^=\'location\']').on('change', function() {
	
	if (this.value == 'account') {
		//$('#custom-field-value').show();
		//$('#display-value').hide();
	}
	
	
	
});

var custom_field_value_row = <?php echo $custom_field_value_row; ?>;

function addCustomFieldValue() {
	html  = '<tbody id="custom-field-value-row' + custom_field_value_row + '">';
	html += '  <tr>';	
    html += '    <td class="left"><input class="form-control" type="hidden" name="custom_field_value[' + custom_field_value_row + '][custom_field_value_id]" value="" />';
	<?php foreach ($languages as $language) { ?>
	html += ' <div class="input-group"> <span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span><input class="form-control" type="text" name="custom_field_value[' + custom_field_value_row + '][custom_field_value_description][<?php echo $language['language_id']; ?>][name]" value="" /> </div><br />';
    <?php } ?>
	html += '    </td>';
	html += '    <td class="right"><input type="text" name="custom_field_value[' + custom_field_value_row + '][sort_order]" value="" size="1" /></td>';
	html += '    <td class="left"><a onclick="$(\'#custom-field-value-row' + custom_field_value_row + '\').remove();" class="btn btn-danger"><i class="fa fa-minus-circle"></i><?php echo $button_remove; ?></a></td>';
	html += '  </tr>';	
    html += '</tbody>';
	
	$('#custom-field-value tfoot').before(html);
	
	custom_field_value_row++;
}
//--></script>
<?php echo $footer; ?>