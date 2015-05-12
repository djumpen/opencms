<?php
/**
 * Liqpay Payment Module
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
 *
 * @category        Liqpay
 * @package         Payment
 * @version         0.0.1
 * @author          Liqpay
 * @copyright       Copyright (c) 2014 Liqpay
 * @license         http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 *
 * EXTENSION INFORMATION
 *
 * OpenCart         1.5.6
 * LiqPay API       https://www.liqpay.com/ru/doc
 *
 */
?>

<?=$header?>
<div id="content" class="container">
    <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
    </ul>

    <?php if ($error_warning): ?><div class="warning"><?=$error_warning?></div><?php endif ?>

    <div class="panel panel-default">
        <div class="panel-heading">
            <div class="pull-right">
                <a onclick="$('#form').submit();" class="btn btn-primary "><?=$button_save?></a>
                <a href="<?=$cancel?>" class="btn btn-danger "><?=$button_cancel?></a>
            </div>
            <h1 class="panel-title"><img src="view/image/payment.png" alt="" /> <?=$heading_title?></h1>
        </div>
        <div class="panel-body">
            <form action="<?=$action?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
                <div class="form-group required">
                    <label class="col-xs-2 control-label" for="liqpay_public_key"><?=$entry_public_key?></label>
                    <div class="col-xs-10">
                        <input type="text" name="liqpay_public_key" value="<?=$liqpay_public_key?>" class="form-control">
                        <?php if ($error_public_key):?><span class="error"><?=$error_public_key?></span><?php endif?>
                    </div>
                </div>
                <div class="form-group required">
                    <label class="col-xs-2 control-label" for="liqpay_private_key"><?=$entry_private_key?></label>
                    <div class="col-xs-10">
                        <input type="text" name="liqpay_private_key" value="<?=$liqpay_private_key?>" class="form-control">
                        <?php if ($error_private_key):?><span class="error"><?=$error_private_key?></span><?php endif?>
                    </div>
                </div>
                <div class="form-group required">
                    <label class="col-xs-2 control-label" for="liqpay_action"><?=$entry_action?></label>
                    <div class="col-xs-10">
                        <input type="text" name="liqpay_action" value="<?=$liqpay_action?>" class="form-control">
                        <?php if ($error_action):?><span class="error"><?=$error_action?></span><?php endif?>
                    </div>
                </div>
                <div class="form-group required">
                    <label class="col-xs-2 control-label" for="liqpay_action"><?=$entry_total?></label>
                    <div class="col-xs-10">
                        <input type="text" name="liqpay_total" value="<?=$liqpay_total?>" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label" for="liqpay_order_status_id"><?=$entry_order_status?></label>
                    <div class="col-xs-10">
                        <select name="liqpay_order_status_id" class="form-control">
                                    <?php
                                        foreach ($order_statuses as $order_status):
                                            $order_status_id = $order_status['order_status_id'];
                                            $sel = ($order_status_id == $liqpay_order_status_id);
                                    ?>
                                        <option <?php if ($sel):?>selected="selected"<?php endif?> value="<?=$order_status_id?>">
                                            <?=$order_status['name']?>
                                        </option>
                                    <?php endforeach?>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label" for="liqpay_geo_zone_id"><?=$entry_geo_zone?></label>
                    <div class="col-xs-10">
                        <select name="liqpay_geo_zone_id" class="form-control">
                                <option value="0"><?=$text_all_zones?></option>
                                <?php
                                    foreach ($geo_zones as $geo_zone):
                                        $geo_zone_id = $geo_zone['geo_zone_id'];
                                        $sel = ($geo_zone_id == $liqpay_geo_zone_id);
                                ?>
                                    <option <?php if ($sel):?>selected="selected"<?php endif?> value="<?=$geo_zone_id?>">
                                        <?=$geo_zone['name']?>
                                    </option>
                                <?php endforeach?>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label" for="input-status"><?=$entry_status?></label>
                    <div class="col-xs-10">
                        <div class="btn-group" data-toggle="buttons">
                            <label class="btn btn-primary <?php if ($liqpay_status): ?>active<?php endif?>">
                            <i class="fa fa-check"></i> <input type="radio" name="liqpay_status" value="1" id="input-status" <?php if ($liqpay_status): ?>selected="selected"<?php endif?>><?=$text_enabled?></label>
                            <label class="btn btn-primary <?php if (!$liqpay_status): ?>active<?php endif?>">
                            <i class="fa fa-times"></i> <input type="radio" name="liqpay_status" value="0" id="input-status" <?php if (!$liqpay_status): ?>selected="selected"<?php endif?>><?=$text_disabled?></label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label" for="liqpay_sort_order">Порядок сортировки:</label>
                    <div class="col-xs-10">
                        <input type="text" name="liqpay_sort_order" value="<?=$liqpay_sort_order?>" id="liqpay_sort_order" class="form-control">
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<?=$footer?>