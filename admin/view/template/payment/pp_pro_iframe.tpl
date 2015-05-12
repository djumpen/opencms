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
        <button type="submit" form="form-pp-pro-iframe" class="btn btn-primary "><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
      <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    </div>

<div class="panel-body">
              
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-pp-pro-iframe">
<ul class="nav nav-tabs">
          <li class="active"><a href="#tab-settings" data-toggle="tab"><?php echo $tab_settings; ?></a></li>
	<li><a href="#tab-order-status" data-toggle="tab"><?php echo $tab_order_status; ?></a></li>
</ul>
          <div class="tab-content">

            <div class="tab-pane active" id="tab-settings">
            		<div class="table-responsive">
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <td><span class="required">*</span> <?php echo $entry_user; ?></td>
                        <td><input type="text" name="pp_pro_iframe_user" value="<?php echo $pp_pro_iframe_user; ?>" class="form-control" />
                            <?php if ($error_user) { ?>
                                <span class="error"><?php echo $error_user; ?></span>
                            <?php } ?>
                        </td>
                    </tr>
                    <tr>
                        <td><span class="required">*</span> <?php echo $entry_password; ?></td>
                        <td><input type="text" name="pp_pro_iframe_password" value="<?php echo $pp_pro_iframe_password; ?>" class="form-control" />
                            <?php if ($error_password) { ?>
                                <span class="error"><?php echo $error_password; ?></span>
                            <?php } ?>
                        </td>
                    </tr>
                    <tr>
                        <td><span class="required">*</span> <?php echo $entry_sig; ?></td>
                        <td><input type="text" name="pp_pro_iframe_sig" value="<?php echo $pp_pro_iframe_sig; ?>" class="form-control"/>
                            <?php if ($error_sig) { ?>
                                <span class="error"><?php echo $error_sig; ?></span>
                            <?php } ?>
                        </td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_transaction_method; ?></td>
                        <td>
                            <select name="pp_pro_iframe_transaction_method" class="form-control">
                                <?php if ($pp_pro_iframe_transaction_method == 'authorization') { ?>
                                    <option value="sale"><?php echo $text_sale; ?></option>
                                    <option value="authorization" selected="selected"><?php echo $text_authorization; ?></option>
                                <?php } else { ?>
                                    <option value="sale" selected="selected"><?php echo $text_sale; ?></option>
                                    <option value="authorization"><?php echo $text_authorization; ?></option>
                                <?php } ?>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_test; ?></td>
                        <td>
                            <?php if ($pp_pro_iframe_test) { ?>
                                <input type="radio" name="pp_pro_iframe_test" value="1" checked="checked" />
                                <?php echo $text_yes; ?>
                                <input type="radio" name="pp_pro_iframe_test" value="0" />
                                <?php echo $text_no; ?>
                            <?php } else { ?>
                                <input type="radio" name="pp_pro_iframe_test" value="1" />
                                <?php echo $text_yes; ?>
                                <input type="radio" name="pp_pro_iframe_test" value="0" checked="checked" />
                                <?php echo $text_no; ?>
                            <?php } ?>
                        </td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_debug; ?><br /><span class="help"><?php echo $help_debug ?></span></td>
                        <td>
                            <select name="pp_pro_iframe_debug" class="form-control">
                                <?php if ($pp_pro_iframe_debug) { ?>
                                    <option value="1" selected="selected"><?php echo $text_yes ?></option>
                                    <option value="0"><?php echo $text_no ?></option>
                                <?php } else { ?>
                                    <option value="1"><?php echo $text_yes ?></option>
                                    <option value="0" selected="selected"><?php echo $text_no ?></option>
                                <?php } ?>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_checkout_method ?><br /><span class="help"><?php echo $help_checkout_method ?></span></td>
                        <td>
                            <select name="pp_pro_iframe_checkout_method" class="form-control">
                                <?php if ($pp_pro_iframe_checkout_method == 'iframe'): ?>
                                
                                <option value="iframe" selected="selected"><?php echo $text_iframe ?></option>
                                <option value="redirect"><?php echo $text_redirect ?></option>
                                
                                <?php else: ?>
                                
                                <option value="iframe"><?php echo $text_iframe ?></option>
                                <option value="redirect" selected="selected"><?php echo $text_redirect ?></option>
                                
                                <?php endif; ?>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_total; ?></td>
                        <td><input type="text" name="pp_pro_iframe_total" value="<?php echo $pp_pro_iframe_total; ?>" /></td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_geo_zone; ?></td>
                        <td>
                            <select name="pp_pro_iframe_geo_zone_id" class="form-control">
                                <option value="0"><?php echo $text_all_zones; ?></option>
                                <?php foreach ($geo_zones as $geo_zone) { ?>
                                    <?php if ($geo_zone['geo_zone_id'] == $pp_pro_iframe_geo_zone_id) { ?>
                                        <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
                                    <?php } else { ?>
                                        <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_status; ?></td>
                        <td>
                            <select name="pp_pro_iframe_status" class="form-control">
                                <?php if ($pp_pro_iframe_status) { ?>
                                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                    <option value="0"><?php echo $text_disabled; ?></option>
                                <?php } else { ?>
                                    <option value="1"><?php echo $text_enabled; ?></option>
                                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                <?php } ?>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_sort_order; ?></td>
                        <td><input type="text" name="pp_pro_iframe_sort_order" value="<?php echo $pp_pro_iframe_sort_order; ?>" class="form-control" /></td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_ipn_url; ?></td>
                        <td><?php echo $ipn_url ?></td>
                    </tr>
                </table>
		</div>
            </div>
            <div class="tab-pane" id="tab-order-status">
		<div class="table-responsive">
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <td><?php echo $entry_canceled_reversal_status; ?></td>
                        <td>
                            <select name="pp_pro_iframe_canceled_reversal_status_id" class="form-control">
                                <?php foreach ($order_statuses as $order_status) { ?>
                                    <?php if ($order_status['order_status_id'] == $pp_pro_iframe_canceled_reversal_status_id) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                    <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_completed_status; ?></td>
                        <td>
                            <select name="pp_pro_iframe_completed_status_id" class="form-control">
                                <?php foreach ($order_statuses as $order_status) { ?>
                                    <?php if ($order_status['order_status_id'] == $pp_pro_iframe_completed_status_id) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                    <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_denied_status; ?></td>
                        <td>
                            <select name="pp_pro_iframe_denied_status_id" class="form-control">
                                <?php foreach ($order_statuses as $order_status) { ?>
                                    <?php if ($order_status['order_status_id'] == $pp_pro_iframe_denied_status_id) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                    <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_expired_status; ?></td>
                        <td>
                            <select name="pp_pro_iframe_expired_status_id" class="form-control">
                                <?php foreach ($order_statuses as $order_status) { ?>
                                    <?php if ($order_status['order_status_id'] == $pp_pro_iframe_expired_status_id) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                    <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_failed_status; ?></td>
                        <td>
                            <select name="pp_pro_iframe_failed_status_id" class="form-control">
                                <?php foreach ($order_statuses as $order_status) { ?>
                                    <?php if ($order_status['order_status_id'] == $pp_pro_iframe_failed_status_id) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                    <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_pending_status; ?></td>
                        <td>
                            <select name="pp_pro_iframe_pending_status_id" class="form-control">
                                <?php foreach ($order_statuses as $order_status) { ?>
                                    <?php if ($order_status['order_status_id'] == $pp_pro_iframe_pending_status_id) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                    <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_processed_status; ?></td>
                        <td>
                            <select name="pp_pro_iframe_processed_status_id" class="form-control">
                                <?php foreach ($order_statuses as $order_status) { ?>
                                    <?php if ($order_status['order_status_id'] == $pp_pro_iframe_processed_status_id) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                    <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_refunded_status; ?></td>
                        <td>
                            <select name="pp_pro_iframe_refunded_status_id" class="form-control">
                                <?php foreach ($order_statuses as $order_status) { ?>
                                    <?php if ($order_status['order_status_id'] == $pp_pro_iframe_refunded_status_id) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                    <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_reversed_status; ?></td>
                        <td>
                            <select name="pp_pro_iframe_reversed_status_id" class="form-control">
                                <?php foreach ($order_statuses as $order_status) { ?>
                                    <?php if ($order_status['order_status_id'] == $pp_pro_iframe_reversed_status_id) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                    <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_voided_status; ?></td>
                        <td>
                            <select name="pp_pro_iframe_voided_status_id" class="form-control">
                                <?php foreach ($order_statuses as $order_status) { ?>
                                    <?php if ($order_status['order_status_id'] == $pp_pro_iframe_voided_status_id) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                    <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        </td>
                    </tr>
                </table>
		</div>
            </div>
        </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
    $('#htabs a').tabs();
//--></script>
<?php echo $footer; ?>