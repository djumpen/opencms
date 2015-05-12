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
  <?php } ?>
  <div class="panel panel-default">
    <div class="panel-heading">
      <div class="pull-right">
        <button type="submit" form="form-authorizenet-aim" class="btn btn-primary "><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
      <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    </div>


  <div class="panel-body">
      <form action="<?php echo $action; ?>" method="POST" enctype="multipart/form-data" class="form-horizontal">

	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_payflow_iframe_vendor"><?php echo $entry_vendor; ?></label>
		<div class="col-xs-10">
		     <input type="text" name="pp_payflow_iframe_vendor" value="<?php echo $pp_payflow_iframe_vendor; ?>" class="form-control"/>
			<span class="help-block"><?php echo $help_vendor ?></span>
                        <?php if ($error_vendor) { ?>
                            <span class="error"><?php echo $error_vendor; ?></span>
                        <?php } ?>
              </div>
         </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_payflow_iframe_user"><?php echo $entry_user; ?></label>
		<div class="col-xs-10">
                <input type="text" name="pp_payflow_iframe_user" value="<?php echo $pp_payflow_iframe_user; ?>" class="form-control"/>
		<span class="help-block"><?php echo $help_user ?></span>
                        <?php if ($error_user) { ?>
                            <span class="error"><?php echo $error_user; ?></span>
                        <?php } ?>
                    </div>
                </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_payflow_iframe_password"><?php echo $entry_password; ?></label>
		<div class="col-xs-10">
                   <input type="text" name="pp_payflow_iframe_password" value="<?php echo $pp_payflow_iframe_password; ?>" class="form-control"/>
			<span class="help-block"><?php echo $help_password ?></span>
                        <?php if ($error_password) { ?>
                            <span class="error"><?php echo $error_password; ?></span>
                        <?php } ?>
                    </div>
                </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_payflow_iframe_partner"><?php echo $entry_partner; ?></label>
		<div class="col-xs-10">
                    <input type="text" name="pp_payflow_iframe_partner" value="<?php echo $pp_payflow_iframe_partner; ?>" class="form-control"/>
			<span class="help-block"><?php echo $help_partner ?></span>
                        <?php if ($error_partner) { ?>
                            <span class="error"><?php echo $error_partner; ?></span>
                        <?php } ?>
                    </div>
                </div>
        <div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_payflow_iframe_transaction_method"><?php echo $entry_transaction_method; ?></label>
		<div class="col-xs-10">
                        <select name="pp_payflow_iframe_transaction_method" class="form-control">
                            <?php if ($pp_payflow_iframe_transaction_method == 'authorization') { ?>
                                <option value="sale"><?php echo $text_sale; ?></option>
                                <option value="authorization" selected="selected"><?php echo $text_authorization; ?></option>
                            <?php } else { ?>
                                <option value="sale" selected="selected"><?php echo $text_sale; ?></option>
                                <option value="authorization"><?php echo $text_authorization; ?></option>
                            <?php } ?>
                        </select>
                    </div>
                </div>
        <div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_payflow_iframe_test"><?php echo $entry_test; ?></label>
		<div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($pp_payflow_iframe_test == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="pp_payflow_iframe_test" id="pp_payflow_iframe_test" value="1" <?php if ($pp_payflow_iframe_test == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($pp_payflow_iframe_test == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="pp_payflow_iframe_test" id="pp_payflow_iframe_test" value="0" <?php if ($pp_payflow_iframe_test == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
                    </div>
                </div>
        <div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_payflow_iframe_debug"><?php echo $entry_debug; ?></label>
		<div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($pp_payflow_iframe_debug == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="pp_payflow_iframe_debug" id="pp_payflow_iframe_debug" value="1" <?php if ($pp_payflow_iframe_debug == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($pp_payflow_iframe_debug == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="pp_payflow_iframe_debug" id="pp_payflow_iframe_debug" value="0" <?php if ($pp_payflow_iframe_debug == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
		<span class="help-block"><?php echo $help_debug ?></span>
                    </div>
                </div>
        <div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_payflow_iframe_checkout_method"><?php echo $entry_checkout_method ?></label>
		<div class="col-xs-10">
                        <select name="pp_payflow_iframe_checkout_method" class="form-control">
                            <?php if ($pp_payflow_iframe_checkout_method == 'iframe'): ?>
                                        
                                <option value="iframe" selected="selected"><?php echo $text_iframe ?></option>
                                <option value="redirect"><?php echo $text_redirect ?></option>
                                        
                            <?php else: ?>
                                        
                                <option value="iframe"><?php echo $text_iframe ?></option>
                                <option value="redirect" selected="selected"><?php echo $text_redirect ?></option>
                                        
                            <?php endif; ?>
                        </select>
		<span class="help-block"><?php echo $help_checkout_method ?></span>
                    </div>
                </div>
        <div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_payflow_iframe_order_status_id"><?php echo $entry_order_status; ?></label>
                    <div class="col-xs-10">
                        <select name="pp_payflow_iframe_order_status_id" class="form-control">
                            <?php foreach ($order_statuses as $order_status) { ?>
                                <?php if ($order_status['order_status_id'] == $pp_payflow_iframe_order_status_id) { ?>
                                    <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                <?php } else { ?>
                                    <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                <?php } ?>
                            <?php } ?>
                        </select>
                    </div>
                </div>
        <div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_payflow_iframe_total"><?php echo $entry_total; ?></label>
                    <div class="col-xs-10">
                    <input type="text" name="pp_payflow_iframe_total" value="<?php echo $pp_payflow_iframe_total; ?>" class="form-control"/>
                </div>
          </div>
        <div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_payflow_iframe_geo_zone_id"><?php echo $entry_geo_zone; ?></label>
                    <div class="col-xs-10">
                        <select name="pp_payflow_iframe_geo_zone_id" class="form-control">
                            <option value="0"><?php echo $text_all_zones; ?></option>
                            <?php foreach ($geo_zones as $geo_zone) { ?>
                                <?php if ($geo_zone['geo_zone_id'] == $pp_payflow_iframe_geo_zone_id) { ?>
                                    <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
                                <?php } else { ?>
                                    <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
                                <?php } ?>
                            <?php } ?>
                        </select>
                    </div>
                </div>
        <div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_payflow_iframe_status"><?php echo $entry_status; ?></label>
                    <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($pp_payflow_iframe_status == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="pp_payflow_iframe_status" id="pp_payflow_iframe_status" value="1" <?php if ($pp_payflow_iframe_status == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($pp_payflow_iframe_status == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="pp_payflow_iframe_status" id="pp_payflow_iframe_status" value="0" <?php if ($pp_payflow_iframe_status == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
                    </div>
                </div>
        <div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_payflow_iframe_sort_order"><?php echo $entry_sort_order; ?></label>
                    <div class="col-xs-10">
			<input type="text" name="pp_payflow_iframe_sort_order" value="<?php echo $pp_payflow_iframe_sort_order; ?>" class="form-control"/>
                </div>
                </div>
        <div class="form-group required">
          <label class="col-xs-2 control-label" for="cancel_url"><?php echo $entry_cancel_url; ?></label>
                    <div class="col-xs-10">
			<input type="text" name="cancel_url" value="<?php echo $cancel_url ?>" class="form-control"/>
		</div>
	</div>
        <div class="form-group required">
          <label class="col-xs-2 control-label" for="error_url"><?php echo $entry_error_url; ?></label>
                    <div class="col-xs-10">
			<input type="text" name="error_url" value="<?php echo $error_url; ?>" class="form-control"/>
		</div>
	</div>
        <div class="form-group required">
          <label class="col-xs-2 control-label" for="return_url"><?php echo $entry_return_url; ?></label>
                    <div class="col-xs-10">
			<input type="text" name="return_url" value="<?php echo $return_url ?>" class="form-control"/>
		</div>
	</div>
        <div class="form-group required">
          <label class="col-xs-2 control-label" for="post_url"><?php echo $entry_post_url; ?></label>
                    <div class="col-xs-10">
			<input type="text" name="post_url" value="<?php echo $post_url ?>" class="form-control"/>
		</div>
	</div>

        </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>