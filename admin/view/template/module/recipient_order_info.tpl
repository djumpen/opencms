<?php foreach ($orders as $order) { ?>

<div class="well">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-order-id"><?php echo $text_date_added; ?></label>
              <div class="col-xs-10"><p class="form-control-static"><?php echo $order['date_added']; ?></p></div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-order-id"><?php echo $text_order_id; ?></label>
              <div class="col-xs-10"><p class="form-control-static"><?php echo $order['order_id']; ?> <?php if ($order['invoice_no']) { ?><span class="label label-info"><?php echo $text_invoice_no; ?> <?php echo $order['invoice_no']; ?></span><?php } ?></p></div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-order-id"><?php echo $text_payment_method; ?></label>
              <div class="col-xs-10"><p class="form-control-static"><?php echo $order['payment_method']; ?></p></div>
            </div>
          <?php if ($order['shipping_method']) { ?>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-order-id"><?php echo $text_shipping_method; ?></label>
              <div class="col-xs-10"><p class="form-control-static"><?php echo $order['shipping_method']; ?></p></div>
            </div>
          <?php } ?>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-order-id"><?php echo $text_to; ?></label>
              <div class="col-xs-10"><p class="form-control-static"><?php echo $order['payment_address']; ?> <span class="label label-info"><?php echo $order['telephone']; ?></span>         <?php if ($order['payment_company_id']) { ?>
        <?php echo $text_company_id; ?> <?php echo $order['payment_company_id']; ?>
        <?php } ?>
        <?php if ($order['payment_tax_id']) { ?>
        <?php echo $text_tax_id; ?> <?php echo $order['payment_tax_id']; ?>
        <?php } ?></p></div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-order-id"><?php echo $text_ship_to; ?></label>
              <div class="col-xs-10"><p class="form-control-static"><?php echo $order['shipping_address']; ?></p></div>
            </div>
	<?php foreach ($order['product'] as $product) { ?>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-order-id"><?php echo $column_product; ?></label>
              <div class="col-xs-10">
			<p class="form-control-static"><?php echo $product['name']; ?><?php foreach ($product['option'] as $option) { ?><br /><small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small><?php } ?></p>
			<p class="form-control-static"><?php echo $column_model; ?> <?php echo $product['model']; ?></p><p class="form-control-static"><?php echo $column_quantity; ?> <?php echo $product['quantity']; ?></p>
	    		<?php foreach ($order['voucher'] as $voucher) { ?>
				<p class="form-control-static"><?php echo $voucher['description']; ?> <?php echo $voucher['amount']; ?></p>
			<?php } ?>
		</div>
            </div>
	<?php } ?>
	<?php if ($order['comment']) { ?>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-order-id"><?php echo $column_comment; ?></label>
              <div class="col-xs-10"><p class="form-control-static"><?php echo $order['comment']; ?></p></div>
            </div>
  	<?php } ?>

	<?php if ($order['current_order_status']) { ?>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-order-id"><?php echo $column_status; ?></label>
              <div class="col-xs-10"><p class="form-control-static"><span class="label label-warning"><?php echo $order['current_order_status']; ?></span></p></div>
            </div>
  	<?php } ?>

</div><!-- alert info -->

<?php } ?>
