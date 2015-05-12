<?php

/*******************************************************************************
*                                 Opencart SEO Pack                            *
*                             � Copyright Ovidiu Fechete                       *
*                              email: ovife21@gmail.com                        *
*                Below source-code or any part of the source-code              *
*                          cannot be resold or distributed.                    *
*******************************************************************************/

// Config
require_once('config.php');

// Install 
if (!defined('DIR_APPLICATION')) {
	header('Location: install/index.php');
	exit;
}

// Startup
require_once(DIR_SYSTEM . 'startup.php');

// Application Classes
require_once(DIR_SYSTEM . 'library/customer.php');
require_once(DIR_SYSTEM . 'library/affiliate.php');
require_once(DIR_SYSTEM . 'library/currency.php');
require_once(DIR_SYSTEM . 'library/tax.php');
require_once(DIR_SYSTEM . 'library/weight.php');
require_once(DIR_SYSTEM . 'library/length.php');
require_once(DIR_SYSTEM . 'library/cart.php');

// Registry
$registry = new Registry();

// Loader
$loader = new Loader($registry);
$registry->set('load', $loader);

// Config
$config = new Config();
$registry->set('config', $config);   

// Database 
$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
$registry->set('db', $db);

// Session
$session = new Session();
$registry->set('session', $session);  

echo '<html>
<body>
<FORM><INPUT TYPE="BUTTON" VALUE="Go Back" 
ONCLICK="history.go(-1)"></FORM>';

if ((!isset($_GET['token'])) || ($_GET['token'] != $session->data['token'])) 	{

		header('Location: ' . HTTP_SERVER);
	}
	else {

		$query = $db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE `group` = 'seoimages'");

		foreach ($query->rows as $result) {
					if (!$result['serialized']) {
						$data[$result['key']] = $result['value'];
					} else {
						$data[$result['key']] = unserialize($result['value']);
					}
				}
				
		if (isset($data)) {$parameters = $data['seoimageparameters'];}
			else {$parameters['keywords'] = '%p';}


		$query = $db->query("SELECT language_id FROM " . DB_PREFIX . "setting s
				inner join " . DB_PREFIX . "language l on s.value = l.code
				where s.group = 'config' and s.key = 'config_language'

			");

		foreach ($query->rows as $language) {
				$language_id = $language['language_id'];
			}


		//Product images
		$query = $db->query("select pd.name as name, p.image as image, p.product_id as product_id, p.model as model, p.sku as sku, p.upc as upc, m.name as brand, cd.name as cname 
			from " . DB_PREFIX . "product_description pd 
			inner join " . DB_PREFIX . "product p on p.product_id = pd.product_id
			inner join " . DB_PREFIX . "product_to_category pc on pd.product_id = pc.product_id
			inner join " . DB_PREFIX . "category_description cd on cd.category_id = pc.category_id and cd.language_id = pd.language_id
			left join " . DB_PREFIX . "manufacturer m on m.manufacturer_id = p.manufacturer_id
			where pd.language_id = $language_id
			");
		require_once(DIR_APPLICATION . 'controller/catalog/seopack.php');
		$seo = new ControllerCatalogSeoPack($registry);

		foreach ($query->rows as $product) {
			if ($product['image'] <> '') {
			
			$bef = array("%c", "%p", "%m", "%s", "%u", "%b");
			$aft = array($product['cname'], $product['name'], $product['model'], $product['sku'], $product['upc'], $product['brand']);
			
			$newimagename = str_replace($bef, $aft,  $parameters['keywords']);
			
			$replace = '/'.$seo->generateSlug($newimagename).'-'.$product['product_id'].'.';
			$old_image = $product['image'];
			$new_image = preg_replace('/\/([\w\s\t\a\e\f\v\W\D\s\S]((?!\/).)*?)\./', $replace, $product['image']);
			if (file_exists(DIR_IMAGE.$old_image) && ($old_image <> $new_image) &&  (substr_count($old_image, '.') == 1))
				{
				echo 'Renaming for <b>'.$product['name'].' </b> -------- Image: '. $new_image .'<br> ';
				$renamed = false;
				$renamed = rename(DIR_IMAGE.$old_image, DIR_IMAGE.$new_image);
				$old_image = mysql_real_escape_string($old_image);
				
				if ($renamed) {
					$query = $db->query("update " . DB_PREFIX . "product set image = '".$new_image."' where image ='".$old_image."'");
					$query = $db->query("update " . DB_PREFIX . "product_image set image = '".$new_image."' where image ='".$old_image."'");
					$query = $db->query("update " . DB_PREFIX . "banner_image set image = '".$new_image."' where image ='".$old_image."'");
					$query = $db->query("update " . DB_PREFIX . "category set image = '".$new_image."' where image ='".$old_image."'");
					$query = $db->query("update " . DB_PREFIX . "language set image = '".$new_image."' where image ='".$old_image."'");
					$query = $db->query("update " . DB_PREFIX . "manufacturer set image = '".$new_image."' where image ='".$old_image."'");
					$query = $db->query("update " . DB_PREFIX . "option_value set image = '".$new_image."' where image ='".$old_image."'");
					$query = $db->query("update " . DB_PREFIX . "voucher_theme set image = '".$new_image."' where image ='".$old_image."'");
					}
				}
			}
		}

		//Additional product images
		$query = $db->query("select pd.name as name, pi.image as image, pi.product_image_id, pi.product_id as product_id, p.model as model, p.sku as sku, p.upc as upc, m.name as brand, cd.name as cname  
			from " . DB_PREFIX . "product_description pd 
			inner join " . DB_PREFIX . "product_image pi on pi.product_id = pd.product_id
			inner join " . DB_PREFIX . "product p on p.product_id = pd.product_id
			inner join " . DB_PREFIX . "product_to_category pc on pd.product_id = pc.product_id
			inner join " . DB_PREFIX . "category_description cd on cd.category_id = pc.category_id and cd.language_id = pd.language_id
			left join " . DB_PREFIX . "manufacturer m on m.manufacturer_id = p.manufacturer_id
			where pd.language_id = $language_id
			");

		foreach ($query->rows as $product) {
			if ($product['image'] <> '') {
			
			$bef = array("%c", "%p", "%m", "%s", "%u", "%b");
			$aft = array($product['cname'], $product['name'], $product['model'], $product['sku'], $product['upc'], $product['brand']);
			
			$newimagename = str_replace($bef, $aft,  $parameters['keywords']);
			
			$replace = '/'.$seo->generateSlug($newimagename).'-a'.$product['product_image_id'].'.';
			
			$old_image = $product['image'];
			$new_image = preg_replace('/\/([\w\s\t\a\e\f\v\W\D\s\S]((?!\/).)*?)\./', $replace, $product['image']);
			if (file_exists(DIR_IMAGE.$old_image) && ($old_image <> $new_image) &&  (substr_count($old_image, '.') == 1))
				{
				echo 'Renaming for <b>'.$product['name'].' </b> -------- Image: '. $new_image .'<br> ';
				$renamed = false;
				$renamed = rename(DIR_IMAGE.$old_image, DIR_IMAGE.$new_image);
				$old_image = mysql_real_escape_string($old_image);
				
				if ($renamed) {
					$query = $db->query("update " . DB_PREFIX . "product set image = '".$new_image."' where image ='".$old_image."'");
					$query = $db->query("update " . DB_PREFIX . "product_image set image = '".$new_image."' where image ='".$old_image."'");
					$query = $db->query("update " . DB_PREFIX . "banner_image set image = '".$new_image."' where image ='".$old_image."'");
					$query = $db->query("update " . DB_PREFIX . "category set image = '".$new_image."' where image ='".$old_image."'");
					$query = $db->query("update " . DB_PREFIX . "language set image = '".$new_image."' where image ='".$old_image."'");
					$query = $db->query("update " . DB_PREFIX . "manufacturer set image = '".$new_image."' where image ='".$old_image."'");
					$query = $db->query("update " . DB_PREFIX . "option_value set image = '".$new_image."' where image ='".$old_image."'");
					$query = $db->query("update " . DB_PREFIX . "voucher_theme set image = '".$new_image."' where image ='".$old_image."'");
					}
				}
			}
		}
	}

	
?>

</body>
</html>


