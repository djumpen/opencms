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
        <button type="submit" form="form-nochex" class="btn btn-primary "><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
      <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-nochex" class="form-horizontal">
        <div class="form-group required">
          <label class="col-xs-2 control-label" for="input-email"><?php echo $entry_email; ?></label>
          <div class="col-xs-10">
            <input type="text" name="nochex_email" value="<?php echo $nochex_email; ?>" id="input-email" class="form-control"/>
            <?php if ($error_email) { ?>
            <div class="text-danger"><?php echo $error_email; ?></div>
            <?php } ?>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-account"><?php echo $entry_account; ?></label>
          <div class="col-xs-10">
            <select name="nochex_account" id="input-account" class="form-control">
              <?php if ($nochex_account == 'seller') { ?>
              <option value="seller" selected="selected"><?php echo $text_seller; ?></option>
              <?php } else { ?>
              <option value="seller"><?php echo $text_seller; ?></option>
              <?php } ?>
              <?php if ($nochex_account == 'merchant') { ?>
              <option value="merchant" selected="selected"><?php echo $text_merchant; ?></option>
              <?php } else { ?>
              <option value="merchant"><?php echo $text_merchant; ?></option>
              <?php } ?>
            </select>
          </div>
        </div>
        <div class="form-group required">
          <label class="col-xs-2 control-label" for="input-merchant"><?php echo $entry_merchant; ?></label>
          <div class="col-xs-10">
            <input type="text" name="nochex_merchant" value="<?php echo $nochex_merchant; ?>" d="input-merchant" class="form-control" />
            <?php if ($error_merchant) { ?>
            <div class="text-danger"><?php echo $error_merchant; ?></div>
            <?php } ?>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label"><?php echo $entry_template; ?></label>
          <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($nochex_template == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="nochex_template" value="1" <?php if ($nochex_template == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($nochex_template == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="nochex_template" value="0" <?php if ($nochex_template == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label"><?php echo $entry_test; ?></label>
          <div class="col-xs-10">
            <label class="radio-inline">
              <?php if ($nochex_test) { ?>
              <input type="radio" name="nochex_test" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <?php } else { ?>
              <input type="radio" name="nochex_test" value="1" />
              <?php echo $text_yes; ?>
              <?php } ?>
            </label>
            <label class="radio-inline">
              <?php if (!$nochex_test) { ?>
              <input type="radio" name="nochex_test" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="nochex_test" value="0" />
              <?php echo $text_no; ?>
              <?php } ?>
            </label>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-total"><?php echo $entry_total; ?></label>
          <div class="col-xs-10">
            <input type="text" name="nochex_total" value="<?php echo $nochex_total; ?>" id="input-total" class="form-control" />
	 </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-order-status"><?php echo $entry_order_status; ?></label>
          <div class="col-xs-10">
            <select name="nochex_order_status_id" id="input-order-status" class="form-control">
              <?php foreach ($order_statuses as $order_status) { ?>
              <?php if ($order_status['order_status_id'] == $nochex_order_status_id) { ?>
              <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-geo-zone"><?php echo $entry_geo_zone; ?></label>
          <div class="col-xs-10">
            <select name="nochex_geo_zone_id" id="input-geo-zone" class="form-control">
              <option value="0"><?php echo $text_all_zones; ?></option>
              <?php foreach ($geo_zones as $geo_zone) { ?>
              <?php if ($geo_zone['geo_zone_id'] == $nochex_geo_zone_id) { ?>
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
  			<label class="btn btn-primary<?php if ($nochex_status == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="nochex_status" id="input-status" <?php if ($nochex_status == 1) { ?>checked<?php } ?>> <?php echo $text_enabled; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($nochex_status == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="nochex_status" id="input-status" <?php if ($nochex_status == 0) { ?>checked<?php } ?>> <?php echo $text_disabled; ?>
  			</label>
		</div>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
          <div class="col-xs-10">
            <input type="text" name="nochex_sort_order" value="<?php echo $nochex_sort_order; ?>" id="input-sort-order" class="form-control" />
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?> 