<?php echo $header; ?>
<div id="content" class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php foreach($errors as $error): ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php endforeach; ?>
  <div class="panel panel-default">
    <div class="panel-heading">
      <div class="pull-right">
        <button type="submit" form="form-amazon-checkout" class="btn btn-primary "><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
      <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    </div>


    <div class="panel-body">
      <form action="" method="POST" enctype="multipart/form-data" class="form-horizontal" id="form-amazon-checkout">
	<div class="well"><?php echo $text_amazon_join ?></div>

	<div class="form-group required">
          <label class="col-xs-2 control-label" for="amazon_checkout_access_id"><?php echo $text_merchant_id ?></label>
          <div class="col-xs-10">
            <input type="text" name="amazon_checkout_merchant_id" value="<?php echo $amazon_checkout_merchant_id ?>" id="amazon_checkout_merchant_id" class="form-control" required />
          </div>
        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="amazon_checkout_access_key"><?php echo $text_access_key ?></label>
          <div class="col-xs-10">
            <input type="text" name="amazon_checkout_access_key" value="<?php echo $amazon_checkout_access_key ?>" id="amazon_checkout_access_key" class="form-control" required />
          </div>
        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="amazon_checkout_access_secret"><?php echo $text_access_secret ?></label>
          <div class="col-xs-10">
            <input type="text" name="amazon_checkout_access_secret" value="<?php echo $amazon_checkout_access_secret ?>" id="amazon_checkout_access_secret" class="form-control" required />
          </div>
        </div>

	<div class="form-group required">
          <label class="col-xs-2 control-label" for="amazon_checkout_status"><?php echo $text_status ?></label>
          <div class="col-xs-10">
                <select name="amazon_checkout_status" id="amazon_checkout_status" class="form-control">
                <?php if ($amazon_checkout_status == 1): ?>
                  <option value="1" selected="selected"><?php echo $text_status_enabled ?></option>
                <?php else: ?>
                  <option value="1"><?php echo $text_status_enabled ?></option>
                <?php endif; ?>
                <?php if ($amazon_checkout_status == 0): ?>
                  <option value="0" selected="selected"><?php echo $text_status_disabled ?></option>
                <?php else: ?>
                  <option value="0"><?php echo $text_status_disabled ?></option>
                <?php endif; ?>
              </select>
          </div>
        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="amazon_checkout_mode"><?php echo $text_checkout_mode ?></label>
          <div class="col-xs-10">
                <select name="amazon_checkout_mode" id="amazon_checkout_mode" class="form-control">
                <?php if ($amazon_checkout_mode == 'sandbox'): ?>
                  <option value="sandbox" selected="selected"><?php echo $text_sandbox ?></option>
                <?php else: ?>
                  <option value="sandbox"><?php echo $text_sandbox ?></option>
                <?php endif; ?>
                <?php if ($amazon_checkout_mode == 'live'): ?>
                  <option value="live" selected="selected"><?php echo $text_live ?></option>
                <?php else: ?>
                  <option value="live"><?php echo $text_live ?></option>
                <?php endif; ?>
              </select>
          </div>
        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="amazon_checkout_marketplace"><?php echo $text_marketplace ?></label>
          <div class="col-xs-10">
              <select name="amazon_checkout_marketplace" id="amazon_checkout_marketplace" class="form-control">
                <?php if ($amazon_checkout_marketplace == 'uk'): ?>
                  <option value="uk" selected="selected"><?php echo $text_uk ?></option>
                <?php else: ?>
                  <option value="uk"><?php echo $text_uk ?></option>
                <?php endif; ?>
                <?php if ($amazon_checkout_marketplace == 'de'): ?>
                  <option value="de" selected="selected"><?php echo $text_germany ?></option>
                <?php else: ?>
                  <option value="de"><?php echo $text_germany ?></option>
                <?php endif; ?>
              </select>
          </div>
        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="amazon_checkout_geo_zone"><?php echo $text_geo_zone ?></label>
          <div class="col-xs-10">
              <select name="amazon_checkout_geo_zone" id="amazon_checkout_geo_zone" class="form-control">
                <?php if ($amazon_checkout_geo_zone == 0): ?>
                  <option value="0" selected="selected"><?php echo $text_all_geo_zones ?></option>
                <?php else: ?>
                  <option value="0"><?php echo $text_all_geo_zones ?></option>
                <?php endif; ?>
      
                <?php foreach ($geo_zones as $geo_zone): ?>
                  <?php if ($amazon_checkout_geo_zone == $geo_zone['geo_zone_id']): ?>
                    <option value="<?php echo $geo_zone['geo_zone_id'] ?>" selected="selected"><?php echo $geo_zone['name'] ?></option>
                  <?php else: ?>
                    <option value="<?php echo $geo_zone['geo_zone_id'] ?>"><?php echo $geo_zone['name'] ?></option>
                  <?php endif; ?>
                <?php endforeach; ?>
              </select>
          </div>
        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="amazon_checkout_order_default_status"><?php echo $text_default_order_status ?></label>
          <div class="col-xs-10">
              <select id="amazon_checkout_order_default_status" name="amazon_checkout_order_default_status" class="form-control">
                <?php foreach($order_statuses as $order_status): ?>
                  <?php if ($order_status['order_status_id'] == $amazon_checkout_order_default_status): ?>
                    <option value="<?php echo $order_status['order_status_id'] ?>" selected="selected"><?php echo $order_status['name'] ?></option>
                  <?php else: ?>
                    <option value="<?php echo $order_status['order_status_id'] ?>"><?php echo $order_status['name'] ?></option>
                  <?php endif; ?>
                <?php endforeach;?>
              </select>
          </div>
        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="amazon_checkout_order_ready_status"><?php echo $text_ready_order_status ?></label>
          <div class="col-xs-10">
              <select id="amazon_checkout_order_ready_status" name="amazon_checkout_order_ready_status" class="form-control">
                <?php foreach($order_statuses as $order_status): ?>
                  <?php if ($order_status['order_status_id'] == $amazon_checkout_order_ready_status): ?>
                    <option value="<?php echo $order_status['order_status_id'] ?>" selected="selected"><?php echo $order_status['name'] ?></option>
                  <?php else: ?>
                    <option value="<?php echo $order_status['order_status_id'] ?>"><?php echo $order_status['name'] ?></option>
                  <?php endif; ?>
                <?php endforeach;?>
              </select>
          </div>
        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="amazon_checkout_order_shipped_status"><?php echo $text_shipped_order_status ?></label>
          <div class="col-xs-10">
              <select id="amazon_checkout_order_shipped_status" name="amazon_checkout_order_shipped_status" class="form-control">
                <?php foreach($order_statuses as $order_status): ?>
                  <?php if ($order_status['order_status_id'] == $amazon_checkout_order_shipped_status): ?>
                    <option value="<?php echo $order_status['order_status_id'] ?>" selected="selected"><?php echo $order_status['name'] ?></option>
                  <?php else: ?>
                    <option value="<?php echo $order_status['order_status_id'] ?>"><?php echo $order_status['name'] ?></option>
                  <?php endif; ?>
                <?php endforeach;?>
              </select>
             </div>
        </div>
	<div class="form-group">
          <label class="col-xs-2 control-label" for="amazon_checkout_order_canceled_status"><?php echo $text_canceled_order_status ?></label>
          <div class="col-xs-10">
                <select id="amazon_checkout_order_canceled_status" name="amazon_checkout_order_canceled_status" class="form-control">
                  <?php foreach($order_statuses as $order_status): ?>
                    <?php if ($order_status['order_status_id'] == $amazon_checkout_order_canceled_status): ?>
                      <option value="<?php echo $order_status['order_status_id'] ?>" selected="selected"><?php echo $order_status['name'] ?></option>
                    <?php else: ?>
                      <option value="<?php echo $order_status['order_status_id'] ?>"><?php echo $order_status['name'] ?></option>
                    <?php endif; ?>
                  <?php endforeach;?>
                </select>
             </div>
        </div>
	<div class="form-group">
          <label class="col-xs-2 control-label" for="amazon_checkout_minimum_total"><?php echo $text_minimum_total ?></label>
          <div class="col-xs-10">
            <input name="amazon_checkout_minimum_total" value="<?php echo $amazon_checkout_minimum_total ?>" id="amazon_checkout_minimum_total" class="form-control" />
          </div>
         </div>
	<div class="form-group">
          <label class="col-xs-2 control-label" for="amazon_checkout_sort_order"><?php echo $text_sort_order ?></label>
          <div class="col-xs-10">
            <input name="amazon_checkout_sort_order" value="<?php echo $amazon_checkout_sort_order ?>" id="amazon_checkout_sort_order" class="form-control" />
          </div>
         </div>
	<div class="form-group">
          <label class="col-xs-2 control-label" for="amazon_checkout_cron_job_token"><?php echo $text_cron_job_token ?></label>
          <div class="col-xs-10">
            <input name="amazon_checkout_cron_job_token" value="<?php echo $amazon_checkout_cron_job_token ?>" id="amazon_checkout_cron_job_token" class="form-control" />
          	<span class="help-block"><?php echo $help_cron_job_token ?></span>
          </div>
         </div>
	<div class="form-group">
          <label class="col-xs-2 control-label" for="cron-job-url"><?php echo $text_cron_job_url ?></label>
          <div class="col-xs-10">
		<input name="cron-job-url" value="<?php echo $cron_job_url ?>" id="cron-job-url" class="form-control"/>
            <span class="help-block"><?php echo $help_cron_job_url ?></span>
	 </div>
	</div>
	<div class="form-group">
          <label class="col-xs-2 control-label" for="last_cron-job-url"><?php echo $text_last_cron_job_run ?></label>
          <div class="col-xs-10">
		<input name="last_cron-job-url" value="<?php echo $last_cron_job_run ?>" id="last_cron-job-url" class="form-control" />
          </div>
        </div>
	<div class="form-group">
          <label class="col-xs-2 control-label" for="allowed-ip"><?php echo $text_allowed_ips ?></label>
          <div class="col-xs-10"><div class="input-group">
                 <input type="text" name="allowed-ip" class="form-control"/><span class="input-group-btn">
<a class="btn btn-primary" id="add-ip"><?php echo $text_add ?></a></span></div>
		<span class="help-block"><?php echo $help_allowed_ips ?></span>
              </div>
          </div>
	<div class="form-group">
          <label class="col-xs-2 scrollbox control-label" for="allowed-ip"></label>
          <div class="col-xs-10">
                      <?php $class = 'odd' ?>
                      <?php $count = 0 ?>
                      <?php foreach ($amazon_checkout_allowed_ips as $ip): ?>
                      <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                          <div id="allowed-ip<?php echo $count++ ?>" class="col-xs-10 <?php echo $class ?>"><?php echo $ip ?> <img src="view/image/delete.png" alt="" />
                          <input type="hidden" name="amazon_checkout_allowed_ips[]" value="<?php echo $ip ?>" />
                          </div>
                      <?php endforeach; ?>
            </div>
            </div>
         
    <div class="panel-heading">
      <h2 class="panel-title"><i class="fa fa-edit"></i> <?php echo $text_button_settings ?></h2>
	</div>

	<div class="form-group">
          <label class="col-xs-2 control-label" for="amazon_checkout_button_colour"><?php echo $text_colour ?></label>
          <div class="col-xs-10">
              <select name="amazon_checkout_button_colour" id="amazon_checkout_button_colour" class="form-control">
                <?php foreach($button_colours as $value => $text): ?>
                  <?php if($value == $amazon_checkout_button_colour): ?>
                    <option selected="selected" value="<?php echo $value ?>"><?php echo $text ?></option>
                  <?php else: ?>
                    <option value="<?php echo $value ?>"><?php echo $text ?></option>
                  <?php endif; ?>
                <?php endforeach; ?>
              </select>
            </div>
          </div>
	<div class="form-group">
          <label class="col-xs-2 control-label" for="amazon_checkout_button_background"><?php echo $text_background ?></label>
          <div class="col-xs-10">
              <select name="amazon_checkout_button_background" id="amazon_checkout_button_background" class="form-control">
                <?php foreach($button_backgrounds as $value => $text): ?>
                  <?php if($value == $amazon_checkout_button_background): ?>
                    <option selected="selected" value="<?php echo $value ?>"><?php echo $text ?></option>
                  <?php else: ?>
                    <option value="<?php echo $value ?>"><?php echo $text ?></option>
                  <?php endif; ?>
                <?php endforeach; ?>
              </select>
            </div>
          </div>
	<div class="form-group">
          <label class="col-xs-2 control-label" for="amazon_checkout_button_size"><?php echo $text_size ?></label>
          <div class="col-xs-10">
              <select name="amazon_checkout_button_size" id="amazon_checkout_button_size" class="form-control">
                <?php foreach($button_sizes as $value => $text): ?>
                  <?php if($value == $amazon_checkout_button_size): ?>
                    <option selected="selected" value="<?php echo $value ?>"><?php echo $text ?></option>
                  <?php else: ?>
                    <option value="<?php echo $value ?>"><?php echo $text ?></option>
                  <?php endif; ?>
                <?php endforeach; ?>
              </select>
            </div>
          </div>

      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
    
var count = <?php echo $count ?>;
    
$('#add-ip').click(function(){
    var ip = $.trim($('input[name="allowed-ip"]').val());
    $('input[name="allowed-ip"]').val('');
    
    if (ip != '') {
        var html = '';
        html += '<div id="allowed-ip' + count++ + '" class="<?php echo $class ?>">' + ip;
        html += '<img src="view/image/delete.png" alt="" />';
        html += '<input type="hidden" name="amazon_checkout_allowed_ips[]" value="' + ip + '" />';
        html += '</div>';

        $('#allowed-ips').append(html);

        $('#allowed-ips div:odd').attr('class', 'odd');
        $('#allowed-ips div:even').attr('class', 'even');
    }
});

$('#allowed-ips img').click(function(){
    $(this).parent().remove();
    
    $('#allowed-ips div:odd').attr('class', 'odd');
	$('#allowed-ips div:even').attr('class', 'even');
});

$('input[name="amazon_checkout_cron_job_token"]').keyup(function(){
    $('#cron-job-url').html('<?php echo HTTPS_CATALOG ?>index.php?route=payment/amazon_checkout/cron&token=' + $(this).val());
});

//--></script>
<?php echo $footer; ?> 