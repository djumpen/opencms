<!doctype html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
   <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=1200" />
      <meta name="apple-mobile-web-app-capable" content="yes" />
      <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
      <meta name="apple-mobile-web-app-title" content="OpenCart"/>
      <!-- touch icons -->
      <link rel="apple-touch-icon-precomposed" href="view/image/opencart-admin.png" />
      <link rel="apple-touch-icon-precomposed" sizes="72x72" href="view/image/opencart-admin_72.png" />
      <link rel="apple-touch-icon-precomposed" sizes="114x114" href="view/image/opencart-admin_114.png" />
      <link rel="apple-touch-icon-precomposed" sizes="144x144" href="view/image/opencart-admin_144.png" />
      <title><?php echo $title; ?></title>
      <base href="<?php echo $base; ?>" />
      <link rel="icon" 
         type="image/jpg" 
         href="view/image/opencart.jpg">
      <meta http-equiv="x-dns-prefetch-control" content="on"/>
      <link rel="dns-prefetch" href="http://netdna.bootstrapcdn.com"/>
      <link rel="dns-prefetch" href="http://ajax.googleapis.com"/>
      <?php if ($description) { ?>
      <meta name="description" content="<?php echo $description; ?>" />
      <?php } ?>
      <?php if ($keywords) { ?>
      <meta name="keywords" content="<?php echo $keywords; ?>" />
      <?php } ?>
<!--[if lt IE 9]>
          <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<![endif]-->
<link href="view/javascript/bootstrap/css/bootstrap.css" rel="stylesheet" media="screen" />
<script type="text/javascript" src="/admin/view/javascript/jquery/jquery-2.0.3.min.js"></script>
<script type="text/javascript" src="/admin/view/javascript/jquery/ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="view/javascript/bootstrap/js/bootstrap.js"></script>
<link href="view/javascript/font-awesome/css/font-awesome.min.css" type="text/css" rel="stylesheet" />
<link href='http://fonts.googleapis.com/css?family=Raleway:400,600,500,300,200,100,700,800,900' rel='stylesheet' type='text/css'><link type="text/css" href="view/stylesheet/stylesheet.css" rel="stylesheet" media="screen" />
<?php foreach ($styles as $style) { ?>
<link type="text/css" href="<?php echo $style['href']; ?>" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<?php foreach ($scripts as $script) { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>
<script src="view/javascript/common.js"></script>
<script type="text/javascript" src="view/javascript/oocharts.min.js?<?php echo time(); ?>"></script>
      <script type="text/javascript">
        /* window.onload = function(){
         	oo.setAPIKey("<?php echo $this->config->get('google_api_code'); ?>");
         	oo.setBarDefaults({colors:['#4a73b9','#aabd56'],isStacked: true,bar: { groupWidth: '95%' }});
         	oo.setTimelineDefaults({colors:['#4a73b9','#aabd56'],lineWidth:3,pointSize:10});
         	oo.load(function(){
         		var bar = new oo.Bar("<?php echo $this->config->get('google_profile_id'); ?>", "7d");
         		bar.addMetric("ga:visits", "Visits");
         		bar.addMetric("ga:newVisits", "New Visits");
         		bar.setDimension("ga:continent");
         		bar.draw('chart');
         		var timeline = new oo.Timeline("<?php echo $this->config->get('google_api_code'); ?>", "30d");
         		timeline.addMetric("ga:visits", "Visits");
         		timeline.addMetric("ga:newVisits", "New Visits");
         		timeline.draw('chart');
         	});
         };*/
         
      </script>
      <script type="text/javascript">
      $(document).ready(function(){
          $('.navbar-right > li').on('click', function(){
              $('.navbar-right > li').each(function(){
                  if($(this).hasClass('active')) {
                      $(this).removeClass('active');
                  }
              });
              $(this).toggleClass('active');
          });
      });
      </script>
<script type="text/javascript" src="view/javascript/tableedit.js"></script>
<link rel="stylesheet" type="text/css" href="view/stylesheet/tableedit.css" />
   </head>
   <body>
<div id="container">
<header id="header" class="navbar navbar-default navbar-static-top">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse"><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button>
      <h1><a href="<?php echo $home; ?>" class="navbar-brand"><i class="fa fa-cogs fa-lg"></i><?php /*echo $heading_title;*/ echo " Панель управления" ?></a></h1></div>
    <?php if ($logged) { ?>

    <?php } ?>
  </div>
</header>
<?php if ($logged) { ?>
<nav id="menu" class="navbar navbar-default navbar-static-top">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex2-collapse"><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button>
    </div>
    <div class="collapse navbar-collapse navbar-ex2-collapse">
      <ul class="nav navbar-nav">
        <li id="dashboard"><a href="<?php echo $home; ?>"><?php echo $text_dashboard; ?></a></li>
        <?php if($this->user->hasPermission('access','catalog/product')): ?>
        <li id="catalog" class="dropdown"><a data-toggle="dropdown"><?php echo $text_catalog; ?> </a>
          <ul class="dropdown-menu">
            <?php if($this->user->hasPermission('access','catalog/category')): ?>
            <li><a href="<?php echo $category; ?>"><?php echo $text_category; ?></a></li>
            <?php endif; ?>
            <?php if($this->user->hasPermission('access','catalog/product')): ?>
            <li><a href="<?php echo $product; ?>"><?php echo $text_product; ?></a></li>
            <?php endif;?>
            <?php if($this->user->hasPermission('access','catalog/series')): ?>
            <!-- Product Series start -->
            <li><a href="<?php echo $series; ?>">Серии продуктов</a></li>
            <!-- Product Series end -->
            <?php endif; ?>
            <?php /*
            <?php if($this->user->hasPermission('access','catalog/filter')): ?>
            <!-- Product Filter start -->
            <li><a href="<?php echo $filter; ?>"><?php echo $text_filter; ?></a></li>
            <!-- Product Filter end -->
            <?php endif; ?>
            */ ?>
            <?php if($this->user->hasPermission('access','catalog/promotags')): ?>
            <!--code start-->
            <li><a href="<?php echo $tags; ?>"><?php echo $text_tags; ?></a></li>
            <!--code end-->
            <?php endif; ?>
            <?php if($this->user->hasPermission('access','catalog/seopack')): ?>
            <li class="dropdown-submenu"><a>SEO</a>
			<ul class="dropdown-menu">
			<?php if($this->user->hasPermission('access','catalog/seopack')): ?>			
			<li><a href="<?php echo $seopack; ?>"><?php echo $text_seopack; ?></a></li>
			<?php endif; ?>
			<?php if($this->user->hasPermission('access','catalog/seoimages')): ?>
			<li><a href="<?php echo $seoimages; ?>"><?php echo $text_seoimages; ?></a></li>
			<?php endif; ?>
			<?php if($this->user->hasPermission('access','catalog/seoeditor')): ?>
			<li>
				<?php if (file_exists(DIR_APPLICATION.'controller/catalog/seoeditor.php')) { ?>
				<a href="<?php echo $seoeditor; ?>"><?php echo $text_seoeditor; ?></a>
				<?php } else { ?>
				<a onclick="alert('Advanced SEO Editor is not installed!\nYou can purchase Advanced SEO Editor from\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=6183\nor you can purchase the whole Opencart SEO Pack PRO:\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=6182');" class="button"><?php echo $text_seoeditor; ?></a>
				<?php } ?>
			</li>
			<?php endif; ?>
			</ul>
			</li>
			<?php endif; ?>
			<?php /* 
			<?php if($this->user->hasPermission('access','catalog/profile')): ?>
            <li><a href="<?php echo $profile; ?>"><?php echo $text_profile; ?></a></li>
            <?php endif; ?>
             */ ?>
            <?php if($this->user->hasPermission('access','catalog/attribute')): ?>
            <li class="dropdown-submenu"><a><?php echo $text_attribute; ?></a>
              <ul class="dropdown-menu">
                <?php if($this->user->hasPermission('access','catalog/attribute')): ?>
                <li><a href="<?php echo $attribute; ?>"><?php echo $text_attribute; ?></a></li>
                <?php endif; ?>
                <?php if($this->user->hasPermission('access','catalog/attribute_group')): ?>
                <li><a href="<?php echo $attribute_group; ?>"><?php echo $text_attribute_group; ?></a></li>
                <?php endif; ?>
              </ul>
            </li>
            <?php endif; ?>
            <?php if($this->user->hasPermission('access','catalog/option')): ?>
            <li><a href="<?php echo $option; ?>"><?php echo $text_option; ?></a></li>
            <?php endif; ?>
            <?php if($this->user->hasPermission('access','catalog/manufacturer')): ?>
            <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
            <?php endif; ?>
            <?php if($this->user->hasPermission('access','catalog/download')): ?>
            <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
            <?php endif; ?>
            <?php if($this->user->hasPermission('access','catalog/review')): ?>
            <li><a href="<?php echo $review; ?>"><?php echo $text_review; ?></a></li>
            <?php endif; ?>
            <?php if($this->user->hasPermission('access','catalog/information')): ?>
            <li><a href="<?php echo $information; ?>"><?php echo $text_information; ?></a></li>
            <?php endif; ?>
            <?php if($this->user->hasPermission('access','module/poll')): ?>
            <li><a href="<?php echo $poll; ?>"><?php echo $text_poll; ?></a></li>
            <?php endif; ?>
            <?php if($this->user->hasPermission('access','catalog/testimonial')): ?>
            <li><a href="<?php echo $testimonial; ?>"><?php echo $text_testimonial; ?></a></li>
            <?php endif; ?>
            <?php /* PO GALLERY */?>
            <?php if($this->user->hasPermission('access','catalog/po_gallery_album') || $this->user->hasPermission('access','catalog/po_gallery_album_review') || $this->user->hasPermission('access','catalog/po_gallery_photo') || $this->user->hasPermission('access','catalog/po_gallery_setting')): ?>
            <li class="dropdown-submenu"><a class="top">Галлереи</a>
            	<ul class="dropdown-menu">
            		<?php if($this->user->hasPermission('access','catalog/po_gallery_album')):?>
		            <li><a href="<?php print $this->url->link('catalog/po_gallery_album', 'token=' . $this->session->data['token']); ?>">Альбомы</a></li>
		            <?php endif; ?>
		            <?php if($this->user->hasPermission('access','catalog/po_gallery_album_review')):?>
		            <li><a href="<?php print $this->url->link('catalog/po_gallery_album_review', 'token=' . $this->session->data['token']); ?>">Отзывы</a></li>
		            <?php endif; ?>
		            <?php if($this->user->hasPermission('access','catalog/po_gallery_photo')):?>
		            <li><a href="<?php print $this->url->link('catalog/po_gallery_photo', 'token=' . $this->session->data['token']); ?>">Фото</a></li>
		            <?php endif; ?>
		            <?php if($this->user->hasPermission('access','catalog/po_gallery_setting')):?>
		            <li><a href="<?php print $this->url->link('catalog/po_gallery_setting', 'token=' . $this->session->data['token']); ?>">Настройки</a></li>
		            <?php endif; ?>
	            </ul>
            </li>
            <?php endif; ?>
            <?php /* PO GALLERY */?>
            <?php if($this->user->hasPermission('access','module/pavblog')): ?>
            <!-- Pav Blog -->
            <?php if($pavblog_installed): ?>
			<li id="pavblogs" class="dropdown-submenu"><a class="top"><?php echo $text_pavblog_blog; ?></a>
				<ul class="dropdown-menu">
		          <li><a href="<?php echo $pavblogs_category; ?>"><?php echo $text_pavblog_manage_cate; ?></a></li>
		          <li><a href="<?php echo $pavblogs_blogs; ?>"><?php echo $text_pavblog_manage_blog; ?></a></li>
		          <li><a href="<?php echo $pavblogs_add_blog; ?>"><?php echo $text_pavblog_add_blog; ?></a></li>
		          <li><a href="<?php echo $pavblogs_comments; ?>"><?php echo $text_pavblog_manage_comment; ?></a></li>
		          <li><a href="<?php echo $pavblogs_general; ?>"><?php echo $text_pavblog_general_setting; ?></a></li>
		          <li class="dropdown-submenu"><a class="parent"><?php echo $text_pavblog_front_mods; ?></a>
				      <ul class="dropdown-menu">
		                  <li><a href="<?php echo $pavblogs_category_mod; ?>"><?php echo $text_pavblog_category; ?></a></li>
		                  <li><a href="<?php echo $pavblogs_latest_comment_mod; ?>"><?php echo $text_pavblog_comment; ?></a></li>
		                  <li><a href="<?php echo $pavblogs_latest_mod; ?>"><?php echo $text_pavblog_latest; ?></a></li>
	                  </ul>
	              </li>
		        </ul>
		    </li>
		    <?php endif; ?>
            <!-- Pav Blog -->
            <?php endif;?>
          </ul>
        </li>
        <?php endif;?>
        <?php if($this->user->hasPermission('access','extension/module')): ?>
        <li id="extension" class="dropdown"><a data-toggle="dropdown"><?php echo $text_extension; ?></a>
          <ul class="dropdown-menu">
            <?php if($this->user->hasPermission('access','extension/module')): ?>
            <li><a href="<?php echo $module; ?>"><?php echo $text_module; ?></a></li>
            <?php endif; ?>
            <?php if($this->user->hasPermission('access','extension/shipping')): ?>
            <li><a href="<?php echo $shipping; ?>"><?php echo $text_shipping; ?></a></li>
            <?php endif; ?>
            <?php if($this->user->hasPermission('access','extension/payment')): ?>
            <li><a href="<?php echo $payment; ?>"><?php echo $text_payment; ?></a></li>
            <?php endif; ?>
            <?php if($this->user->hasPermission('access','extension/total')): ?>
            <li><a href="<?php echo $total; ?>"><?php echo $text_total; ?></a></li>
            <?php endif; ?>
            <?php if($this->user->hasPermission('access','extension/feed')): ?>
            <li><a href="<?php echo $feed; ?>"><?php echo $text_feed; ?></a></li>
            <?php endif; ?>
            <?php if(false) { ?>
            <?php if($this->user->hasPermission('access','extension/openbay')): ?>
            <li class="dropdown-submenu">
              <a><?php echo $text_openbay_extension; ?></a>
                <ul class="dropdown-menu">
                  <li><a href="<?php echo $openbay_link_extension; ?>"><?php echo $text_openbay_dashboard; ?></a></li>
                  <li><a href="<?php echo $openbay_link_orders; ?>"><?php echo $text_openbay_orders; ?></a></li>
                  <li><a href="<?php echo $openbay_link_items; ?>"><?php echo $text_openbay_items; ?></a></li>
                  <?php if($openbay_markets['ebay'] == 1){ ?>
                  <li role="presentation" class="divider"></li>
                  <li role="presentation" class="dropdown-header"><?php echo $text_openbay_ebay; ?></li>
                  <li><a href="<?php echo $openbay_link_ebay_settings; ?>"><?php echo $text_openbay_settings; ?></a></li>
                  <li><a href="<?php echo $openbay_link_ebay_links; ?>"><?php echo $text_openbay_links; ?></a></li>
                  <li><a href="<?php echo $openbay_link_ebay_orderimport; ?>"><?php echo $text_openbay_order_import; ?></a></li>
                  <?php } ?>
                  <?php if($openbay_markets['amazon'] == 1){ ?>
                  <li role="presentation" class="divider"></li>
                  <li role="presentation" class="dropdown-header" href="<?php echo $openbay_link_amazon; ?>"><?php echo $text_openbay_amazon; ?></li>
                  <li><a href="<?php echo $openbay_link_amazon_settings; ?>"><?php echo $text_openbay_settings; ?></a></li>
                  <li><a href="<?php echo $openbay_link_amazon_links; ?>"><?php echo $text_openbay_links; ?></a></li>
                  <?php } ?>
                  <?php if($openbay_markets['amazonus'] == 1){ ?>
                  <li role="presentation" class="divider"></li>
                  <li role="presentation" class="dropdown-header" href="<?php echo $openbay_link_amazonus; ?>"><?php echo $text_openbay_amazonus; ?></li>
                  <li><a href="<?php echo $openbay_link_amazonus_settings; ?>"><?php echo $text_openbay_settings; ?></a></li>
                  <li><a href="<?php echo $openbay_link_amazonus_links; ?>"><?php echo $text_openbay_links; ?></a></li>
                  <?php } ?>
                  <?php if($openbay_markets['play'] == 1){ ?>
                  <li role="presentation" class="divider"></li>
                  <li role="presentation" class="dropdown-header" href="<?php echo $openbay_link_play; ?>"><?php echo $text_openbay_play; ?></li>
                  <li><a href="<?php echo $openbay_link_play_settings; ?>"><?php echo $text_openbay_settings; ?></a></li>
                  <li><a href="<?php echo $openbay_link_play_report_price; ?>"><?php echo $text_openbay_report_price; ?></a></li>
                  <?php } ?>
                </ul>
            </li>
            <?php endif; ?>
            <?php } ?>
		  </ul>
        </li>
        <?php endif; ?>
        <?php if($this->user->hasPermission('access','sale/order')): ?>
        <li id="sale" class="dropdown"><a data-toggle="dropdown"><?php echo $text_sale; ?></a>
          <ul class="dropdown-menu">
          <?php if($this->user->hasPermission('access','sale/order')): ?>
            <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
            <?php endif; ?>
            <?php if($this->user->hasPermission('access','sale/return') && false): ?>
            <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
            <?php endif; ?>
            <?php if($this->user->hasPermission('access','sale/customer')): ?>
            <li class="dropdown-submenu"><a><?php echo $text_customer; ?></a>
              <ul class="dropdown-menu">
                <li><a href="<?php echo $customer; ?>"><?php echo $text_customer; ?></a></li>
                <li><a href="<?php echo $customer_group; ?>"><?php echo $text_customer_group; ?></a></li>
                <li><a href="<?php echo $customer_ban_ip; ?>"><?php echo $text_customer_ban_ip; ?></a></li>
              </ul>
            </li>
            <?php endif; ?>
            <?php if($this->user->hasPermission('access','sale/voucher')): ?>
            <li class="dropdown-submenu"><a><?php echo $text_voucher; ?></a>
              <ul class="dropdown-menu">
                <?php if($this->user->hasPermission('access','sale/voucher')): ?>
                <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
                <?php endif; ?>
                <?php if($this->user->hasPermission('access','sale/voucher_theme')): ?>
                <li><a href="<?php echo $voucher_theme; ?>"><?php echo $text_voucher_theme; ?></a></li>
                <?php endif; ?>
              </ul>
            </li>
            <?php endif; ?>
            <?php if($this->user->hasPermission('access','sale/affiliate') && false): ?>
            <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
            <?php endif; ?>
            <?php if($this->user->hasPermission('access','sale/coupon')): ?>
            <li><a href="<?php echo $coupon; ?>"><?php echo $text_coupon; ?></a></li>
            <?php endif; ?>
            <?php if($this->user->hasPermission('access','sale/contact')): ?>
            <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
            <?php endif; ?>
          </ul>
        </li>
        <?php endif; ?>
        <!-- System permisssions verifcation -->
        <?php if(
            $this->user->hasPermission('access','localisation/language') ||
            $this->user->hasPermission('access','localisation/currency') ||
            $this->user->hasPermission('access','localisation/stock_status') ||
            $this->user->hasPermission('access','localisation/order_status') ||
            $this->user->hasPermission('access','localisation/return_status') ||
            $this->user->hasPermission('access','localisation/return_action') ||
            $this->user->hasPermission('access','localisation/return_reason') ||
            $this->user->hasPermission('access','localisation/country') ||
            $this->user->hasPermission('access','localisation/zone') ||
            $this->user->hasPermission('access','localisation/geo_zone') ||
            $this->user->hasPermission('access','localisation/tax_class') ||
            $this->user->hasPermission('access','localisation/tax_rate') ||
            $this->user->hasPermission('access','localisation/length_class') ||
            $this->user->hasPermission('access','localisation/weight_class') ||
            $this->user->hasPermission('access','setting/store') ||
            $this->user->hasPermission('access','design/layout') ||
            $this->user->hasPermission('access','design/banner') ||
            $this->user->hasPermission('access','user/user_permission') ||
            $this->user->hasPermission('access','user/user') ||
            $this->user->hasPermission('access','tool/error_log') ||
            $this->user->hasPermission('access','tool/backup')
        ): ?>
        <li id="system" class="dropdown"><a data-toggle="dropdown"><?php echo $text_system; ?></i></a>
          <ul class="dropdown-menu">
            <?php if($this->user->hasPermission('access','setting/store')): ?>
            <li><a href="<?php echo $setting; ?>"><?php echo $text_setting; ?></a></li>
            <?php endif ;?>
            <?php if(
                      $this->user->hasPermission('access','design/layout') ||
                      $this->user->hasPermission('access','design/banner')
                    ): ?>
            <li class="dropdown-submenu"><a><?php echo $text_design; ?></a>
              <ul class="dropdown-menu">
                <?php if($this->user->hasPermission('access','design/layout')): ?>
                <li><a href="<?php echo $layout; ?>"><?php echo $text_layout; ?></a></li>
                <?php endif; ?>
                <?php if($this->user->hasPermission('access','design/banner')): ?>
                <li><a href="<?php echo $banner; ?>"><?php echo $text_banner; ?></a></li>
                <?php endif; ?>
              </ul>
            </li>
            <?php endif; ?>
            <?php if($this->user->hasPermission('access','user/user_permission')): ?>
            <li class="dropdown-submenu"><a><?php echo $text_users; ?></a>
              <ul class="dropdown-menu">
                <?php if($this->user->hasPermission('access','user/user')): ?>
                <li><a href="<?php echo $user; ?>"><?php echo $text_user; ?></a></li>
                <?php endif; ?>
                <?php if($this->user->hasPermission('access','user/user_permission')): ?>
                <li><a href="<?php echo $user_group; ?>"><?php echo $text_user_group; ?></a></li>
                <?php endif; ?>
              </ul>
            </li>
            <?php endif; ?>
            <?php if(
                        $this->user->hasPermission('access','localisation/language') ||
                        $this->user->hasPermission('access','localisation/currency') ||
                        $this->user->hasPermission('access','localisation/stock_status') ||
                        $this->user->hasPermission('access','localisation/order_status') ||
                        $this->user->hasPermission('access','localisation/return_status') ||
                        $this->user->hasPermission('access','localisation/return_action') ||
                        $this->user->hasPermission('access','localisation/return_reason') ||
                        $this->user->hasPermission('access','localisation/country') ||
                        $this->user->hasPermission('access','localisation/zone') ||
                        $this->user->hasPermission('access','localisation/geo_zone') ||
                        $this->user->hasPermission('access','localisation/tax_class') ||
                        $this->user->hasPermission('access','localisation/tax_rate') ||
                        $this->user->hasPermission('access','localisation/length_class') ||
                        $this->user->hasPermission('access','localisation/weight_class')
            ): ?>
            <li class="dropdown-submenu"><a><?php echo $text_localisation; ?></a>
              <ul class="dropdown-menu">
                <?php if($this->user->hasPermission('access','localisation/language')): ?>
                <li><a href="<?php echo $language; ?>"><?php echo $text_language; ?></a></li>
                <?php endif; ?>
                <?php if($this->user->hasPermission('access','localisation/currency')): ?>
                <li><a href="<?php echo $currency; ?>"><?php echo $text_currency; ?></a></li>
                <?php endif; ?>
                <?php if($this->user->hasPermission('access','localisation/stock_status')): ?>
                <li><a href="<?php echo $stock_status; ?>"><?php echo $text_stock_status; ?></a></li>
                <?php endif; ?>
                <?php if($this->user->hasPermission('access','localisation/order_status')): ?>
                <li><a href="<?php echo $order_status; ?>"><?php echo $text_order_status; ?></a></li>
                <?php endif; ?>
                <?php if( (
                    $this->user->hasPermission('access','localisation/return_status') ||
                    $this->user->hasPermission('access','localisation/return_action') ||
                    $this->user->hasPermission('access','localisation/return_reason') ) && false
                ): ?>
                <li class="dropdown-submenu"><a><?php echo $text_return; ?></a>
                  <ul class="dropdown-menu">
                    <?php if($this->user->hasPermission('access','localisation/return_status')): ?>
                    <li><a href="<?php echo $return_status; ?>"><?php echo $text_return_status; ?></a></li>
                    <?php endif; ?>
                    <?php if($this->user->hasPermission('access','localisation/return_action')): ?>
                    <li><a href="<?php echo $return_action; ?>"><?php echo $text_return_action; ?></a></li>
                    <?php endif; ?>
                    <?php if($this->user->hasPermission('access','localisation/return_reason')): ?>
                    <li><a href="<?php echo $return_reason; ?>"><?php echo $text_return_reason; ?></a></li>
                    <?php endif; ?>
                  </ul>
                </li>
                <?php endif; ?>
                <?php if($this->user->hasPermission('access','localisation/country')): ?>
                <li><a href="<?php echo $country; ?>"><?php echo $text_country; ?></a></li>
                <?php endif; ?>
                <?php if($this->user->hasPermission('access','localisation/zone')): ?>
                <li><a href="<?php echo $zone; ?>"><?php echo $text_zone; ?></a></li>
                <?php endif; ?>
                <?php if($this->user->hasPermission('access','localisation/geo_zone')): ?>
                <li><a href="<?php echo $geo_zone; ?>"><?php echo $text_geo_zone; ?></a></li>
                <?php endif; ?>
                <?php if( (
                    $this->user->hasPermission('access','localisation/tax_class') ||
                    $this->user->hasPermission('access','localisation/tax_rate') ) && false
                ): ?>
                <li class="dropdown-submenu"><a><?php echo $text_tax; ?></a>
                  <ul class="dropdown-menu">
                    <?php if($this->user->hasPermission('access','localisation/tax_class')): ?>
                    <li><a href="<?php echo $tax_class; ?>"><?php echo $text_tax_class; ?></a></li>
                    <?php endif; ?>
                    <?php if($this->user->hasPermission('access','localisation/tax_rate')): ?>
                    <li><a href="<?php echo $tax_rate; ?>"><?php echo $text_tax_rate; ?></a></li>
                    <?php endif; ?>
                  </ul>
                </li>
                <?php endif; ?>
                <?php if($this->user->hasPermission('access','localisation/length_class') && false): ?>
                <li><a href="<?php echo $length_class; ?>"><?php echo $text_length_class; ?></a></li>
                <?php endif; ?>
                <?php if($this->user->hasPermission('access','localisation/weight_class') && false): ?>
                <li><a href="<?php echo $weight_class; ?>"><?php echo $text_weight_class; ?></a></li>
                <?php endif; ?>
              </ul>
            </li>
            <?php endif; ?>
            <?php if(false) { ?>
            <li class="divider"></li>
            <?php if($this->user->hasPermission('access','tool/error_log')): ?>
            <li><a href="<?php echo $error_log; ?>"><?php echo $text_error_log; ?></a></li>
            <?php endif; ?>
            <?php if($this->user->hasPermission('access','tool/backup')): ?>
            <li><a href="<?php echo $backup; ?>"><?php echo $text_backup; ?></a></li>
            <?php endif; ?>
            <?php } ?>
          </ul>
        </li>
        <?php endif; ?>
        <!-- System permisssions verifcation -->
        <?php if(false) { ?>
        <li id="reports" class="dropdown"><a data-toggle="dropdown"><?php echo $text_reports; ?></a>
          <ul class="dropdown-menu">
            <?php if(
                $this->user->hasPermission('access','report/sale_order') ||
                $this->user->hasPermission('access','report/sale_tax') ||
                $this->user->hasPermission('access','report/sale_shipping') ||
                $this->user->hasPermission('access','report/sale_return') ||
                $this->user->hasPermission('access','report/sale_coupon') 
            ): ?>
            <li class="dropdown-submenu"><a><?php echo $text_sale; ?></a>
              <ul class="dropdown-menu">
                <?php if($this->user->hasPermission('access','report/sale_order')): ?>
                <li><a href="<?php echo $report_sale_order; ?>"><?php echo $text_report_sale_order; ?></a></li>
                <?php endif; ?>
                <?php if($this->user->hasPermission('access','report/sale_tax')): ?>
                <li><a href="<?php echo $report_sale_tax; ?>"><?php echo $text_report_sale_tax; ?></a></li>
                <?php endif; ?>
                <?php if($this->user->hasPermission('access','report/sale_shipping')): ?>
                <li><a href="<?php echo $report_sale_shipping; ?>"><?php echo $text_report_sale_shipping; ?></a></li>
                <?php endif; ?>
                <?php if($this->user->hasPermission('access','report/sale_return')): ?>
                <li><a href="<?php echo $report_sale_return; ?>"><?php echo $text_report_sale_return; ?></a></li>
                <?php endif; ?>
                <?php if($this->user->hasPermission('access','report/sale_coupon')): ?>
                <li><a href="<?php echo $report_sale_coupon; ?>"><?php echo $text_report_sale_coupon; ?></a></li>
                <?php endif; ?>
              </ul>
            </li>
            <?php endif; ?>
            <?php if(
                $this->user->hasPermission('access','report/product_viewed') ||
                $this->user->hasPermission('access','report/product_purchased')
            ): ?>
            <li class="dropdown-submenu"><a><?php echo $text_product; ?></a>
              <ul class="dropdown-menu">
                <?php if($this->user->hasPermission('access','report/product_viewed')): ?>
                <li><a href="<?php echo $report_product_viewed; ?>"><?php echo $text_report_product_viewed; ?></a></li>
                <?php endif; ?>
                <?php if($this->user->hasPermission('access','report/product_purchased')): ?>
                <li><a href="<?php echo $report_product_purchased; ?>"><?php echo $text_report_product_purchased; ?></a></li>
                <?php endif; ?>
              </ul>
            </li>
            <?php endif; ?>
            <?php if(
                $this->user->hasPermission('access','report/customer_online') ||
                $this->user->hasPermission('access','report/customer_order') ||
                $this->user->hasPermission('access','report/customer_reward') ||
                $this->user->hasPermission('access','report/customer_credit')
            ): ?>
            <li class="dropdown-submenu"><a><?php echo $text_customer; ?></a>
              <ul class="dropdown-menu">
                <?php if($this->user->hasPermission('access','report/customer_online')): ?>
                <li><a href="<?php echo $report_customer_online; ?>"><?php echo $text_report_customer_online; ?></a></li>
                <?php endif; ?>
                <?php if($this->user->hasPermission('access','report/customer_order')): ?>
                <li><a href="<?php echo $report_customer_order; ?>"><?php echo $text_report_customer_order; ?></a></li>
                <?php endif; ?>
                <?php if($this->user->hasPermission('access','report/customer_reward')): ?>
                <li><a href="<?php echo $report_customer_reward; ?>"><?php echo $text_report_customer_reward; ?></a></li>
                <?php endif; ?>
                <?php if($this->user->hasPermission('access','report/customer_credit') && false): ?>
                <li><a href="<?php echo $report_customer_credit; ?>"><?php echo $text_report_customer_credit; ?></a></li>
                <?php endif; ?>
              </ul>
            </li>
          <?php endif; ?>
          <?php if($this->user->hasPermission('access','report/affiliate_commission') && false): ?>
          <li class="dropdown-submenu"><a><?php echo $text_affiliate; ?></a>
            <ul class="dropdown-menu">
              <?php if($this->user->hasPermission('access','report/affiliate_commission')): ?>
              <li><a href="<?php echo $report_affiliate_commission; ?>"><?php echo $text_report_affiliate_commission; ?></a></li>
              <?php endif; ?>
            </ul>
          </li>
          <?php endif; ?>
          </ul>
        </li>
        <?php } ?>
      </ul>
      
    </div>
  </div>
</nav>
<?php } ?>

<input type="hidden" id="current_token" value="<?php print (isset($this->session->data['token'])?$this->session->data['token']:null); ?>">

