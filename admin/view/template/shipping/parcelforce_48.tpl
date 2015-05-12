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
        <button type="submit" form="form-parcelforce-48" class="btn btn-primary "><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
      <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-parcelforce-48" class="form-horizontal">
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-rate"><?php echo $entry_rate; ?></label>
          <div class="col-xs-10">
            <textarea name="parcelforce_48_rate" rows="5" id="input-rate" class="form-control"><?php echo $parcelforce_48_rate; ?></textarea>
	 </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-insurance"><?php echo $entry_insurance; ?></label>
          <div class="col-xs-10">
            <textarea name="parcelforce_48_insurance" rows="5" id="input-insurance" class="form-control"><?php echo $parcelforce_48_insurance; ?></textarea>
	 </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label"><?php echo $entry_display_weight; ?></label>
          <div class="col-xs-10">
                <div class="btn-group" data-toggle="buttons">
  			<label class="btn btn-primary<?php if ($parcelforce_48_display_weight == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="parcelforce_48_display_weight" id="input-status" <?php if ($parcelforce_48_display_weight == 1) { ?>checked<?php } ?>> <?php echo $text_enabled; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($parcelforce_48_display_weight == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="parcelforce_48_display_weight" id="input-status" <?php if ($parcelforce_48_display_weight == 0) { ?>checked<?php } ?>> <?php echo $text_disabled; ?>
  			</label>
		</div>
	 </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-display-insurance"><?php echo $entry_display_insurance; ?></label>
          <div class="col-xs-10">
                <div class="btn-group" data-toggle="buttons">
  			<label class="btn btn-primary<?php if ($parcelforce_48_display_insurance == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="parcelforce_48_display_insurance" id="input-status" <?php if ($parcelforce_48_display_insurance == 1) { ?>checked<?php } ?>> <?php echo $text_enabled; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($parcelforce_48_display_insurance == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="parcelforce_48_display_insurance" id="input-status" <?php if ($parcelforce_48_display_insurance == 0) { ?>checked<?php } ?>> <?php echo $text_disabled; ?>
  			</label>
		</div>
	 </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label"><?php echo $entry_display_time; ?></label>
          <div class="col-xs-10">
                <div class="btn-group" data-toggle="buttons">
  			<label class="btn btn-primary<?php if ($parcelforce_48_display_time == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="parcelforce_48_display_time" id="input-status" <?php if ($parcelforce_48_display_time == 1) { ?>checked<?php } ?>> <?php echo $text_enabled; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($parcelforce_48_display_time == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="parcelforce_48_display_time" id="input-status" <?php if ($parcelforce_48_display_time == 0) { ?>checked<?php } ?>> <?php echo $text_disabled; ?>
  			</label>
		</div>
	 </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-tax-class"><?php echo $entry_tax_class; ?></label>
          <div class="col-xs-10">
            <select name="parcelforce_48_tax_class_id" id="input-tax-class" class="form-control">
              <option value="0"><?php echo $text_none; ?></option>
              <?php foreach ($tax_classes as $tax_class) { ?>
              <?php if ($tax_class['tax_class_id'] == $parcelforce_48_tax_class_id) { ?>
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
            <select name="parcelforce_48_geo_zone_id" id="input-geo-zone" class="form-control">
              <option value="0"><?php echo $text_all_zones; ?></option>
              <?php foreach ($geo_zones as $geo_zone) { ?>
              <?php if ($geo_zone['geo_zone_id'] == $parcelforce_48_geo_zone_id) { ?>
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
  			<label class="btn btn-primary<?php if ($parcelforce_48_status == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="parcelforce_48_status" id="input-status" <?php if ($parcelforce_48_status == 1) { ?>checked<?php } ?>> <?php echo $text_enabled; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($parcelforce_48_status == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="parcelforce_48_status" id="input-status" <?php if ($parcelforce_48_status == 0) { ?>checked<?php } ?>> <?php echo $text_disabled; ?>
  			</label>
		</div>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
          <div class="col-xs-10">
            <input type="text" name="parcelforce_48_sort_order" value="<?php echo $parcelforce_48_sort_order; ?>" id="input-sort-order" class="form-control" />
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?> 