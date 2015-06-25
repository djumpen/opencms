<!DOCTYPE html>
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>"><!--<![endif]-->
<head>
	<meta charset="UTF-8" />
	<meta name="format-detection" content="telephone=no">
	<meta name="viewport" content="width=1024">
	<title><?php print $this->document->getTitle(); ?></title>
	<base href="<?php echo $base; ?>" />
	<?php if ($description) { ?>
	    <meta name="description" content="<?php echo $description; ?>" />
	<?php } ?>
	<?php if ($keywords) { ?>
	    <meta name="keywords" content= "<?php echo $keywords; ?>" />
	<?php } ?>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<?php if ($icon) { ?>
	    <link href="<?php echo $icon; ?>" rel="icon" />
	<?php } ?>
    <link href="/catalog/view/theme/default/stylesheet/toastr.min.css" rel="stylesheet">
    <link href="/catalog/view/theme/default/stylesheet/main.css" rel="stylesheet">
	<link href="/catalog/view/theme/default/js/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="/catalog/view/theme/default/js/bootstrap/css/bootstrap.css" rel="stylesheet" media="screen" />
	<?php foreach ($styles as $style) { ?>
	    <link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
	<?php } ?>

	<script>
		var LANGS = {};
		<?php $arr = $this->language->getGroupData(); foreach($arr as $group => $langs){ ?>LANGS['<?php echo $group?>']={};<?php foreach($langs as $name_key => $value){?>LANGS['<?php echo $group?>']['<?php echo $name_key ;?>']='<?php echo $value ;?>';<?php } ?><?php } ?>
	</script>

	<script src="/catalog/view/javascript/jquery/jquery-2.0.3.min.js" type="text/javascript"></script>
	<script src="/catalog/view/javascript/jquery/ui/jquery-ui-1.10.3.custom.min.js"></script>
    <script src="/catalog/view/javascript/toastr.min.js"></script>

	<?php foreach ($scripts as $script) { ?>
	    <script src="<?php echo $script; ?>" type="text/javascript"></script>
	<?php } ?>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js"></script>

    <?php echo $google_analytics; ?>
</head>
<body                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       >