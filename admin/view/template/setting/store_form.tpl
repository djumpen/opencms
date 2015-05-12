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
  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div class="panel panel-default">
    <div class="panel-heading">
      <div class="pull-right">
        <button type="submit" form="form-store" class="btn btn-primary "><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
      <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-store" class="form-horizontal">
        <ul class="nav nav-tabs">
          <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
          <li><a href="#tab-store" data-toggle="tab"><?php echo $tab_store; ?></a></li>
          <li><a href="#tab-local" data-toggle="tab"><?php echo $tab_local; ?></a></li>
          <li><a href="#tab-option" data-toggle="tab"><?php echo $tab_option; ?></a></li>
          <li><a href="#tab-image" data-toggle="tab"><?php echo $tab_image; ?></a></li>
          <li><a href="#tab-server" data-toggle="tab"><?php echo $tab_server; ?></a></li>
        </ul>
        <div class="tab-content">
          <div class="tab-pane active" id="tab-general">
            <div class="form-group required">
              <label class="col-xs-2 control-label" for="input-url"><?php echo $entry_url; ?></label>
              <div class="col-xs-10">
                <input type="text" name="config_url" value="<?php echo $config_url; ?>" id="input-url" class="form-control" />
                <?php if ($error_url) { ?>
                <div class="text-danger"><?php echo $error_url; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-ssl"><?php echo $entry_ssl; ?></label>
              <div class="col-xs-10">
                <input type="text" name="config_ssl" value="<?php echo $config_ssl; ?>" id="input-ssl" class="form-control" />
		</div>
            </div>
            <div class="form-group required">
              <label class="col-xs-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
              <div class="col-xs-10">
                <input type="text" name="config_name" value="<?php echo $config_name; ?>" id="input-name" class="form-control" />
                <?php if ($error_name) { ?>
                <div class="text-danger"><?php echo $error_name; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group required">
              <label class="col-xs-2 control-label" for="input-owner"><?php echo $entry_owner; ?></label>
              <div class="col-xs-10">
                <input type="text" name="config_owner" value="<?php echo $config_owner; ?>" id="input-owner" class="form-control" />
                <?php if ($error_owner) { ?>
                <div class="text-danger"><?php echo $error_owner; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group required">
              <label class="col-xs-2 control-label" for="input-address"><?php echo $entry_address; ?></label>
              <div class="col-xs-10">
                <textarea name="config_address" rows="5" id="input-address" class="form-control"><?php echo $config_address; ?></textarea>
                <?php if ($error_address) { ?>
                <div class="text-danger"><?php echo $error_address; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group required">
              <label class="col-xs-2 control-label" for="input-email"><?php echo $entry_email; ?></label>
              <div class="col-xs-10">
                <input type="text" name="config_email" value="<?php echo $config_email; ?>" id="input-email" class="form-control" />
                <?php if ($error_email) { ?>
                <div class="text-danger"><?php echo $error_email; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group required">
              <label class="col-xs-2 control-label" for="input-telephone"><?php echo $entry_telephone; ?></label>
              <div class="col-xs-10">
                <input type="text" name="config_telephone" value="<?php echo $config_telephone; ?>" id="input-telephone" class="form-control" />
                <?php if ($error_telephone) { ?>
                <div class="text-danger"><?php echo $error_telephone; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-fax"><?php echo $entry_fax; ?></label>
              <div class="col-xs-10">
                <input type="text" name="config_fax" value="<?php echo $config_fax; ?>" id="input-fax" class="form-control" />
              </div>
            </div>
          </div>
          <div class="tab-pane" id="tab-store">
            <div class="form-group required">
              <label class="col-xs-2 control-label" for="input-title"><?php echo $entry_title; ?></label>
              <div class="col-xs-10">
                <?php foreach ($languages as $language) { ?>
    			<input id="input-title<?php print $language['language_id']; ?>" class="form-control" type="text" name="config_title[<?php echo $language['language_id']; ?>]" value="<?php  if (isset($config_title[$language['language_id']])) { echo $config_title[$language['language_id']]; } ?>" />
    			<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br>
    			<?php } ?>
                <?php if ($error_title) { ?>
                <div class="text-danger"><?php echo $error_title; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-meta-description"><?php echo $entry_meta_description; ?></label>
              <div class="col-xs-10">
                <?php foreach ($languages as $language) { ?>
    			<textarea name="config_meta_description[<?php echo $language['language_id']; ?>]" cols="40" rows="5" id="input-meta-description<?php print $language['language_id']; ?>" class="form-control"><?php if (isset($config_meta_description[$language['language_id']])) { echo $config_meta_description[$language['language_id']]; } ?></textarea>			
    			<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br>
    			<?php } ?>
              </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-meta-keywords">Meta Tag Keywords:</label>
              <div class="col-xs-10">
                <textarea name="config_meta_keywords" cols="40" id="input-meta-keywords" rows="3"  class="form-control"><?php echo $config_meta_keywords; ?></textarea>
              </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-template"><?php echo $entry_template; ?></label>
              <div class="col-xs-10">
                <select name="config_template" id="input-template" class="form-control">
                  <?php foreach ($templates as $template) { ?>
                  <?php if ($template == $config_template) { ?>
                  <option value="<?php echo $template; ?>" selected="selected"><?php echo $template; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $template; ?>"><?php echo $template; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
                <br />
		<div id="template" class="img-responsive"></div></div>


            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-layout"><?php echo $entry_layout; ?></label>
              <div class="col-xs-10">
                <select name="config_layout_id" id="input-layout" class="form-control">
                  <?php foreach ($layouts as $layout) { ?>
                  <?php if ($layout['layout_id'] == $config_layout_id) { ?>
                  <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
              </div>
            </div>
          </div>
          <div class="tab-pane" id="tab-local">
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-country"><?php echo $entry_country; ?></label>
              <div class="col-xs-10">
                <select name="config_country_id" id="input-country" class="form-control">
                  <?php foreach ($countries as $country) { ?>
                  <?php if ($country['country_id'] == $config_country_id) { ?>
                  <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-zone"><?php echo $entry_zone; ?></label>
              <div class="col-xs-10">
                <select name="config_zone_id" id="input-zone" class="form-control">
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-language"><?php echo $entry_language; ?></label>
              <div class="col-xs-10">
                <select name="config_language" id="input-language" class="form-control">
                  <?php foreach ($languages as $language) { ?>
                  <?php if ($language['code'] == $config_language) { ?>
                  <option value="<?php echo $language['code']; ?>" selected="selected"><?php echo $language['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $language['code']; ?>"><?php echo $language['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-currency"><?php echo $entry_currency; ?></label>
              <div class="col-xs-10">
                <select name="config_currency" id="input-currency" class="form-control">
                  <?php foreach ($currencies as $currency) { ?>
                  <?php if ($currency['code'] == $config_currency) { ?>
                  <option value="<?php echo $currency['code']; ?>" selected="selected"><?php echo $currency['title']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $currency['code']; ?>"><?php echo $currency['title']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
              </div>
            </div>
          </div>
          <div class="tab-pane" id="tab-option">
            <fieldset>
              <legend><i class="fa fa-plus-circle"></i> <?php echo $text_items; ?></legend>
              <div class="form-group required">
                <label class="col-xs-2 control-label" for="input-catalog-limit"><?php echo $entry_catalog_limit; ?></label>
                <div class="col-xs-10">
                  <input type="text" name="config_catalog_limit" value="<?php echo $config_catalog_limit; ?>" id="input-catalog-limit" class="form-control" />
                  
                  <?php if ($error_catalog_limit) { ?>
                  <div class="text-danger"><?php echo $error_catalog_limit; ?></div>
                  <?php } ?>
                </div>
              </div>

            </fieldset>
            <fieldset>
              <legend><i class="fa fa-plus-circle"></i> <?php echo $text_tax; ?></legend>
              <div class="form-group">
                <label class="col-xs-2 control-label"><?php echo $entry_tax; ?></label>
                <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($config_tax == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="config_tax" value="1" <?php if ($config_tax == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($config_tax == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="config_tax" value="0" <?php if ($config_tax == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-xs-2 control-label" for="input-tax-default"><?php echo $entry_tax_default; ?></label>
                <div class="col-xs-10">
                  <select name="config_tax_default" id="input-tax-default" class="form-control">
                    <option value=""><?php echo $text_none; ?></option>
                    <?php  if ($config_tax_default == 'shipping') { ?>
                    <option value="shipping" selected="selected"><?php echo $text_shipping; ?></option>
                    <?php } else { ?>
                    <option value="shipping"><?php echo $text_shipping; ?></option>
                    <?php } ?>
                    <?php  if ($config_tax_default == 'payment') { ?>
                    <option value="payment" selected="selected"><?php echo $text_payment; ?></option>
                    <?php } else { ?>
                    <option value="payment"><?php echo $text_payment; ?></option>
                    <?php } ?>
                  </select>
                   </div>
              </div>
              <div class="form-group">
                <label class="col-xs-2 control-label" for="input-tax-customer"><?php echo $entry_tax_customer; ?></label>
                <div class="col-xs-10">
                  <select name="config_tax_customer" id="input-tax-customer" class="form-control">
                    <option value=""><?php echo $text_none; ?></option>
                    <?php  if ($config_tax_customer == 'shipping') { ?>
                    <option value="shipping" selected="selected"><?php echo $text_shipping; ?></option>
                    <?php } else { ?>
                    <option value="shipping"><?php echo $text_shipping; ?></option>
                    <?php } ?>
                    <?php  if ($config_tax_customer == 'payment') { ?>
                    <option value="payment" selected="selected"><?php echo $text_payment; ?></option>
                    <?php } else { ?>
                    <option value="payment"><?php echo $text_payment; ?></option>
                    <?php } ?>
                  </select>
                   </div>
              </div>
            </fieldset>
            <fieldset>
              <legend><i class="fa fa-plus-circle"></i> <?php echo $text_account; ?></legend>
              <div class="form-group">
                <label class="col-xs-2 control-label" for="input-customer-group"><?php echo $entry_customer_group; ?></label>
                <div class="col-xs-10">
                  <select name="config_customer_group_id" id="input-customer-group" class="form-control">
                    <?php foreach ($customer_groups as $customer_group) { ?>
                    <?php if ($customer_group['customer_group_id'] == $config_customer_group_id) { ?>
                    <option value="<?php echo $customer_group['customer_group_id']; ?>" selected="selected"><?php echo $customer_group['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                   </div>
              </div>
              <div class="form-group">
                <label class="col-xs-2 control-label"><?php echo $entry_customer_group_display; ?></label>
                <div class="col-xs-10">
                  <?php foreach ($customer_groups as $customer_group) { ?>
                  <div class="checkbox">
                    <label>
                      <?php if (in_array($customer_group['customer_group_id'], $config_customer_group_display)) { ?>
                      <input type="checkbox" name="config_customer_group_display[]" value="<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
                      <?php echo $customer_group['name']; ?>
                      <?php } else { ?>
                      <input type="checkbox" name="config_customer_group_display[]" value="<?php echo $customer_group['customer_group_id']; ?>" />
                      <?php echo $customer_group['name']; ?>
                      <?php } ?>
                    </label>
                  </div>
                  <?php } ?>
                  
                  <?php if ($error_customer_group_display) { ?>
                  <div class="text-danger"><?php echo $error_customer_group_display; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group">
                <label class="col-xs-2 control-label"><?php echo $entry_customer_price; ?></label>
                <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($config_customer_price == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="config_customer_price" value="1" <?php if ($config_customer_price == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($config_customer_price == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="config_customer_price" value="0" <?php if ($config_customer_price == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
                   </div>
              </div>
              <div class="form-group">
                <label class="col-xs-2 control-label" for="input-account"><?php echo $entry_account; ?></label>
                <div class="col-xs-10">
                  <select name="config_account_id" id="input-account" class="form-control">
                    <option value="0"><?php echo $text_none; ?></option>
                    <?php foreach ($informations as $information) { ?>
                    <?php if ($information['information_id'] == $config_account_id) { ?>
                    <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                   </div>
              </div>
            </fieldset>
            <fieldset>
                <legend class="fa fa-plus-circle"><i>SMS</i></legend>
                <div class="form-group">
                <label class="col-xs-2 control-label"><?php echo $entry_config_sms_notifications; ?></label>
                <div class="col-xs-10">
                    <div class="btn-group" data-toggle="buttons">
                        <label class="btn btn-primary<?php if ($config_sms_notifications == 1) { ?> active<?php } ?>">
                            <i class="fa fa-check"></i> <input type="radio" name="config_sms_notifications" value="1" <?php if ($config_sms_notifications == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
                        </label>
                        <label class="btn btn-primary<?php if ($config_sms_notifications == 0) { ?> active<?php } ?>">
                            <i class="fa fa-times"></i> <input type="radio" name="config_sms_notifications" value="0" <?php if ($config_sms_notifications == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
                        </label>
                    </div>
                </div>
              </div>
              <div class="form-group">
                  <label class="col-xs-2 control-label">SMS Server login: </label>
                  <div class="col-xs-10">
                    <div class="row">
                      <div class="col-xs-6">
                        <input type="text" name="config_sms_notifications_login" value="<?php echo $config_sms_notifications_login; ?>" class="form-control" />
                      </div>
                    </div>
                  </div>
              </div>
              <div class="form-group">
                  <label class="col-xs-2 control-label">SMS Server password: </label>
                  <div class="col-xs-10">
                    <div class="row">
                      <div class="col-xs-6">
                        <input type="text" name="config_sms_notifications_password" value="<?php echo $config_sms_notifications_password; ?>" class="form-control" />
                      </div>
                    </div>
                  </div>
              </div>
              <div class="form-group">
                  <label class="col-xs-2 control-label">SMS Server sign: </label>
                  <div class="col-xs-10">
                    <div class="row">
                      <div class="col-xs-6">
                        <input type="text" name="config_sms_notifications_sign" value="<?php echo $config_sms_notifications_sign; ?>" class="form-control" />
                      </div>
                    </div>
                  </div>
              </div>
            </fieldset>
            <fieldset>
              <legend><i class="fa fa-plus-circle"></i> <?php echo $text_checkout; ?></legend>
              <div class="form-group">
                <label class="col-xs-2 control-label"><?php echo $entry_cart_weight; ?></label>
                <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($config_cart_weight == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="config_cart_weight" value="1" <?php if ($config_cart_weight == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($config_cart_weight == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="config_cart_weight" value="0" <?php if ($config_cart_weight == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-xs-2 control-label"><?php echo $entry_guest_checkout; ?></label>
                <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($config_guest_checkout == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="config_guest_checkout" value="1" <?php if ($config_guest_checkout == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($config_guest_checkout == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="config_guest_checkout" value="0" <?php if ($config_guest_checkout == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
                   </div>
              </div>
              <div class="form-group">
                <label class="col-xs-2 control-label" for="input-checkout"><?php echo $entry_checkout; ?></label>
                <div class="col-xs-10">
                  <select name="config_checkout_id" id="input-checkout" class="form-control">
                    <option value="0"><?php echo $text_none; ?></option>
                    <?php foreach ($informations as $information) { ?>
                    <?php if ($information['information_id'] == $config_checkout_id) { ?>
                    <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                   </div>
              </div>
              <div class="form-group">
                <label class="col-xs-2 control-label" for="input-order-status"><?php echo $entry_order_status; ?></label>
                <div class="col-xs-10">
                  <select name="config_order_status_id" id="input-order-status" class="form-control">
                    <?php foreach ($order_statuses as $order_status) { ?>
                    <?php if ($order_status['order_status_id'] == $config_order_status_id) { ?>
                    <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                   </div>
              </div>
            </fieldset>
            <fieldset>
              <legend><i class="fa fa-plus-circle"></i> <?php echo $text_stock; ?></legend>
              <div class="form-group">
                <label class="col-xs-2 control-label"><?php echo $entry_stock_display; ?></label>
                <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($config_stock_display == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="config_stock_display" value="1" <?php if ($config_stock_display == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($config_stock_display == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="config_stock_display" value="0" <?php if ($config_stock_display == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
                   </div>
              </div>
              <div class="form-group">
                <label class="col-xs-2 control-label"><?php echo $entry_stock_checkout; ?></label>
                <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($config_stock_checkout == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="config_stock_checkout" value="1" <?php if ($config_stock_checkout == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($config_stock_display == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="config_stock_checkout" value="0" <?php if ($config_stock_checkout == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
                   </div>
              </div>
            </fieldset>
          </div>
          <div class="tab-pane" id="tab-image">
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-logo"><?php echo $entry_logo; ?></label>
              <div class="col-xs-10"> <img src="<?php echo $logo; ?>" alt="" id="thumb-logo"/>
                <input type="hidden" name="config_logo" value="<?php echo $config_logo; ?>" id="logo"/>
                <br />
                <br />
                <div class="btn-group">
                  <button class="btn btn-info" title="<?php echo $text_browse; ?>" data-toggle="modal" data-target="#dialog" onclick="image_upload('logo', 'thumb-logo');"><span class="fa fa-pencil"></span> <?php echo $text_browse; ?></button>
                  <button onclick="$(this).parent().parent().find('img').attr('src', '<?php echo $no_image; ?>'); $(this).parent().parent().find('input').attr('value', ''); return false;" class="btn btn-danger"><span class="fa fa-trash-o"></span> <?php echo $text_clear; ?></button>
                </div>
              </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-icon"><?php echo $entry_icon; ?> </label>
              <div class="col-xs-10"><img src="<?php echo $icon; ?>" alt="" id="thumb-icon"/>
                <input type="hidden" name="config_icon" value="<?php echo $config_icon; ?>"  id="icon"/>
                <br />
                <br />
                <div class="btn-group">
		<button class="btn btn-info" title="<?php echo $text_browse; ?>" data-toggle="modal" data-target="#dialog" onclick="image_upload('icon', 'thumb-icon');"><span class="fa fa-pencil"></span> <?php echo $text_browse; ?></button>
                  <button onclick="$(this).parent().parent().find('img').attr('src', '<?php echo $no_image; ?>'); $(this).parent().parent().find('input').attr('value', ''); return false;" class="btn btn-danger"><span class="fa fa-trash-o"></span> <?php echo $text_clear; ?></button>
                </div>
              </div>
            </div>
            <div class="form-group required">
              <label class="col-xs-2 control-label" for="input-image-category-width"><?php echo $entry_image_category; ?></label>
              <div class="col-xs-10">
                <div class="row">
                  <div class="col-xs-6">
                    <input type="text" name="config_image_category_width" value="<?php echo $config_image_category_width; ?>" id="input-image-category-width" class="form-control" />
                  </div>
                  <div class="col-xs-6">
                    <input type="text" name="config_image_category_height" value="<?php echo $config_image_category_height; ?>" class="form-control" />
                  </div>
                </div>
                <?php if ($error_image_category) { ?>
                <div class="text-danger"><?php echo $error_image_category; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group required">
              <label class="col-xs-2 control-label" for="input-image-thumb-width"><?php echo $entry_image_thumb; ?></label>
              <div class="col-xs-10">
                <div class="row">
                  <div class="col-xs-6">
                    <input type="text" name="config_image_thumb_width" value="<?php echo $config_image_thumb_width; ?>" id="input-image-thumb-width" class="form-control" />
                  </div>
                  <div class="col-xs-6">
                    <input type="text" name="config_image_thumb_height" value="<?php echo $config_image_thumb_height; ?>" class="form-control" />
                  </div>
                </div>
                <?php if ($error_image_thumb) { ?>
                <div class="text-danger"><?php echo $error_image_thumb; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group required">
              <label class="col-xs-2 control-label" for="input-image-popup-width"><?php echo $entry_image_popup; ?></label>
              <div class="col-xs-10">
                <div class="row">
                  <div class="col-xs-6">
                    <input type="text" name="config_image_popup_width" value="<?php echo $config_image_popup_width; ?>" id="input-image-popup-width" class="form-control" />
                  </div>
                  <div class="col-xs-6">
                    <input type="text" name="config_image_popup_height" value="<?php echo $config_image_popup_height; ?>" class="form-control" />
                  </div>
                </div>
                <?php if ($error_image_popup) { ?>
                <div class="text-danger"><?php echo $error_image_popup; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group required">
              <label class="col-xs-2 control-label" for="input-image-product-width"><?php echo $entry_image_product; ?></label>
              <div class="col-xs-10">
                <div class="row">
                  <div class="col-xs-6">
                    <input type="text" name="config_image_product_width" value="<?php echo $config_image_product_width; ?>" id="input-image-product-width" class="form-control" />
                  </div>
                  <div class="col-xs-6">
                    <input type="text" name="config_image_product_height" value="<?php echo $config_image_product_height; ?>" class="form-control" />
                  </div>
                </div>
                <?php if ($error_image_product) { ?>
                <div class="text-danger"><?php echo $error_image_product; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group required">
              <label class="col-xs-2 control-label" for="input-image-additional-width"><?php echo $entry_image_additional; ?></label>
              <div class="col-xs-10">
                <div class="row">
                  <div class="col-xs-6">
                    <input type="text" name="config_image_additional_width" value="<?php echo $config_image_additional_width; ?>" id="input-image-additional-width" class="form-control" />
                  </div>
                  <div class="col-xs-6">
                    <input type="text" name="config_image_additional_height" value="<?php echo $config_image_additional_height; ?>" class="form-control" />
                  </div>
                </div>
                <?php if ($error_image_additional) { ?>
                <div class="text-danger"><?php echo $error_image_additional; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group required">
              <label class="col-xs-2 control-label" for="input-image-related-width"><?php echo $entry_image_related; ?></label>
              <div class="col-xs-10">
                <div class="row">
                  <div class="col-xs-6">
                    <input type="text" name="config_image_related_width" value="<?php echo $config_image_related_width; ?>" id="input-image-related-width" class="form-control" />
                  </div>
                  <div class="col-xs-6">
                    <input type="text" name="config_image_related_height" value="<?php echo $config_image_related_height; ?>" class="form-control" />
                  </div>
                </div>
                <?php if ($error_image_related) { ?>
                <div class="text-danger"><?php echo $error_image_related; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group required">
              <label class="col-xs-2 control-label" for="input-image-compare-width"><?php echo $entry_image_compare; ?></label>
              <div class="col-xs-10">
                <div class="row">
                  <div class="col-xs-6">
                    <input type="text" name="config_image_compare_width" value="<?php echo $config_image_compare_width; ?>" id="input-image-compare-width" class="form-control" />
                  </div>
                  <div class="col-xs-6">
                    <input type="text" name="config_image_compare_height" value="<?php echo $config_image_compare_height; ?>" class="form-control" />
                  </div>
                </div>
                <?php if ($error_image_compare) { ?>
                <div class="text-danger"><?php echo $error_image_compare; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group required">
              <label class="col-xs-2 control-label" for="input-image-wishlist-width"><?php echo $entry_image_wishlist; ?></label>
              <div class="col-xs-10">
                <div class="row">
                  <div class="col-xs-6">
                    <input type="text" name="config_image_wishlist_width" value="<?php echo $config_image_wishlist_width; ?>" id="input-image-wishlist-width" class="form-control" />
                  </div>
                  <div class="col-xs-6">
                    <input type="text" name="config_image_wishlist_height" value="<?php echo $config_image_wishlist_height; ?>" class="form-control" />
                  </div>
                </div>
                <?php if ($error_image_wishlist) { ?>
                <div class="text-danger"><?php echo $error_image_wishlist; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group required">
              <label class="col-xs-2 control-label" for="input-image-cart-width"><?php echo $entry_image_cart; ?></label>
              <div class="col-xs-10">
                <div class="row">
                  <div class="col-xs-6">
                    <input type="text" name="config_image_cart_width" value="<?php echo $config_image_cart_width; ?>" id="input-image-cart-width" class="form-control" />
                  </div>
                  <div class="col-xs-6">
                    <input type="text" name="config_image_cart_height" value="<?php echo $config_image_cart_height; ?>" class="form-control" />
                  </div>
                </div>
                <?php if ($error_image_cart) { ?>
                <div class="text-danger"><?php echo $error_image_cart; ?></div>
                <?php } ?>
              </div>
            </div>
          </div>
          <div class="tab-pane" id="tab-server">
            <div class="form-group">
              <label class="col-xs-2 control-label"><?php echo $entry_secure; ?></label>
              <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($config_secure == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="config_secure" value="1" <?php if ($config_secure == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($config_secure == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="config_secure" value="0" <?php if ($config_secure == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
                 </div>
            </div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('select[name=\'config_template\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=setting/setting/template&token=<?php echo $token; ?>&template=' + encodeURIComponent(this.value),
		dataType: 'html',
		beforeSend: function() {
			$('select[name=\'country_id\']').after(' <i class="fa fa-spinner fa-spin"></i>');
		},		
		complete: function() {
			$('.fa-spinner').remove();
		},			
		success: function(html) {
			$('#template').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('select[name=\'config_template\']').trigger('change');
//--></script> 
<script type="text/javascript"><!--
$('select[name=\'config_country_id\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=setting/store/country&token=<?php echo $token; ?>&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('select[name=\'config_country_id\']').after(' <i class="fa fa-spinner fa-spin"></i>');
		},		
		complete: function() {
			$('.fa-spinner').remove();
		},			
		success: function(json) {
			html = '<option value=""><?php echo $text_select; ?></option>';
			
			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
        			html += '<option value="' + json['zone'][i]['zone_id'] + '"';
	    			
					if (json['zone'][i]['zone_id'] == '<?php echo $config_zone_id; ?>') {
	      				html += ' selected="selected"';
	    			}
	
	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			
			$('select[name=\'config_zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('select[name=\'config_country_id\']').trigger('change');
//--></script> 

  <div class="modal fade" id="dialog" data-field="" data-thumb="">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4 class="modal-title"><?php echo $text_image_manager; ?></h4>
        </div>
        <div class="modal-body">
         <iframe id="fm-iframe" style="display:block; border:0; padding:0; margin:0; width:100%; height:360px; overflow:auto;"></iframe>
        </div>
        <div class="modal-footer">
	    <a href="#" id="dialog-confirm" class="btn btn-success hide"><i class="fa fa-thumbs-up"></i> Confirm</a>
	    <a href="#" class="btn btn-success" data-dismiss="modal" aria-hidden="true">Close</a>
        </div>
      </div>
    </div>
  </div>
<script>
function image_upload(field, thumb) {

	$('#dialog').attr('data-field', field);
	$('#dialog').attr('data-thumb', thumb);
	$('#dialog #fm-iframe').attr('src', 'index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field));
};

	$(document.body).on('show.bs.modal', '#dialog', function () {
		$(this).find('#dialog-confirm').addClass('hide');
	});

	$(document.body).on('hidden.bs.modal', '#dialog', function () {
		var field = $(this).attr('data-field');
		var thumb = $(this).attr('data-thumb');

		if ($('#' + field).attr('value')) {
			$.ajax({
				url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).val()),
				dataType: 'text',
				success: function(data) {
					$('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '">');
				}
			});
		}
		$('#dialog').attr('data-field', '');
		$('#dialog').attr('data-thumb', '');
		$('#dialog #fm-iframe').attr('src', '');
	});

</script>
<?php echo $footer; ?>