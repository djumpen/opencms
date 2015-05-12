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
        <button type="submit" form="form-auspost" class="btn btn-primary "><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
      <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-auspost" class="form-horizontal">
        <div class="form-group required">
          <label class="col-xs-2 control-label" for="input-postcode"><?php echo $entry_postcode; ?></label>
          <div class="col-xs-10">
            <input type="text" name="auspost_postcode" value="<?php echo $auspost_postcode; ?>" id="input-postcode" class="form-control" maxlength="4" />
            <?php if ($error_postcode) { ?>
            <div class="text-danger"><?php echo $error_postcode; ?></div>
            <?php } ?>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-standard"><?php echo $entry_standard ?></label>
          <div class="col-xs-10">
                <div class="btn-group" data-toggle="buttons">
  			<label class="btn btn-primary<?php if ($auspost_standard == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="auspost_standard" id="input-status" <?php if ($auspost_standard == 1) { ?>checked<?php } ?>> <?php echo $text_enabled; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($auspost_standard == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="auspost_standard" id="input-status" <?php if ($auspost_standard == 0) { ?>checked<?php } ?>> <?php echo $text_disabled; ?>
  			</label>
		</div>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-express"><?php echo $entry_express; ?></label>
          <div class="col-xs-10">
                <div class="btn-group" data-toggle="buttons">
  			<label class="btn btn-primary<?php if ($auspost_express == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="auspost_express" id="input-status" <?php if ($auspost_express == 1) { ?>checked<?php } ?>> <?php echo $text_enabled; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($auspost_express == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="auspost_express" id="input-status" <?php if ($auspost_express == 0) { ?>checked<?php } ?>> <?php echo $text_disabled; ?>
  			</label>
		</div>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-display-time"><?php echo $entry_display_time; ?></label>
          <div class="col-xs-10">

               <div class="btn-group" data-toggle="buttons">
  			<label class="btn btn-primary<?php if ($auspost_display_time == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="auspost_display_time" id="input-status" <?php if ($auspost_display_time == 1) { ?>checked<?php } ?>> <?php echo $text_enabled; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($auspost_display_time == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="auspost_display_time" id="input-status" <?php if ($auspost_display_time == 0) { ?>checked<?php } ?>> <?php echo $text_disabled; ?>
  			</label>
		</div>
	 </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-weight-class"><?php echo $entry_weight_class; ?></label>
          <div class="col-xs-10">
            <select name="auspost_weight_class_id" id="input-weight-class" class="form-control">
              <?php foreach ($weight_classes as $weight_class) { ?>
              <?php if ($weight_class['weight_class_id'] == $auspost_weight_class_id) { ?>
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
            <select name="auspost_tax_class_id" id="input-tax-class" class="form-control">
              <option value="0"><?php echo $text_none; ?></option>
              <?php foreach ($tax_classes as $tax_class) { ?>
              <?php if ($tax_class['tax_class_id'] == $auspost_tax_class_id) { ?>
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
            <select name="auspost_geo_zone_id" id="input-geo-zone" class="form-control">
              <option value="0"><?php echo $text_all_zones; ?></option>
              <?php foreach ($geo_zones as $geo_zone) { ?>
              <?php if ($geo_zone['geo_zone_id'] == $auspost_geo_zone_id) { ?>
              <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-status"><?php echo $entry_status ?></label>
          <div class="col-xs-10">

                <div class="btn-group" data-toggle="buttons">
  			<label class="btn btn-primary<?php if ($auspost_status == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="auspost_status" id="input-status" <?php if ($auspost_status == 1) { ?>checked<?php } ?>> <?php echo $text_enabled; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($auspost_status == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="auspost_status" id="input-status" <?php if ($auspost_status == 0) { ?>checked<?php } ?>> <?php echo $text_disabled; ?>
  			</label>
		</div>

          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
          <div class="col-xs-10">
            <input type="text" name="auspost_sort_order" value="<?php echo $auspost_sort_order; ?>" id="input-sort-order" class="form-control" />
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>