<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-ok-sign"></i> <?php echo $success; ?></div>
  <?php } ?>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $cols = 6; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $cols = 9; ?>
    <?php } else { ?>
    <?php $cols = 12; ?>
    <?php } ?>
    <div id="content" class="col-xs-<?php echo $cols; ?>"><?php echo $content_top; ?>
      <h2><?php echo $text_my_account; ?></h2>
      <div class="row account">
        <div class="col-xs-3"><a href="<?php echo $edit; ?>"><i class="fa fa-pencil-square-o"></i><br/><?php echo $text_edit; ?></a></div>
        <div class="col-xs-3"><a href="<?php echo $password; ?>"><i class="fa fa-unlock"></i><br/><?php echo $text_password; ?></a></div>
         <div class="col-xs-3"><a href="<?php echo $address; ?>"><i class="fa fa-home"></i><br/><?php echo $text_address; ?></a></div>
         <div class="col-xs-3"><a href="<?php echo $wishlist; ?>"><i class="fa fa-check-square-o"></i><br/><?php echo $text_wishlist; ?></a></div>
      </div>
      <h2><?php echo $text_my_orders; ?></h2>
     <div class="row account">
        <div class="col-xs-3"><a href="<?php echo $order; ?>"><i class="fa fa-dropbox"></i><br/><?php echo $text_order; ?></a></div>
        <div class="col-xs-3"><a href="<?php echo $download; ?>"><i class="fa fa-download"></i><br/><?php echo $text_download; ?></a></div>
        <?php if ($reward) { ?>
        <div class="col-xs-3"><a href="<?php echo $reward; ?>"><i class="fa fa-heart"></i><br/><?php echo $text_reward; ?></a></div>
        <?php } ?>
        <div class="col-xs-3"><a href="<?php echo $return; ?>"><i class="fa fa-refresh"></i><br/><?php echo $text_return; ?></a></div>
        <div class="col-xs-3"><a href="<?php echo $transaction; ?>"><i class="fa fa-money"></i><br/><?php echo $text_transaction; ?></a></div>
     </div>
      <h2><?php echo $text_my_newsletter; ?></h2>
      <div class=" row account"">
        <div class="col-xs-3"><a href="<?php echo $newsletter; ?>"><i class="fa fa-envelope-o"></i><br/><?php echo $text_newsletter; ?></a></div>
      </div>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?> 