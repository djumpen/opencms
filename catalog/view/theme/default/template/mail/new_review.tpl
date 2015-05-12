<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body style="font-family: Arial, Helvetica, sans-serif; font-size: 12px; color: #000000;">
<div style="width: 680px;">
  <div style="float: right; margin-left: 20px;"><img src="<?php echo $image; ?>" alt="<?php echo $store_name; ?>" style="margin-bottom: 20px; border: none;" /></div>
  <div>
    <p style="margin-top: 0px; margin-bottom: 20px;"><?php echo $text_from; ?></p>
    <p style="margin-top: 0px; margin-bottom: 20px;"><b><?php echo $text_review; ?></b></p>
    <?php if ($review1) { ?>
    <p style="margin-top: 0px; margin-bottom: 20px;"><b>Достоинства:</b> <?php echo $review1; ?></p>
    <?php } ?>
    <?php if ($review2) { ?>
	<p style="margin-top: 0px; margin-bottom: 20px;"><b>Недостатки:</b> <?php echo $review2; ?></p>
    <?php } ?>
	<p style="margin-top: 0px; margin-bottom: 20px;"><b>Комментарий:</b> <?php echo $review; ?></p>
    <p style="margin-top: 0px; margin-bottom: 20px;"><b><?php echo $text_approve; ?></b><a href="<?php echo $approve_url; ?>" title="<?php echo $store_name; ?>"><?php echo $approve_url; ?></a>.</p>
  </div>
</div>
</body>
</html>