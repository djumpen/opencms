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
        <button type="submit" form="form-fedex" class="btn btn-primary "><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
      <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-fedex" class="form-horizontal">
        <div class="form-group required">
          <label class="col-xs-2 control-label" for="input-key"><?php echo $entry_key; ?></label>
          <div class="col-xs-10">
            <input type="text" name="fedex_key" value="<?php echo $fedex_key; ?>" id="input-key" class="form-control" />
            <?php if ($error_key) { ?>
            <div class="text-danger"><?php echo $error_key; ?></div>
            <?php } ?>
          </div>
        </div>
        <div class="form-group required">
          <label class="col-xs-2 control-label" for="input-password"><?php echo $entry_password; ?></label>
          <div class="col-xs-10">
            <input type="text" name="fedex_password" value="<?php echo $fedex_password; ?>" id="input-password" class="form-control" />
            <?php if ($error_password) { ?>
            <div class="text-danger"><?php echo $error_password; ?></div>
            <?php } ?>
          </div>
        </div>
        <div class="form-group required">
          <label class="col-xs-2 control-label" for="input-account"><?php echo $entry_account; ?></label>
          <div class="col-xs-10">
            <input type="text" name="fedex_account" value="<?php echo $fedex_account; ?>" id="input-account" class="form-control" />
            <?php if ($error_account) { ?>
            <div class="text-danger"><?php echo $error_account; ?></div>
            <?php } ?>
          </div>
        </div>
        <div class="form-group required">
          <label class="col-xs-2 control-label" for="input-meter"><?php echo $entry_meter; ?></label>
          <div class="col-xs-10">
            <input type="text" name="fedex_meter" value="<?php echo $fedex_meter; ?>" id="input-meter" class="form-control" />
            <?php if ($error_meter) { ?>
            <div class="text-danger"><?php echo $error_meter; ?></div>
            <?php } ?>
          </div>
        </div>
        <div class="form-group required">
          <label class="col-xs-2 control-label" for="input-postcode"><?php echo $entry_postcode; ?></label>
          <div class="col-xs-10">
            <input type="text" name="fedex_postcode" value="<?php echo $fedex_postcode; ?>" id="input-postcode" class="form-control" />
            <?php if ($error_postcode) { ?>
            <div class="text-danger"><?php echo $error_postcode; ?></div>
            <?php } ?>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label"><?php echo $entry_test; ?></label>
          <div class="col-xs-10">
                <div class="btn-group" data-toggle="buttons">
  			<label class="btn btn-primary<?php if ($fedex_test == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="fedex_test" id="input-status" <?php if ($fedex_test == 1) { ?>checked<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($fedex_test == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="fedex_test" id="input-status" <?php if ($fedex_test == 0) { ?>checked<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>

          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label"><?php echo $entry_service; ?></label>
          <div class="col-xs-10">
            <?php foreach ($services as $service) { ?>
            <div class="checkbox">
              <label>
                <?php if (in_array($service['value'], $fedex_service)) { ?>
                <input type="checkbox" name="fedex_service[]" value="<?php echo $service['value']; ?>" checked="checked" />
                <?php echo $service['text']; ?>
                <?php } else { ?>
                <input type="checkbox" name="fedex_service[]" value="<?php echo $service['value']; ?>" />
                <?php echo $service['text']; ?>
                <?php } ?>
              </label>
            </div>
            <?php } ?>
            <a class="btn btn-success" onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> <a class="btn btn-success" onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a></div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-dropoff-type"><?php echo $entry_dropoff_type; ?></label>
          <div class="col-xs-10">
            <select name="fedex_dropoff_type" id="input-dropoff-type" class="form-control">
              <?php if ($fedex_dropoff_type == 'REGULAR_PICKUP') { ?>
              <option value="REGULAR_PICKUP" selected="selected"><?php echo $text_regular_pickup; ?></option>
              <?php } else { ?>
              <option value="REGULAR_PICKUP"><?php echo $text_regular_pickup; ?></option>
              <?php } ?>
              <?php if ($fedex_dropoff_type == 'REQUEST_COURIER') { ?>
              <option value="REQUEST_COURIER" selected="selected"><?php echo $text_request_courier; ?></option>
              <?php } else { ?>
              <option value="REQUEST_COURIER"><?php echo $text_request_courier; ?></option>
              <?php } ?>
              <?php if ($fedex_dropoff_type == 'DROP_BOX') { ?>
              <option value="DROP_BOX" selected="selected"><?php echo $text_drop_box; ?></option>
              <?php } else { ?>
              <option value="DROP_BOX"><?php echo $text_drop_box; ?></option>
              <?php } ?>
              <?php if ($fedex_dropoff_type == 'BUSINESS_SERVICE_CENTER') { ?>
              <option value="BUSINESS_SERVICE_CENTER" selected="selected"><?php echo $text_business_service_center; ?></option>
              <?php } else { ?>
              <option value="BUSINESS_SERVICE_CENTER"><?php echo $text_business_service_center; ?></option>
              <?php } ?>
              <?php if ($fedex_dropoff_type == 'STATION') { ?>
              <option value="STATION" selected="selected"><?php echo $text_station; ?></option>
              <?php } else { ?>
              <option value="STATION"><?php echo $text_station; ?></option>
              <?php } ?>
            </select>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-packaging-type"><?php echo $entry_packaging_type; ?></label>
          <div class="col-xs-10">
            <select name="fedex_packaging_type" id="input-packaging-type" class="form-control">
              <?php if ($fedex_packaging_type == 'FEDEX_ENVELOPE') { ?>
              <option value="FEDEX_ENVELOPE" selected="selected"><?php echo $text_fedex_envelope; ?></option>
              <?php } else { ?>
              <option value="FEDEX_ENVELOPE"><?php echo $text_fedex_envelope; ?></option>
              <?php } ?>
              <?php if ($fedex_packaging_type == 'FEDEX_PAK') { ?>
              <option value="FEDEX_PAK" selected="selected"><?php echo $text_fedex_pak; ?></option>
              <?php } else { ?>
              <option value="FEDEX_PAK"><?php echo $text_fedex_pak; ?></option>
              <?php } ?>
              <?php if ($fedex_packaging_type == 'FEDEX_BOX') { ?>
              <option value="FEDEX_BOX" selected="selected"><?php echo $text_fedex_box; ?></option>
              <?php } else { ?>
              <option value="FEDEX_BOX"><?php echo $text_fedex_box; ?></option>
              <?php } ?>
              <?php if ($fedex_packaging_type == 'FEDEX_TUBE') { ?>
              <option value="FEDEX_TUBE" selected="selected"><?php echo $text_fedex_tube; ?></option>
              <?php } else { ?>
              <option value="FEDEX_TUBE"><?php echo $text_fedex_tube; ?></option>
              <?php } ?>
              <?php if ($fedex_packaging_type == 'FEDEX_10KG_BOX') { ?>
              <option value="FEDEX_10KG_BOX" selected="selected"><?php echo $text_fedex_10kg_box; ?></option>
              <?php } else { ?>
              <option value="FEDEX_10KG_BOX"><?php echo $text_fedex_10kg_box; ?></option>
              <?php } ?>
              <?php if ($fedex_packaging_type == 'FEDEX_25KG_BOX') { ?>
              <option value="FEDEX_25KG_BOX" selected="selected"><?php echo $text_fedex_25kg_box; ?></option>
              <?php } else { ?>
              <option value="FEDEX_25KG_BOX"><?php echo $text_fedex_25kg_box; ?></option>
              <?php } ?>
              <?php if ($fedex_packaging_type == 'YOUR_PACKAGING') { ?>
              <option value="YOUR_PACKAGING" selected="selected"><?php echo $text_your_packaging; ?></option>
              <?php } else { ?>
              <option value="YOUR_PACKAGING"><?php echo $text_your_packaging; ?></option>
              <?php } ?>
            </select>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-rate-type"><?php echo $entry_rate_type; ?></label>
          <div class="col-xs-10">
            <select name="fedex_rate_type" id="input-rate-type" class="form-control">
              <?php if ($fedex_rate_type == 'LIST') { ?>
              <option value="LIST" selected="selected"><?php echo $text_list_rate; ?></option>
              <?php } else { ?>
              <option value="LIST"><?php echo $text_list_rate; ?></option>
              <?php } ?>
              <?php if ($fedex_rate_type == 'ACCOUNT') { ?>
              <option value="ACCOUNT" selected="selected"><?php echo $text_account_rate; ?></option>
              <?php } else { ?>
              <option value="ACCOUNT"><?php echo $text_account_rate; ?></option>
              <?php } ?>
            </select>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label"><?php echo $entry_display_time; ?></label>
          <div class="col-xs-10">
                <div class="btn-group" data-toggle="buttons">
  			<label class="btn btn-primary<?php if ($fedex_display_time == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="fedex_display_time" id="input-status" <?php if ($fedex_display_time == 1) { ?>checked<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($fedex_display_time == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="fedex_display_time" id="input-status" <?php if ($fedex_display_time == 0) { ?>checked<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
	</div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label"><?php echo $entry_display_weight; ?></label>
          <div class="col-xs-10">
                <div class="btn-group" data-toggle="buttons">
  			<label class="btn btn-primary<?php if ($fedex_display_weight == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="fedex_display_weight" id="input-status" <?php if ($fedex_display_weight == 1) { ?>checked<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($fedex_display_weight == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="fedex_display_weight" id="input-status" <?php if ($fedex_display_weight == 0) { ?>checked<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>

	</div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-weight-class"><?php echo $entry_weight_class; ?></label>
          <div class="col-xs-10">
            <select name="fedex_weight_class_id" id="input-weight-class" class="form-control">
              <?php foreach ($weight_classes as $weight_class) { ?>
              <?php if ($weight_class['weight_class_id'] == $fedex_weight_class_id) { ?>
              <option value="<?php echo $weight_class['weight_class_id']; ?>" selected="selected"><?php echo $weight_class['title']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $weight_class['weight_class_id']; ?>"><?php echo $weight_class['title']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
	</div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-tax-class"><?php echo $entry_tax_class; ?></label>
          <div class="col-xs-10">
            <select name="fedex_tax_class_id" id="input-tax-class" class="form-control">
              <option value="0"><?php echo $text_none; ?></option>
              <?php foreach ($tax_classes as $tax_class) { ?>
              <?php if ($tax_class['tax_class_id'] == $fedex_tax_class_id) { ?>
              <option value="<?php echo $tax_class['tax_class_id']; ?>" selected="selected"><?php echo $tax_class['title']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $tax_class['tax_class_id']; ?>"><?php echo $tax_class['title']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-geo-zone"><?php echo $entry_geo_zone; ?></label>
          <div class="col-xs-10">
            <select name="fedex_geo_zone_id" id="input-geo-zone" class="form-control">
              <option value="0"><?php echo $text_all_zones; ?></option>
              <?php foreach ($geo_zones as $geo_zone) { ?>
              <?php if ($geo_zone['geo_zone_id'] == $fedex_geo_zone_id) { ?>
              <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
          <div class="col-xs-10">
                <div class="btn-group" data-toggle="buttons">
  			<label class="btn btn-primary<?php if ($fedex_status == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="fedex_status" id="input-status" <?php if ($fedex_status == 1) { ?>checked<?php } ?>> <?php echo $text_enabled; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($fedex_status == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="fedex_status" id="input-status" <?php if ($fedex_status == 0) { ?>checked<?php } ?>> <?php echo $text_disabled; ?>
  			</label>
		</div>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
          <div class="col-xs-10">
            <input type="text" name="fedex_sort_order" value="<?php echo $fedex_sort_order; ?>" id="input-sort-order" class="form-control" />
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>