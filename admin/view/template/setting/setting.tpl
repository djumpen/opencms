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
        <button type="submit" form="form-setting" class="btn btn-primary "><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
      <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-setting" class="form-horizontal">
        <ul class="nav nav-tabs">
          <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
          <li><a href="#tab-contacts" data-toggle="tab">Контакты</a></li>
          <li><a href="#tab-store" data-toggle="tab"><?php echo $tab_store; ?></a></li>
          <li><a href="#tab-local" data-toggle="tab"><?php echo $tab_local; ?></a></li>
          <li><a href="#tab-option" data-toggle="tab"><?php echo $tab_option; ?></a></li>
          <li><a href="#tab-image" data-toggle="tab"><?php echo $tab_image; ?></a></li>
          <li><a href="#tab-ftp" data-toggle="tab"><?php echo $tab_ftp; ?></a></li>
          <li><a href="#tab-mail" data-toggle="tab"><?php echo $tab_mail; ?></a></li>
          <li><a href="#tab-fraud" data-toggle="tab"><?php echo $tab_fraud; ?></a></li>
          <li><a href="#tab-server" data-toggle="tab"><?php echo $tab_server; ?></a></li>
        </ul>
        <div class="tab-content">
          <div class="tab-pane active" id="tab-general">
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
              <label class="col-xs-2 control-label" for="input-telephone-2">Доп. телефон 1: </label>
              <div class="col-xs-10">
                <input type="text" name="config_telephone_2" value="<?php echo $config_telephone_2; ?>" id="input-telephone-2" class="form-control" />
              </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-telephone-3">Доп. телефон 2: </label>
              <div class="col-xs-10">
                <input type="text" name="config_telephone_3" value="<?php echo $config_telephone_3; ?>" id="input-telephone-3" class="form-control" />
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
    			<input type="text" name="config_title[<?php echo $language['language_id']; ?>]" value="<?php  if (isset($config_title[$language['language_id']])) { echo $config_title[$language['language_id']]; } ?>" id="input-title<?php print $language['language_id']; ?>" class="form-control" />
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
    			<textarea name="config_meta_description[<?php echo $language['language_id']; ?>]" cols="40"  rows="5" id="input-meta-description<?php print $language['language_id']; ?>" class="form-control"><?php if (isset($config_meta_description[$language['language_id']])) { echo $config_meta_description[$language['language_id']]; } ?></textarea>			
    			<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br>
    			<?php } ?>
              </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-meta-keywords">Meta Tag Keywords: </label>
              <div class="col-xs-10">
                <textarea name="config_meta_keywords" cols="40" rows="3" id="input-meta-keywords" class="form-control"><?php echo $config_meta_keywords; ?></textarea>
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
          <div class="tab-pane" id="tab-contacts">
          <style>
                .remove-contact-phone { margin: 0px 0px 0px -10px; }
                .remove-contact-email { margin: 0px 0px 0px -10px; }
                
                .add-contact-phone { margin: 10px 15px 10px 50px; }
                .add-contact-email { margin: 10px 15px 10px 50px; }
                
                .contact-element { margin-right: 15px; margin-left: 15px; border-bottom: 1px dashed #ccc; margin-bottom: 25px; }
                .contact-element .remove-contact-element { float: right; display: block; margin-top: -15px; margin-bottom: 15px; }
                
                .form-group .col-xs-10 { margin-bottom: 8px; }
                
                .email-element { margin-bottom: 8px; }
                .phone-element { margin-bottom: 8px; }
                
                #add-contact { float: right; margin-right: 15px; }
            </style>
            <!-- loop in lang -->
            <ul class="nav nav-tabs contact-tabs">
            <?php $cli = 0;?>
            <?php foreach ($languages as $language) { ?>
          		<li class="<?php print ($cli == 0)? 'active': '';?>" language-id="<?php print $language['language_id']; ?>"><a href="#tab-contact-<?php print $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php print $language['image']; ?>"><?php print $language['name']; ?></a></li>
          		<?php $cli++; ?>
            <?php } ?>
        	</ul>
        	<div class="tab-content">
        	<?php $cli = 0;?>
            <?php foreach ($languages as $language) { ?>
            <div class="form-group contacts tab-pane <?php print ($cli == 0)? 'active': '';?>" id="tab-contact-<?php print $language['language_id']; ?>">
            	<div class="contact-elements">
	            	<?php if(!empty($config_contacts)) { ?>
	            	<?php $ci = 0; ?>
	            	<?php if(!empty($config_contacts[$language['language_id']])) { ?>
	            	<?php foreach ($config_contacts[$language['language_id']] as $contact) { ?>
	            	<div class="row contact-element element-<?php print $ci; ?>" element-number="<?php print $ci; ?>">
	            		<div class="form-group">
			            	<label class="col-xs-2 control-label" for="input-contact-name-<?php print $ci; ?>">Название/Имя: </label>
			            	<div class="col-xs-10">
			            		<input type="text" name="config_contacts[<?php print $language['language_id']; ?>][<?php print $ci; ?>][name]" value="<?php print $contact['name']; ?>" id="input-contact-name-<?php print $ci; ?>" class="form-control" />
			            	</div>
			            	<label class="col-xs-2 control-label" for="input-contact-description-<?php print $ci; ?>">Описание: </label>
			            	<div class="col-xs-10">
			            		<input type="text" name="config_contacts[<?php print $language['language_id']; ?>][<?php print $ci; ?>][description]" value="<?php print $contact['description']; ?>" id="input-contact-description-<?php print $ci; ?>" class="form-control" />
			            	</div>
							<label class="col-xs-2 control-label" for="input-contact-class-<?php print $ci; ?>">CSS Class: </label>
							<div class="col-xs-10">
								<input type="text" name="config_contacts[<?php print $language['language_id']; ?>][<?php print $ci; ?>][class]" value="<?php print $contact['class']; ?>" id="input-contact-class-<?php print $ci; ?>" class="form-control" />
							</div>
			            	<div class="contact-phones">
			            		<div class="phone-group">
			            		<?php if(!empty($contact['phones'])) { ?>
			            		<?php $cpi=1; ?>
			            		<?php foreach ($contact['phones'] as $c_phone) { ?>
			            		<div class="phone-element" pe-index="<?php print $cpi; ?>">
				            		<label class="col-xs-2 control-label" for="input-contact-phones-<?php print $ci; ?>-<?php print $cpi; ?>">Телефон (<?php print $cpi; ?>): </label>
				            		<div class="col-xs-9">
					            		<input type="text" name="config_contacts[<?php print $language['language_id']; ?>][<?php print $ci; ?>][phones][<?php print $cpi; ?>]" value="<?php print $c_phone; ?>" id="input-contact-phones-<?php print $ci; ?>-<?php print $cpi; ?>" class="form-control" />
					            	</div>
                                    <span class="btn btn-danger remove-contact-phone">Удалить</span>
                                    <div style="clear: both;"></div>
				            	</div>
			            		<?php $cpi++; ?>
			            		<?php } ?>
			            		<?php } ?>
			            		</div>
			            		<span class="btn btn-success add-contact-phone">Добавить телефон</span>
			            	</div>
			            	<div class="contact-emails">
			            		<div class="email-group">
				            		<?php if(!empty($contact['emails'])) { ?>
				            		<?php $cei=1; ?>
				            		<?php foreach ($contact['emails'] as $c_email) { ?>
				            		<div class="email-element" ee-index="<?php print $cei; ?>">
					            		<label class="col-xs-2 control-label" for="input-contact-emails-<?php print $ci; ?>-<?php print $cei; ?>">Email (<?php print $cei; ?>): </label>
					            		<div class="col-xs-9">
						            		<input type="text" name="config_contacts[<?php print $language['language_id']; ?>][<?php print $ci; ?>][emails][<?php print $cei; ?>]" value="<?php print $c_email; ?>" id="input-contact-email-<?php print $ci; ?>-<?php print $cei; ?>" class="form-control" />
						            	</div>
                                        <span class="btn btn-danger remove-contact-email">Удалить</span>
                                        <div style="clear: both;"></div>
					            	</div>
				            		<?php $cei++; ?>
				            		<?php } ?>
				            		<?php } ?>
			            		</div>
			            		<span class="btn btn-success add-contact-email">Добавить email</span>
			            	</div>
			            </div>
			            <span class="btn btn-danger remove-contact-element">Удалить блок контактов</span>
	            	</div>
	            	<?php $ci++; ?>
	            	<?php } ?>
	            	<?php } ?>
	            	<?php } ?>
            	</div>
            	<span class="btn btn-success" id="add-contact">Добавить группу контактов</span>
            </div>
            <?php $cli++; ?>
            <?php } ?>
            </div>
            <!-- loop in lang -->
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
              <label class="col-xs-2 control-label" for="input-admin-language"><?php echo $entry_admin_language; ?></label>
              <div class="col-xs-10">
                <select name="config_admin_language" id="input-admin-language" class="form-control">
                  <?php foreach ($languages as $language) { ?>
                  <?php if ($language['code'] == $config_admin_language) { ?>
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
            <div class="form-group">
              <label class="col-xs-2 control-label"><?php echo $entry_currency_auto; ?></label>
              <div class="col-xs-10">

		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($config_currency_auto == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="config_currency_auto" value="1" <?php if ($config_currency_auto == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($config_currency_auto == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="config_currency_auto" value="0" <?php if ($config_currency_auto == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>

                 </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-length-class"><?php echo $entry_length_class; ?></label>
              <div class="col-xs-10">
                <select name="config_length_class_id" id="input-length-class" class="form-control">
                  <?php foreach ($length_classes as $length_class) { ?>
                  <?php if ($length_class['length_class_id'] == $config_length_class_id) { ?>
                  <option value="<?php echo $length_class['length_class_id']; ?>" selected="selected"><?php echo $length_class['title']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $length_class['length_class_id']; ?>"><?php echo $length_class['title']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-weight-class"><?php echo $entry_weight_class; ?></label>
              <div class="col-xs-10">
                <select name="config_weight_class_id" id="input-weight-class" class="form-control">
                  <?php foreach ($weight_classes as $weight_class) { ?>
                  <?php if ($weight_class['weight_class_id'] == $config_weight_class_id) { ?>
                  <option value="<?php echo $weight_class['weight_class_id']; ?>" selected="selected"><?php echo $weight_class['title']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $weight_class['weight_class_id']; ?>"><?php echo $weight_class['title']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
              </div>
            </div>
          </div>
          <div class="tab-pane" id="tab-option">
          <div class="tab-content">
	            <ul class="nav nav-tabs" id="tab-optionsub">
	              <li><a href="#tab-optionsub1" data-toggle="tab">Элементы</a></li>
	              <li><a href="#tab-optionsub2" data-toggle="tab">Товары</a></li>
	              <li><a href="#tab-optionsub3" data-toggle="tab">Отзывы</a></li>
	              <li><a href="#tab-optionsub4" data-toggle="tab">Сертификаты</a></li>
	              <li><a href="#tab-optionsub5" data-toggle="tab">Налоги</a></li>
	              <li><a href="#tab-optionsub6" data-toggle="tab">Учетные записи</a></li>
	              <li><a href="#tab-optionsub7" data-toggle="tab">SMS</a></li>
	              <li><a href="#tab-optionsub8" data-toggle="tab">Оформление заказа</a></li>
	              <li><a href="#tab-optionsub9" data-toggle="tab">Кол-во на складе</a></li>
	              <li><a href="#tab-optionsub10" data-toggle="tab">Партнеры</a></li>
	              <li><a href="#tab-optionsub11" data-toggle="tab">Возвраты</a></li>
	              <li><a href="#tab-optionsub12" data-toggle="tab">Дополнительные опции</a></li>
	            </ul>
	            
	            <div class="tab-pane" id="tab-optionsub1">
	            <fieldset>
	              <legend><i class="fa fa-plus-circle"></i>Элементы</legend>
	              <div class="form-group required">
	                <label class="col-xs-2 control-label" for="input-catalog-limit"><?php echo $entry_catalog_limit; ?></label>
	                <div class="col-xs-10">
	                  <input type="text" name="config_catalog_limit" value="<?php echo $config_catalog_limit; ?>" id="input-catalog-limit" class="form-control" />
	                  
	                  <?php if ($error_catalog_limit) { ?>
	                  <div class="text-danger"><?php echo $error_catalog_limit; ?></div>
	                  <?php } ?>
	                </div>
	              </div>
	
	              <div class="form-group required">
	                <label class="col-xs-2 control-label" for="input-admin-limit"><?php echo $entry_admin_limit; ?></label>
	                <div class="col-xs-10">
	                  <input type="text" name="config_admin_limit" value="<?php echo $config_admin_limit; ?>" id="input-admin-limit" class="form-control" />
	                  
	                  <?php if ($error_admin_limit) { ?>
	                  <div class="text-danger"><?php echo $error_admin_limit; ?></div>
	                  <?php } ?>
	                </div>
	              </div>
	            </fieldset>
	            </div>
	            <div class="tab-pane" id="tab-optionsub2">
	            <fieldset>
	              <legend><i class="fa fa-plus-circle"></i> <?php echo $text_product; ?></legend>
	              <div class="form-group">
	                <label class="col-xs-2 control-label"><?php echo $entry_product_count; ?></label>
	                <div class="col-xs-10">
	            		<div class="btn-group" data-toggle="buttons">
	              			<label class="btn btn-primary<?php if ($config_product_count == 1) { ?> active<?php } ?>">
	            				<i class="fa fa-check"></i> <input type="radio" name="config_product_count" value="1" <?php if ($config_product_count == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	              			</label>
	              			<label class="btn btn-primary<?php if ($config_product_count == 0) { ?> active<?php } ?>">
	            				<i class="fa fa-times"></i> <input type="radio" name="config_product_count" value="0" <?php if ($config_product_count == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	              			</label>
	            		</div>
	                  </div>
	              </div>
	              <div class="form-group">
	                <label class="col-xs-2 control-label" for="input-left_a_bit">Количество для статуса "Заканчивается": </label>
	                <div class="col-xs-10">
	                  <input type="text" name="left_a_bit_quantity" value="<?php echo $left_a_bit_quantity; ?>" id="input-left_a_bit" class="form-control" />
	                </div>
	              </div>              
	              <div class="form-group">
	                <label class="col-xs-2 control-label"><?php echo $entry_download; ?></label>
	                <div class="col-xs-10">
	            		<div class="btn-group" data-toggle="buttons">
	            
	              			<label class="btn btn-primary<?php if ($config_download == 1) { ?> active<?php } ?>">
	                				<i class="fa fa-check"></i> <input type="radio" name="config_download" value="1" <?php if ($config_download == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	              			</label>
	              			<label class="btn btn-primary<?php if ($config_download == 0) { ?> active<?php } ?>">
	                				<i class="fa fa-times"></i> <input type="radio" name="config_download" value="0" <?php if ($config_download == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	              			</label>
	            		</div>
	                </div>
	              </div>
	              <div class="form-group">
	                <label class="col-xs-2 control-label"><?php echo $entry_product_video; ?></label>
	                <div class="col-xs-10">
	            		<div class="btn-group" data-toggle="buttons">
	            
	              			<label class="btn btn-primary<?php if ($config_product_video == 1) { ?> active<?php } ?>">
	                				<i class="fa fa-check"></i> <input type="radio" name="config_product_video" value="1" <?php if ($config_product_video == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	              			</label>
	              			<label class="btn btn-primary<?php if ($config_product_video == 0) { ?> active<?php } ?>">
	                				<i class="fa fa-times"></i> <input type="radio" name="config_product_video" value="0" <?php if ($config_product_video == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	              			</label>
	            		</div>
	                </div>
	              </div>
	          </fieldset>
	          </div>
	          <div class="tab-pane" id="tab-optionsub3">
	          <fieldset>
	              <legend><i class="fa fa-plus-circle"></i> Отзывы</legend>    
	              <!-- Old reviews -->
	              <div class="form-group">
	                <label class="col-xs-2 control-label"><?php echo $entry_review; ?></label>
	                <div class="col-xs-10">
			          <div class="btn-group" data-toggle="buttons">
	  			       <label class="btn btn-primary<?php if ($config_review_status == 1) { ?> active<?php } ?>">
	    				<i class="fa fa-check"></i> <input type="radio" name="config_review_status" value="1" <?php if ($config_review_status == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	  			       </label>
	  			       <label class="btn btn-primary<?php if ($config_review_status == 0) { ?> active<?php } ?>">
	    				<i class="fa fa-times"></i> <input type="radio" name="config_review_status" value="0" <?php if ($config_review_status == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	  			       </label>
			         </div>
	               </div>
	              </div>
	              <!-- Old reviews -->
	              <!-- New reviews -->
	              <div class="form-group">
	                <label class="col-xs-2 control-label">Поле недостатков</label>
	                <div class="col-xs-10">
			          <div class="btn-group" data-toggle="buttons">
	  			       <label class="btn btn-primary<?php if ($config_review_bad == 1) { ?> active<?php } ?>">
	    				<i class="fa fa-check"></i> <input type="radio" name="config_review_bad" value="1" <?php if ($config_review_bad == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	  			       </label>
	  			       <label class="btn btn-primary<?php if ($config_review_bad == 0) { ?> active<?php } ?>">
	    				<i class="fa fa-times"></i> <input type="radio" name="config_review_bad" value="0" <?php if ($config_review_bad == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	  			       </label>
			         </div>
	               </div>
	              </div>
	              <div class="form-group">
	                <label class="col-xs-2 control-label">Поле достоинств</label>
	                <div class="col-xs-10">
			          <div class="btn-group" data-toggle="buttons">
	  			       <label class="btn btn-primary<?php if ($config_review_good == 1) { ?> active<?php } ?>">
	    				<i class="fa fa-check"></i> <input type="radio" name="config_review_good" value="1" <?php if ($config_review_good == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	  			       </label>
	  			       <label class="btn btn-primary<?php if ($config_review_good == 0) { ?> active<?php } ?>">
	    				<i class="fa fa-times"></i> <input type="radio" name="config_review_good" value="0" <?php if ($config_review_good == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	  			       </label>
			         </div>
	               </div>
	              </div>
	              <div class="form-group">
	                <label class="col-xs-2 control-label">Поле фото</label>
	                <div class="col-xs-10">
			          <div class="btn-group" data-toggle="buttons">
	  			       <label class="btn btn-primary<?php if ($config_review_addimage == 1) { ?> active<?php } ?>">
	    				<i class="fa fa-check"></i> <input type="radio" name="config_review_addimage" value="1" <?php if ($config_review_addimage == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	  			       </label>
	  			       <label class="btn btn-primary<?php if ($config_review_addimage == 0) { ?> active<?php } ?>">
	    				<i class="fa fa-times"></i> <input type="radio" name="config_review_addimage" value="0" <?php if ($config_review_addimage == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	  			       </label>
			         </div>
	               </div>
	              </div>
	              <div class="form-group">
	                <label class="col-xs-2 control-label">Поле капчи</label>
	                <div class="col-xs-10">
			          <div class="btn-group" data-toggle="buttons">
	  			       <label class="btn btn-primary<?php if ($config_review_addimage == 1) { ?> active<?php } ?>">
	    				<i class="fa fa-check"></i> <input type="radio" name="config_review_captcha" value="1" <?php if ($config_review_captcha == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	  			       </label>
	  			       <label class="btn btn-primary<?php if ($config_review_addimage == 0) { ?> active<?php } ?>">
	    				<i class="fa fa-times"></i> <input type="radio" name="config_review_captcha" value="0" <?php if ($config_review_captcha == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	  			       </label>
			         </div>
	               </div>
	              </div>
	              
	              <div class="form-group required">
	                <label class="col-xs-2 control-label" for="input-config_review_text_symbol">Мин длина комментария</label>
	                <div class="col-xs-10">
	                  <input type="text" name="config_review_text_symbol" value="<?php $config_review_text_symbol = $config_review_text_symbol ? $config_review_text_symbol : 3; print $config_review_text_symbol; ?>" id="input-config_review_text_symbol" class="form-control" />
	                </div>
	              </div>
	              
	              <div class="form-group">
	                <label class="col-xs-2 control-label">Автопубликация отзывов</label>
	                <div class="col-xs-10">
			          <div class="btn-group" data-toggle="buttons">
	  			       <label class="btn btn-primary<?php if ($config_review_statusp == 1) { ?> active<?php } ?>">
	    				<i class="fa fa-check"></i> <input type="radio" name="config_review_statusp" value="1" <?php if ($config_review_statusp == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	  			       </label>
	  			       <label class="btn btn-primary<?php if ($config_review_statusp == 0) { ?> active<?php } ?>">
	    				<i class="fa fa-times"></i> <input type="radio" name="config_review_statusp" value="0" <?php if ($config_review_statusp == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	  			       </label>
			         </div>
	               </div>
	              </div>
	              <div class="form-group">
	                <label class="col-xs-2 control-label">Оповещение о новом отзыве по e-mail</label>
	                <div class="col-xs-10">
			          <div class="btn-group" data-toggle="buttons">
	  			       <label class="btn btn-primary<?php if ($config_review_statusp == 1) { ?> active<?php } ?>">
	    				<i class="fa fa-check"></i> <input type="radio" name="config_review_email" value="1" <?php if ($config_review_email == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	  			       </label>
	  			       <label class="btn btn-primary<?php if ($config_review_statusp == 0) { ?> active<?php } ?>">
	    				<i class="fa fa-times"></i> <input type="radio" name="config_review_email" value="0" <?php if ($config_review_email == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	  			       </label>
			         </div>
	               </div>
	              </div>
	              <!-- New reviews -->
	            </fieldset>
	            </div>
	            <div class="tab-pane" id="tab-optionsub4">
	            <fieldset>
	              <legend><i class="fa fa-plus-circle"></i> <?php echo $text_voucher; ?></legend>
	              <div class="form-group required">
	                <label class="col-xs-2 control-label" for="input-voucher-min"><?php echo $entry_voucher_min; ?></label>
	                <div class="col-xs-10">
	                  <input type="text" name="config_voucher_min" value="<?php echo $config_voucher_min; ?>" id="input-voucher-min" class="form-control" />
	                  
	                  <?php if ($error_voucher_min) { ?>
	                  <div class="text-danger"><?php echo $error_voucher_min; ?></div>
	                  <?php } ?>
	                </div>
	              </div>
	              <div class="form-group required">
	                <label class="col-xs-2 control-label" for="input-voucher-max"><?php echo $entry_voucher_max; ?></label>
	                <div class="col-xs-10">
	                  <input type="text" name="config_voucher_max" value="<?php echo $config_voucher_max; ?>" id="input-voucher-max" class="form-control" />
	                  
	                  <?php if ($error_voucher_max) { ?>
	                  <div class="text-danger"><?php echo $error_voucher_max; ?></div>
	                  <?php } ?>
	                </div>
	              </div>
	            </fieldset>
	            </div>
	            <div class="tab-pane" id="tab-optionsub5">
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
	            </div>
	            <div class="tab-pane" id="tab-optionsub6">
	            <fieldset>
	              <legend><i class="fa fa-plus-circle"></i> <?php echo $text_account; ?></legend>
	              <div class="form-group">
	                <label class="col-xs-2 control-label"><?php echo $entry_customer_online; ?></label>
	                <div class="col-xs-10">
			<div class="btn-group" data-toggle="buttons">
	
	  			<label class="btn btn-primary<?php if ($config_customer_online == 1) { ?> active<?php } ?>">
	    				<i class="fa fa-check"></i> <input type="radio" name="config_customer_online" value="1" <?php if ($config_customer_online == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	  			</label>
	  			<label class="btn btn-primary<?php if ($config_customer_online == 0) { ?> active<?php } ?>">
	    				<i class="fa fa-times"></i> <input type="radio" name="config_customer_online" value="0" <?php if ($config_customer_online == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	  			</label>
			</div>
	                   </div>
	              </div>
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
	                <label class="col-xs-2 control-label"><?php echo $entry_customer_group_display; ?> </label>
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
	            </div>
                <div class="tab-pane" id="tab-optionsub7">
                    <fieldset>
                        <legend class="fa fa-plus-circle"><i> Настройки SMS шлюза </i></legend>


                        <div class="form-group">
                            <label class="col-xs-2 control-label">SMS Server login: </label>

                            <div class="col-xs-10">
                                <div class="row">
                                    <div class="col-xs-6">
                                        <input type="text" name="config_sms_notifications_login"
                                               value="<?php echo $config_sms_notifications_login; ?>"
                                               class="form-control"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-2 control-label">SMS Server password: </label>

                            <div class="col-xs-10">
                                <div class="row">
                                    <div class="col-xs-6">
                                        <input type="password" name="config_sms_notifications_password"
                                               value="<?php echo $config_sms_notifications_password; ?>"
                                               class="form-control"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-2 control-label">SMS Sign</label>

                            <div class="col-xs-10">
                                <div class="row">
                                    <div class="col-xs-6">
                                        <input type="text" name="config_sms_notifications_sign"
                                               value="<?php echo $config_sms_notifications_sign; ?>"
                                               class="form-control"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <legend class="fa fa-plus-circle"><i> Настройки уведомлений о заказе </i></legend>
                        <div class="form-group">
                            <label class="col-xs-2 control-label"><?php echo $entry_config_sms_notifications; ?></label>

                            <div class="col-xs-10">
                                <div class="btn-group" data-toggle="buttons">
                                    <label class="btn btn-primary<?php if ($config_sms_notifications == 1
                                    ) { ?> active<?php } ?>">
                                        <i class="fa fa-check"></i> <input type="radio" name="config_sms_notifications"
                                                                           value="1" <?php if ($config_sms_notifications
                                                                                               == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
                                    </label>
                                    <label class="btn btn-primary<?php if ($config_sms_notifications == 0
                                    ) { ?> active<?php } ?>">
                                        <i class="fa fa-times"></i> <input type="radio" name="config_sms_notifications"
                                                                           value="0" <?php if ($config_sms_notifications
                                                                                               == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-2 control-label"><?php echo $entry_config_sms_text_customer; ?></label>

                            <div class="col-xs-10">
                                <div class="row">
                                    <div class="col-xs-6">
                                        <input type="text" name="config_sms_notifications_text_customer"
                                               value="<?php echo $config_sms_notifications_text_customer; ?>"
                                               class="form-control"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label
                                class="col-xs-2 control-label"><?php echo $entry_config_sms_notifications_admin; ?></label>

                            <div class="col-xs-10">
                                <div class="btn-group" data-toggle="buttons">
                                    <label class="btn btn-primary<?php if ($config_sms_notifications_admin == 1
                                    ) { ?> active<?php } ?>">
                                        <i class="fa fa-check"></i> <input type="radio"
                                                                           name="config_sms_notifications_admin"
                                                                           value="1"
                                                                           <?php if ($config_sms_notifications_admin
                                                                                     == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
                                    </label>
                                    <label class="btn btn-primary<?php if ($config_sms_notifications_admin == 0
                                    ) { ?> active<?php } ?>">
                                        <i class="fa fa-times"></i> <input type="radio"
                                                                           name="config_sms_notifications_admin"
                                                                           value="0"
                                                                           <?php if ($config_sms_notifications_admin
                                                                                     == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-2 control-label"><?php echo $entry_config_sms_text_admin; ?></label>

                            <div class="col-xs-10">
                                <div class="row">
                                    <div class="col-xs-6">
                                        <input type="text" name="config_sms_notifications_text_admin"
                                               value="<?php echo $config_sms_notifications_text_admin; ?>"
                                               class="form-control"/>
                                    </div>
                                </div>
                            </div>
                        </div>


                    </fieldset>
                </div>
	            <div class="tab-pane" id="tab-optionsub8">
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
	                <label class="col-xs-2 control-label">Использовать методы доставки? </label>
	                <div class="col-xs-10">
	            	  <div class="btn-group" data-toggle="buttons">
	                    <label class="btn btn-primary<?php if ($use_shipping_methods == 1) { ?> active<?php } ?>">
	                      <i class="fa fa-check"></i> <input type="radio" name="use_shipping_methods" value="1" <?php if ($use_shipping_methods == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	                    </label>
	          			<label class="btn btn-primary<?php if ($use_shipping_methods == 0) { ?> active<?php } ?>">
	            		  <i class="fa fa-times"></i> <input type="radio" name="use_shipping_methods" value="0" <?php if ($use_shipping_methods == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	          			</label>
	                  </div>
	                </div>
	              </div>
	              <div class="form-group">
	                <label class="col-xs-2 control-label">Использовать методы оплаты? </label>
	                <div class="col-xs-10">
	            	  <div class="btn-group" data-toggle="buttons">
	                    <label class="btn btn-primary<?php if ($use_payment_methods == 1) { ?> active<?php } ?>">
	                      <i class="fa fa-check"></i> <input type="radio" name="use_payment_methods" value="1" <?php if ($use_payment_methods == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	                    </label>
	          			<label class="btn btn-primary<?php if ($use_payment_methods == 0) { ?> active<?php } ?>">
	            		  <i class="fa fa-times"></i> <input type="radio" name="use_payment_methods" value="0" <?php if ($use_payment_methods == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	          			</label>
	                  </div>
	                </div>
	              </div>
	              <div class="form-group">
	                <label class="col-xs-2 control-label">Использовать страны и регионы? </label>
	                <div class="col-xs-10">
	            	  <div class="btn-group" data-toggle="buttons">
	                    <label class="btn btn-primary<?php if ($use_countries_and_regions == 1) { ?> active<?php } ?>">
	                      <i class="fa fa-check"></i> <input type="radio" name="use_countries_and_regions" value="1" <?php if ($use_countries_and_regions == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	                    </label>
	          			<label class="btn btn-primary<?php if ($use_countries_and_regions == 0) { ?> active<?php } ?>">
	            		  <i class="fa fa-times"></i> <input type="radio" name="use_countries_and_regions" value="0" <?php if ($use_countries_and_regions == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	          			</label>
	                  </div>
	                </div>
	              </div>
	              <div class="form-group">
	                <label class="col-xs-2 control-label">Использовать различные адреса оплаты и доставки? </label>
	                <div class="col-xs-10">
	            	  <div class="btn-group" data-toggle="buttons">
	                    <label class="btn btn-primary<?php if ($use_different_payment_and_delivery_information == 1) { ?> active<?php } ?>">
	                      <i class="fa fa-check"></i> <input type="radio" name="use_different_payment_and_delivery_information" value="1" <?php if ($use_different_payment_and_delivery_information == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	                    </label>
	          			<label class="btn btn-primary<?php if ($use_different_payment_and_delivery_information == 0) { ?> active<?php } ?>">
	            		  <i class="fa fa-times"></i> <input type="radio" name="use_different_payment_and_delivery_information" value="0" <?php if ($use_different_payment_and_delivery_information == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
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
	                <label class="col-xs-2 control-label" for="input-order-edit"><?php echo $entry_order_edit; ?></label>
	                <div class="col-xs-10">
	                  <input type="text" name="config_order_edit" value="<?php echo $config_order_edit; ?>" id="input-order-edit" class="form-control" />
	                   </div>
	              </div>
	              <div class="form-group">
	                <label class="col-xs-2 control-label" for="input-invoice-prefix"><?php echo $entry_invoice_prefix; ?></label>
	                <div class="col-xs-10">
	                  <input type="text" name="config_invoice_prefix" value="<?php echo $config_invoice_prefix; ?>" id="input-invoice-prefix" class="form-control" />
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
	              <div class="form-group">
	                <label class="col-xs-2 control-label" for="input-complete-status"><?php echo $entry_complete_status; ?></label>
	                <div class="col-xs-10">
	                  <select name="config_complete_status_id" id="input-complete-status" class="form-control">
	                    <?php foreach ($order_statuses as $order_status) { ?>
	                    <?php if ($order_status['order_status_id'] == $config_complete_status_id) { ?>
	                    <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
	                    <?php } else { ?>
	                    <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
	                    <?php } ?>
	                    <?php } ?>
	                  </select>
	                   </div>
	              </div>
	            </fieldset>
	            </div>
	            <div class="tab-pane" id="tab-optionsub9">
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
	                <label class="col-xs-2 control-label"><?php echo $entry_stock_warning; ?></label>
	                <div class="col-xs-10">
			<div class="btn-group" data-toggle="buttons">
	
	  			<label class="btn btn-primary<?php if ($config_stock_warning == 1) { ?> active<?php } ?>">
	    				<i class="fa fa-check"></i> <input type="radio" name="config_stock_warning" value="1" <?php if ($config_stock_warning == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	  			</label>
	  			<label class="btn btn-primary<?php if ($config_stock_warning == 0) { ?> active<?php } ?>">
	    				<i class="fa fa-times"></i> <input type="radio" name="config_stock_warning" value="0" <?php if ($config_stock_warning == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
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
	  			<label class="btn btn-primary<?php if ($config_stock_checkout == 0) { ?> active<?php } ?>">
	    				<i class="fa fa-times"></i> <input type="radio" name="config_stock_checkout" value="0" <?php if ($config_stock_checkout == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	  			</label>
			</div>
	                   </div>
	              </div>
	              <div class="form-group">
	                <label class="col-xs-2 control-label" for="input-stock-status"><?php echo $entry_stock_status; ?></label>
	                <div class="col-xs-10">
	                  <select name="config_stock_status_id" id="input-stock-status" class="form-control">
	                    <?php foreach ($stock_statuses as $stock_status) { ?>
	                    <?php if ($stock_status['stock_status_id'] == $config_stock_status_id) { ?>
	                    <option value="<?php echo $stock_status['stock_status_id']; ?>" selected="selected"><?php echo $stock_status['name']; ?></option>
	                    <?php } else { ?>
	                    <option value="<?php echo $stock_status['stock_status_id']; ?>"><?php echo $stock_status['name']; ?></option>
	                    <?php } ?>
	                    <?php } ?>
	                  </select>
	                   </div>
	              </div>
	            </fieldset>
	            </div>
	            <div class="tab-pane" id="tab-optionsub10">
	            <fieldset>
	              <legend><i class="fa fa-plus-circle"></i> <?php echo $text_affiliate; ?></legend>
	              <div class="form-group">
	                <label class="col-xs-2 control-label" for="input-affiliate"><?php echo $entry_affiliate; ?></label>
	                <div class="col-xs-10">
	                  <select name="config_affiliate_id" id="input-affiliate" class="form-control">
	                    <option value="0"><?php echo $text_none; ?></option>
	                    <?php foreach ($informations as $information) { ?>
	                    <?php if ($information['information_id'] == $config_affiliate_id) { ?>
	                    <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
	                    <?php } else { ?>
	                    <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
	                    <?php } ?>
	                    <?php } ?>
	                  </select>
	                   </div>
	              </div>
	              <div class="form-group">
	                <label class="col-xs-2 control-label" for="input-commission"><?php echo $entry_commission; ?></label>
	                <div class="col-xs-10">
	                  <input type="text" name="config_commission" value="<?php echo $config_commission; ?>" id="input-commission" class="form-control" />
	                   </div>
	              </div>
	            </fieldset>
	            </div>
	            <div class="tab-pane" id="tab-optionsub11">
	            <fieldset>
	              <legend><i class="fa fa-plus-circle"></i> <?php echo $text_return; ?></legend>
	              <div class="form-group">
	                <label class="col-xs-2 control-label" for="input-return"><?php echo $entry_return; ?></label>
	                <div class="col-xs-10">
	                  <select name="config_return_id" id="input-return" class="form-control">
	                    <option value="0"><?php echo $text_none; ?></option>
	                    <?php foreach ($informations as $information) { ?>
	                    <?php if ($information['information_id'] == $config_return_id) { ?>
	                    <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
	                    <?php } else { ?>
	                    <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
	                    <?php } ?>
	                    <?php } ?>
	                  </select>
	                   </div>
	              </div>
	              <div class="form-group">
	                <label class="col-xs-2 control-label" for="input-return-status"><?php echo $entry_return_status; ?></label>
	                <div class="col-xs-10">
	                  <select name="config_return_status_id" id="input-return-status" class="form-control">
	                    <?php foreach ($return_statuses as $return_status) { ?>
	                    <?php if ($return_status['return_status_id'] == $config_return_status_id) { ?>
	                    <option value="<?php echo $return_status['return_status_id']; ?>" selected="selected"><?php echo $return_status['name']; ?></option>
	                    <?php } else { ?>
	                    <option value="<?php echo $return_status['return_status_id']; ?>"><?php echo $return_status['name']; ?></option>
	                    <?php } ?>
	                    <?php } ?>
	                  </select>
	                   </div>
	              </div>
	            </fieldset>
	            </div>
	            <div class="tab-pane" id="tab-optionsub12">
	            <fieldset>
	              <legend><i class="fa fa-plus-circle"></i> Дополнительные опции</legend>
	              <div class="form-group">
	                <label class="col-xs-2 control-label">Использовать генерацию номера счета?<i class="fa  fa-question-circle" data-toggle="tooltip" title="Позволяет сгенерировать уникальный номер платежа"></i></label>
	                <div class="col-xs-10">
	            	  <div class="btn-group" data-toggle="buttons">
	                    <label class="btn btn-primary<?php if ($use_order_invoice_number == 1) { ?> active<?php } ?>">
	                      <i class="fa fa-check"></i> <input type="radio" name="use_order_invoice_number" value="1" <?php if ($use_order_invoice_number == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	                    </label>
	          			<label class="btn btn-primary<?php if ($use_order_invoice_number == 0) { ?> active<?php } ?>">
	            		  <i class="fa fa-times"></i> <input type="radio" name="use_order_invoice_number" value="0" <?php if ($use_order_invoice_number == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	          			</label>
	                  </div>
	                </div>
	              </div>
	              <div class="form-group">
	                <label class="col-xs-2 control-label">Использовать процентные скидки продуктов?</label>
	                <div class="col-xs-10">
	            	  <div class="btn-group" data-toggle="buttons">
	                    <label class="btn btn-primary<?php if ($config_product_percent_events == 1) { ?> active<?php } ?>">
	                      <i class="fa fa-check"></i> <input type="radio" name="config_product_percent_events" value="1" <?php if ($config_product_percent_events == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	                    </label>
	          			<label class="btn btn-primary<?php if ($config_product_percent_events == 0) { ?> active<?php } ?>">
	            		  <i class="fa fa-times"></i> <input type="radio" name="config_product_percent_events" value="0" <?php if ($config_product_percent_events == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	          			</label>
	                  </div>
	                </div>
	              </div>
	              <div class="form-group">
	                <label class="col-xs-2 control-label">Краткое описание продукта</label>
	                <div class="col-xs-10">
	            	  <div class="btn-group" data-toggle="buttons">
	                    <label class="btn btn-primary<?php if ($config_short_product_description == 1) { ?> active<?php } ?>">
	                      <i class="fa fa-check"></i> <input type="radio" name="config_short_product_description" value="1" <?php if ($config_short_product_description == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	                    </label>
	          			<label class="btn btn-primary<?php if ($config_short_product_description == 0) { ?> active<?php } ?>">
	            		  <i class="fa fa-times"></i> <input type="radio" name="config_short_product_description" value="0" <?php if ($config_short_product_description == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	          			</label>
	                  </div>
	                </div>
	              </div>
	              <div class="form-group">
	                <label class="col-xs-2 control-label">Краткое описание категории (вверху)</label>
	                <div class="col-xs-10">
	            	  <div class="btn-group" data-toggle="buttons">
	                    <label class="btn btn-primary<?php if ($config_short_category_description == 1) { ?> active<?php } ?>">
	                      <i class="fa fa-check"></i> <input type="radio" name="config_short_category_description" value="1" <?php if ($config_short_category_description == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	                    </label>
	          			<label class="btn btn-primary<?php if ($config_short_category_description == 0) { ?> active<?php } ?>">
	            		  <i class="fa fa-times"></i> <input type="radio" name="config_short_category_description" value="0" <?php if ($config_short_category_description == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	          			</label>
	                  </div>
	                </div>
	              </div>
	              <div class="form-group">
	                <label class="col-xs-2 control-label">Список подкатегорий (над контентом)</label>
	                <div class="col-xs-10">
	            	  <div class="btn-group" data-toggle="buttons">
	                    <label class="btn btn-primary<?php if ($config_subcategory_list == 1) { ?> active<?php } ?>">
	                      <i class="fa fa-check"></i> <input type="radio" name="config_subcategory_list" value="1" <?php if ($config_subcategory_list == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	                    </label>
	          			<label class="btn btn-primary<?php if ($config_subcategory_list == 0) { ?> active<?php } ?>">
	            		  <i class="fa fa-times"></i> <input type="radio" name="config_subcategory_list" value="0" <?php if ($config_subcategory_list == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	          			</label>
	                  </div>
	                </div>
	              </div>
	              <div class="form-group">
	                <label class="col-xs-2 control-label">Полное описание категории (внизу)</label>
	                <div class="col-xs-10">
	            	  <div class="btn-group" data-toggle="buttons">
	                    <label class="btn btn-primary<?php if ($config_full_category_description == 1) { ?> active<?php } ?>">
	                      <i class="fa fa-check"></i> <input type="radio" name="config_full_category_description" value="1" <?php if ($config_full_category_description == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	                    </label>
	          			<label class="btn btn-primary<?php if ($config_full_category_description == 0) { ?> active<?php } ?>">
	            		  <i class="fa fa-times"></i> <input type="radio" name="config_full_category_description" value="0" <?php if ($config_full_category_description == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	          			</label>
	                  </div>
	                </div>
	              </div>
	              <div class="form-group">
	                <label class="col-xs-2 control-label">Дополнительное описание категории (на страницах пагинации)</label>
	                <div class="col-xs-10">
	            	  <div class="btn-group" data-toggle="buttons">
	                    <label class="btn btn-primary<?php if ($config_additional_category_description == 1) { ?> active<?php } ?>">
	                      <i class="fa fa-check"></i> <input type="radio" name="config_additional_category_description" value="1" <?php if ($config_additional_category_description == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	                    </label>
	          			<label class="btn btn-primary<?php if ($config_additional_category_description == 0) { ?> active<?php } ?>">
	            		  <i class="fa fa-times"></i> <input type="radio" name="config_additional_category_description" value="0" <?php if ($config_additional_category_description == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	          			</label>
	                  </div>
	                </div>
	              </div>
	              <div class="form-group">
	                <label class="col-xs-2 control-label">Связанные продукты (на карточке продукта)</label>
	                <div class="col-xs-10">
	            	  <div class="btn-group" data-toggle="buttons">
	                    <label class="btn btn-primary<?php if ($config_additional_products_list == 1) { ?> active<?php } ?>">
	                      <i class="fa fa-check"></i> <input type="radio" name="config_additional_products_list" value="1" <?php if ($config_additional_products_list == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	                    </label>
	          			<label class="btn btn-primary<?php if ($config_additional_products_list == 0) { ?> active<?php } ?>">
	            		  <i class="fa fa-times"></i> <input type="radio" name="config_additional_products_list" value="0" <?php if ($config_additional_products_list == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	          			</label>
	                  </div>
	                </div>
	              </div>
	              <div class="form-group">
	                <label class="col-xs-2 control-label">Оптовые цены</label>
	                <div class="col-xs-10">
	            	  <div class="btn-group" data-toggle="buttons">
	                    <label class="btn btn-primary<?php if ($config_whole_sale_price == 1) { ?> active<?php } ?>">
	                      <i class="fa fa-check"></i> <input type="radio" name="config_whole_sale_price" value="1" <?php if ($config_whole_sale_price == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	                    </label>
	          			<label class="btn btn-primary<?php if ($config_whole_sale_price == 0) { ?> active<?php } ?>">
	            		  <i class="fa fa-times"></i> <input type="radio" name="config_whole_sale_price" value="0" <?php if ($config_whole_sale_price == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	          			</label>
	                  </div>
	                </div>
	              </div>
	              <div class="form-group">
	                <label for="input-config_whole_sale_price_quantity" class="col-xs-2 control-label">Оптовая цена от (количество)</label>
	                <div class="col-xs-10">
	                    <input type="text" name="config_whole_sale_price_quantity" value="<?php echo $config_whole_sale_price_quantity; ?>" id="input-config_whole_sale_price_quantity" class="form-control" />
	                </div>
	              </div>
	              <div class="form-group">
	                <label class="col-xs-2 control-label">Бонусная программа</label>
	                <div class="col-xs-10">
	            	  <div class="btn-group" data-toggle="buttons">
	                    <label class="btn btn-primary<?php if ($config_bonus_points == 1) { ?> active<?php } ?>">
	                      <i class="fa fa-check"></i> <input type="radio" name="config_bonus_points" value="1" <?php if ($config_bonus_points == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	                    </label>
	          			<label class="btn btn-primary<?php if ($config_bonus_points == 0) { ?> active<?php } ?>">
	            		  <i class="fa fa-times"></i> <input type="radio" name="config_bonus_points" value="0" <?php if ($config_bonus_points == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	          			</label>
	                  </div>
	                </div>
	              </div>
	              <div class="form-group">
	                <label class="col-xs-2 control-label">Отображать цену продуктов? </label>
	                <div class="col-xs-10">
	            	  <div class="btn-group" data-toggle="buttons">
	                    <label class="btn btn-primary<?php if ($config_display_product_price == 1) { ?> active<?php } ?>">
	                      <i class="fa fa-check"></i> <input type="radio" name="config_display_product_price" value="1" <?php if ($config_display_product_price == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	                    </label>
	          			<label class="btn btn-primary<?php if ($config_display_product_price == 0) { ?> active<?php } ?>">
	            		  <i class="fa fa-times"></i> <input type="radio" name="config_display_product_price" value="0" <?php if ($config_display_product_price == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	          			</label>
	                  </div>
	                </div>
	              </div>
	              <div class="form-group">
	                <label class="col-xs-2 control-label">Использовать Highslide? </label>
	                <div class="col-xs-10">
	            	  <div class="btn-group" data-toggle="buttons">
	                    <label class="btn btn-primary<?php if ($config_use_highslide == 1) { ?> active<?php } ?>">
	                      <i class="fa fa-check"></i> <input type="radio" name="config_use_highslide" value="1" <?php if ($config_use_highslide == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	                    </label>
	          			<label class="btn btn-primary<?php if ($config_use_highslide == 0) { ?> active<?php } ?>">
	            		  <i class="fa fa-times"></i> <input type="radio" name="config_use_highslide" value="0" <?php if ($config_use_highslide == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	          			</label>
	                  </div>
	                </div>
	              </div>
	              <div class="form-group">
	                <label class="col-xs-2 control-label">Показывать обратный отсчет на акционных товарах</label>
	                <div class="col-xs-10">
	            	  <div class="btn-group" data-toggle="buttons">
	                    <label class="btn btn-primary<?php if ($config_use_countdown == 1) { ?> active<?php } ?>">
	                      <i class="fa fa-check"></i> <input type="radio" name="config_use_countdown" value="1" <?php if ($config_use_countdown == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
	                    </label>
	          			<label class="btn btn-primary<?php if ($config_use_countdown == 0) { ?> active<?php } ?>">
	            		  <i class="fa fa-times"></i> <input type="radio" name="config_use_countdown" value="0" <?php if ($config_use_countdown == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
	          			</label>
	                  </div>
	                </div>
	              </div>
	             
	              <?php /* Config for labels marked as new product */ ?>
	              <div class="form-group">
	                <label class="col-xs-2 control-label" for="input-latestlabel-tr">
	                	Лэйбл новиники
	                	<i class="fa  fa-question-circle" data-toggle="tooltip" title="Продукты с этим промо тегом будут включены в список новинок на соответствующей странице"></i>
	                	
	                </label>
	                <div class="col-xs-10">
	                  <select name="config_last_promo_tr" id="input-latestlabel-tr" class="form-control">
	                    <?php foreach ($promo_last_tr as $promo_tag) { ?>
	                    <?php if ($promo_tag['promo_tags_id'] == $config_last_promo_tr) { ?>
	                    <option value="<?php echo $promo_tag['promo_tags_id']; ?>" selected="selected"><?php echo $promo_tag['promo_text']; ?></option>
	                    <?php } else { ?>
	                    <option value="<?php echo $promo_tag['promo_tags_id']; ?>"><?php echo $promo_tag['promo_text']; ?></option>
	                    <?php } ?>
	                    <?php } ?>
	                  </select>
	                   </div>
	              </div>
	              <?php /* Config for labels marked as new product */ ?>
	            </fieldset>
	            </div>
	            </div>
          </div>
          <div class="tab-pane" id="tab-image">
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-logo"><?php echo $entry_logo; ?></label>
              <div class="col-xs-10"> <img src="<?php echo $logo; ?>" alt="" id="thumb-logo" />
                <input type="hidden" name="config_logo" value="<?php echo $config_logo; ?>" id="logo"/>
                <br />
                <br />
                <div class="btn-group">
                  <button class="btn btn-info" title="<?php echo $text_browse; ?>" data-toggle="modal" data-target="#dialog" onclick="image_upload('logo', 'thumb-logo');"><span class="fa fa-pencil"></span> <?php echo $text_browse; ?></button>
                  <button onclick="$(this).parent().parent().find('img').attr('src', '<?php echo $no_image; ?>'); $(this).parent().parent().find('input').attr('value', '');return false;" class="btn btn-danger"><span class="fa fa-trash-o"></span> <?php echo $text_clear; ?></button>
                </div>
              </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-icon"><?php echo $entry_icon; ?></label>
              <div class="col-xs-10">
                <div class="image"><img src="<?php echo $icon; ?>" alt="" id="thumb-icon" />
                  <input type="hidden" name="config_icon" value="<?php echo $config_icon; ?>" id="icon"/>
                  <br />
                  <br />
                  <div class="btn-group">
                  <button class="btn btn-info" title="<?php echo $text_browse; ?>" data-toggle="modal" data-target="#dialog" onclick="image_upload('icon', 'thumb-icon');"><span class="fa fa-pencil"></span> <?php echo $text_browse; ?></button>
                    <button onclick="$(this).parent().parent().find('img').attr('src', '<?php echo $no_image; ?>'); $(this).parent().parent().find('input').attr('value', '');return false;" class="btn btn-danger"><span class="fa fa-trash-o"></span> <?php echo $text_clear; ?></button>
                  </div>
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
              <label class="col-xs-2 control-label" for="input-image-related"><?php echo $entry_image_related; ?></label>
              <div class="col-xs-10">
                <div class="row">
                  <div class="col-xs-6">
                    <input type="text" name="config_image_related_width" value="<?php echo $config_image_related_width; ?>" id="input-image-related" class="form-control" />
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
              <label class="col-xs-2 control-label" for="input-image-compare"><?php echo $entry_image_compare; ?></label>
              <div class="col-xs-10">
                <div class="row">
                  <div class="col-xs-6">
                    <input type="text" name="config_image_compare_width" value="<?php echo $config_image_compare_width; ?>" id="input-image-compare" class="form-control" />
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
              <label class="col-xs-2 control-label" for="input-image-wishlist"><?php echo $entry_image_wishlist; ?></label>
              <div class="col-xs-10">
                <div class="row">
                  <div class="col-xs-6">
                    <input type="text" name="config_image_wishlist_width" value="<?php echo $config_image_wishlist_width; ?>" id="input-image-wishlist" class="form-control" />
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
              <label class="col-xs-2 control-label" for="input-image-cart"><?php echo $entry_image_cart; ?></label>
              <div class="col-xs-10">
                <div class="row">
                  <div class="col-xs-6">
                    <input type="text" name="config_image_cart_width" value="<?php echo $config_image_cart_width; ?>" id="input-image-cart" class="form-control" />
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
          <div class="tab-pane" id="tab-ftp">
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-ftp-host"><?php echo $entry_ftp_host; ?></label>
              <div class="col-xs-10">
                <input type="text" name="config_ftp_host" value="<?php echo $config_ftp_host; ?>" id="input-ftp-host" class="form-control" />
                <?php if ($error_ftp_host) { ?>
                <div class="text-danger"><?php echo $error_ftp_host; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-ftp-port"><?php echo $entry_ftp_port; ?></label>
              <div class="col-xs-10">
                <input type="text" name="config_ftp_port" value="<?php echo $config_ftp_port; ?>" id="input-ftp-port" class="form-control" />
                <?php if ($error_ftp_port) { ?>
                <div class="text-danger"><?php echo $error_ftp_port; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-ftp-username"><?php echo $entry_ftp_username; ?></label>
              <div class="col-xs-10">
                <input type="text" name="config_ftp_username" value="<?php echo $config_ftp_username; ?>" id="input-ftp-username" class="form-control" />
                <?php if ($error_ftp_username) { ?>
                <div class="text-danger"><?php echo $error_ftp_username; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-ftp-password"><?php echo $entry_ftp_password; ?></label>
              <div class="col-xs-10">
                <input type="text" name="config_ftp_password" value="<?php echo $config_ftp_password; ?>" id="input-ftp-password" class="form-control" />
                <?php if ($error_ftp_password) { ?>
                <div class="text-danger"><?php echo $error_ftp_password; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-ftp-root"><?php echo $entry_ftp_root; ?></label>
              <div class="col-xs-10">
                <input type="text" name="config_ftp_root" value="<?php echo $config_ftp_root; ?>" id="input-ftp-root" class="form-control" />
                 </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label"><?php echo $entry_ftp_status; ?></label>
              <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($config_ftp_status == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="config_ftp_status" value="1" <?php if ($config_ftp_status == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($config_ftp_status == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="config_ftp_status" value="0" <?php if ($config_ftp_status == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
              </div>
            </div>
          </div>
          <div class="tab-pane" id="tab-mail">
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-mail-protocol"><?php echo $entry_mail_protocol; ?></label>
              <div class="col-xs-10">
                <select name="config_mail_protocol" id="input-mail-protocol" class="form-control">
                  <?php if ($config_mail_protocol == 'mail') { ?>
                  <option value="mail" selected="selected"><?php echo $text_mail; ?></option>
                  <?php } else { ?>
                  <option value="mail"><?php echo $text_mail; ?></option>
                  <?php } ?>
                  <?php if ($config_mail_protocol == 'smtp') { ?>
                  <option value="smtp" selected="selected"><?php echo $text_smtp; ?></option>
                  <?php } else { ?>
                  <option value="smtp"><?php echo $text_smtp; ?></option>
                  <?php } ?>
                </select>
                 </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-mail-parameter"><?php echo $entry_mail_parameter; ?></label>
              <div class="col-xs-10">
                <input type="text" name="config_mail_parameter" value="<?php echo $config_mail_parameter; ?>" id="input-mail-parameter" class="form-control" />
                 </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-smtp-host"><?php echo $entry_smtp_host; ?></label>
              <div class="col-xs-10">
                <input type="text" name="config_smtp_host" value="<?php echo $config_smtp_host; ?>" id="input-smtp-host" class="form-control" />
              </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-smtp-username"><?php echo $entry_smtp_username; ?></label>
              <div class="col-xs-10">
                <input type="text" name="config_smtp_username" value="<?php echo $config_smtp_username; ?>" id="input-smtp-username" class="form-control" />
              </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-smtp-password"><?php echo $entry_smtp_password; ?></label>
              <div class="col-xs-10">
                <input type="text" name="config_smtp_password" value="<?php echo $config_smtp_password; ?>" id="input-smtp-password" class="form-control" />
              </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-smtp-port"><?php echo $entry_smtp_port; ?></label>
              <div class="col-xs-10">
                <input type="text" name="config_smtp_port" value="<?php echo $config_smtp_port; ?>" id="input-smtp-port" class="form-control" />
              </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-smtp-timeout"><?php echo $entry_smtp_timeout; ?></label>
              <div class="col-xs-10">
                <input type="text" name="config_smtp_timeout" value="<?php echo $config_smtp_timeout; ?>" id="input-smtp-timeout" class="form-control" />
              </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label"><?php echo $entry_alert_mail; ?></label>
              <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($config_alert_mail == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="config_alert_mail" value="1" <?php if ($config_alert_mail == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($config_alert_mail == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="config_alert_mail" value="0" <?php if ($config_alert_mail == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
                 </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label"><?php echo $entry_account_mail; ?></label>
              <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($config_account_mail == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="config_account_mail" value="1" <?php if ($config_account_mail == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($config_account_mail == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="config_account_mail" value="0" <?php if ($config_account_mail == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
                 </div>
            </div>

            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-alert-email"><?php echo $entry_alert_emails; ?></label>
              <div class="col-xs-10">
                <textarea name="config_alert_emails" rows="5" id="input-alert-email" class="form-control"><?php echo $config_alert_emails; ?></textarea>
                 </div>
            </div>
          </div>
          <div class="tab-pane" id="tab-fraud">
            <div class="form-group">
              <label class="col-xs-2 control-label"><?php echo $entry_fraud_detection; ?></label>
              <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($config_fraud_detection == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="config_fraud_detection" value="1" <?php if ($config_fraud_detection == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($config_fraud_detection == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="config_fraud_detection" value="0" <?php if ($config_fraud_detection == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
                 </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-fraud-key"><?php echo $entry_fraud_key; ?></label>
              <div class="col-xs-10">
                <input type="text" name="config_fraud_key" value="<?php echo $config_fraud_key; ?>" id="input-fraud-key" class="form-control" />
              </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-fraud-score"><?php echo $entry_fraud_score; ?></label>
              <div class="col-xs-10">
                <input type="text" name="config_fraud_score" value="<?php echo $config_fraud_score; ?>" id="input-fraud-score" class="form-control" />
                 </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-fraud-status"><?php echo $entry_fraud_status; ?></label>
              <div class="col-xs-10">
                <select name="config_fraud_status_id" id="input-fraud-status" class="form-control">
                  <?php foreach ($order_statuses as $order_status) { ?>
                  <?php if ($order_status['order_status_id'] == $config_fraud_status_id) { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
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
            <div class="form-group">
              <label class="col-xs-2 control-label"><?php echo $entry_shared; ?></label>
              <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($config_shared == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="config_shared" value="1" <?php if ($config_shared == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($config_shared == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="config_shared" value="0" <?php if ($config_shared == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
                 </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-robots"><?php echo $entry_robots; ?></label>
              <div class="col-xs-10">
                <textarea name="config_robots" rows="5" id="input-robots" class="form-control"><?php echo $config_robots; ?></textarea>
                 </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label"><?php echo $entry_seo_url; ?></label>
              <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($config_seo_url == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="config_seo_url" value="1" <?php if ($config_seo_url == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($config_seo_url == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="config_seo_url" value="0" <?php if ($config_seo_url == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
                 </div>
            </div>
          
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-file-extension-allowed"><?php echo $entry_file_extension_allowed; ?></label>
              <div class="col-xs-10">
                <textarea name="config_file_extension_allowed" rows="5" id="input-file-extension-allowed" class="form-control"><?php echo $config_file_extension_allowed; ?></textarea>
                 </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-file-mime-allowed"><?php echo $entry_file_mime_allowed; ?></label>
              <div class="col-xs-10">
                <textarea name="config_file_mime_allowed" cols="60" rows="5" id="input-file-mime-allowed" class="form-control"><?php echo $config_file_mime_allowed; ?></textarea>
                 </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label"><?php echo $entry_maintenance; ?></label>
              <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($config_maintenance == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="config_maintenance" value="1" <?php if ($config_maintenance == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($config_maintenance == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="config_maintenance" value="0" <?php if ($config_maintenance == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
                 </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label"><?php echo $entry_password; ?></label>
              <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($config_password == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="config_password" value="1" <?php if ($config_password == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($config_password == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="config_password" value="0" <?php if ($config_password == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
                 </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-encryption"><?php echo $entry_encryption; ?></label>
              <div class="col-xs-10">
                <input type="text" name="config_encryption" value="<?php echo $config_encryption; ?>" id="input-encryption" class="form-control" />
                
                <?php if ($error_encryption) { ?>
                <div class="text-danger"><?php echo $error_encryption; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-compression"><?php echo $entry_compression; ?></label>
              <div class="col-xs-10">
                <input type="text" name="config_compression" value="<?php echo $config_compression; ?>" id="input-compression" class="form-control" />
                </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label"><?php echo $entry_error_display; ?></label>
              <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($config_error_display == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="config_error_display" value="1" <?php if ($config_error_display == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($config_error_display == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="config_error_display" value="0" <?php if ($config_error_display == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
              </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label"><?php echo $entry_error_log; ?></label>
              <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($config_error_log == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="config_error_log" value="1" <?php if ($config_error_log == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($config_error_display == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="config_error_log" value="0" <?php if ($config_error_log == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
              </div>
            </div>
            <div class="form-group required">
              <label class="col-xs-2 control-label" for="input-error-filename"><?php echo $entry_error_filename; ?></label>
              <div class="col-xs-10">
                <input type="text" name="config_error_filename" value="<?php echo $config_error_filename; ?>" id="input-error-filename" class="form-control" />
                <?php if ($error_error_filename) { ?>
                <div class="text-danger"><?php echo $error_error_filename; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-google-analytics"><?php echo $entry_google_analytics; ?></label>
              <div class="col-xs-10">
                <textarea name="config_google_analytics" rows="5" id="input-google-analytics" class="form-control"><?php echo $config_google_analytics; ?></textarea>
                 </div>
            </div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('#tab-optionsub a:first').tab('show');
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
		url: 'index.php?route=setting/setting/country&token=<?php echo $token; ?>&country_id=' + this.value,
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
<script type="text/javascript">
$(document).on('click', '#add-contact', function(){
	addContactElement();
});

$(document).on('click', '.remove-contact-element',  function(){
	$(this).parent('.contact-element').remove();
});

$(document).on('click', '.remove-contact-phone',  function(){
	$(this).parent('.phone-element').remove();
});

$(document).on('click', '.add-contact-phone',  function(){
	var contactElementRow = 0;
		contactElementRow = $(this).parent('div').parent('div').parent('div').attr('element-number');
	addContactPhone(contactElementRow);
});

$(document).on('click', '.add-contact-email',  function(){
	var contactElementRow = 0;
		contactElementRow = $(this).parent('div').parent('div').parent('div').attr('element-number');
	addContactEmail(contactElementRow);
});


$(document).on('click', '.remove-contact-email',  function(){
	$(this).parent('.email-element').remove();
});




function addContactPhone(contactElementRow) {
	var language_id = $('.contact-tabs li.active').attr('language-id');
	var contactElementPhoneRow = 0;
		contactElementPhoneRow = $('#tab-contact-' + language_id + ' .contact-element[element-number="' + contactElementRow + '"] .contact-phones > .phone-group > .phone-element').last().attr('pe-index');
	
 	if(!contactElementPhoneRow) {
 		contactElementPhoneRow = 1;
 	} else {
 		contactElementPhoneRow++;
 	}
	
	var html = '';
	html += '<div class="phone-element" pe-index="' + contactElementPhoneRow + '">';
	html += '    <label class="col-xs-2 control-label" for="input-contact-phones-' + contactElementRow + '-' + contactElementPhoneRow + '">Телефон (' + contactElementPhoneRow + '): </label>';
	html += '    <div class="col-xs-10">';
	html += '	    <input type="text" name="config_contacts[' + language_id + '][' + contactElementRow + '][phones][' + contactElementPhoneRow + ']" value="" id="input-contact-phones-' + contactElementRow + '-' + contactElementPhoneRow + '" class="form-control" />';
	html += '    </div>';
	html += '    <span class="button btn btn-danger remove-contact-phone">Удалить</span>';
	html += '</div>';

	$('#tab-contact-' + language_id + ' .contact-element[element-number=' + contactElementRow + '] > div > .contact-phones > .phone-group').append(html);
}

function addContactEmail(contactElementRow) {
	var language_id = $('.contact-tabs li.active').attr('language-id');
	var contactElementEmailRow = 0;
	contactElementEmailRow = $('#tab-contact-' + language_id + ' .contact-element[element-number="' + contactElementRow + '"] .contact-emails > .email-group > .email-element').last().attr('ee-index');
	
 	if(!contactElementEmailRow) {
 		contactElementEmailRow = 1;
 	} else {
 		contactElementEmailRow++;
 	}
	var html = '';
	html += '<div class="email-element" ee-index="' + contactElementEmailRow + '">';
	html += '    <label class="col-xs-2 control-label" for="input-contact-emails-' + contactElementRow + '-' + contactElementEmailRow + '">Email (' + contactElementEmailRow + '): </label>';
	html += '    <div class="col-xs-10">';
	html += '	    <input type="text" name="config_contacts[' + language_id + '][' + contactElementRow + '][emails][' + contactElementEmailRow + ']" value="" id="input-contact-emails-' + contactElementRow + '-' + contactElementEmailRow + '" class="form-control" />';
	html += '    </div>';
	html += '    <span class="button btn btn-danger remove-contact-email">Удалить</span>';
	html += '</div>';
	
	$('#tab-contact-' + language_id + ' .contact-element[element-number=' + contactElementRow + '] > div > .contact-emails > .email-group').append(html);	
}

function addContactElement() {
	var language_id = $('.contact-tabs li.active').attr('language-id');
	var contactRow = 0;
	contactRow =  $('#tab-contact-' + language_id + ' > .contact-elements > .contact-element').last().attr('element-number');
	if(!contactRow) {
		contactRow = 0;
 	} else {
 		contactRow++;
 	}
	var html = '';
	html += '<div class="row contact-element element-' + contactRow + '" element-number="' + contactRow + '">';
	html += '	<div class="form-group">';
	html += '    	<label class="col-xs-2 control-label" for="input-contact-name-' + contactRow + '">Название/Имя: </label>';
	html += '    	<div class="col-xs-10">';
	html += '    		<input type="text" name="config_contacts[' + language_id + '][' + contactRow + '][name]" value="" id="input-contact-name-' + contactRow + '" class="form-control" />';
	html += '    	</div>';
	html += '    	<label class="col-xs-2 control-label" for="input-contact-description-' + contactRow + '">Описание: </label>';
	html += '    	<div class="col-xs-10">';
	html += '    		<input type="text" name="config_contacts[' + language_id + '][' + contactRow + '][description]" value="" id="input-contact-description-' + contactRow + '" class="form-control" />';
	html += '    	</div>';
	html += '    	<label class="col-xs-2 control-label" for="input-contact-class-' + contactRow + '">CSS Class: </label>';
	html += '    	<div class="col-xs-10">';
	html += '    		<input type="text" name="config_contacts[' + language_id + '][' + contactRow + '][class]" value="" id="input-contact-class-' + contactRow + '" class="form-control" />';
	html += '    	</div>';
	html += '    	<div class="contact-phones">';
	html += '    		<div class="phone-group">';
	html += '    		</div>';
	html += '    		<span class="button btn btn-success add-contact-phone">Добавить телефон</span>';
	html += '    	</div>';
	html += '    	<div class="contact-emails">';
	html += '    		<div class="email-group">';
	html += '    		</div>';
	html += '    		<span class="button btn btn-success add-contact-email">Добавить email</span>';
	html += '    	</div>';
	html += '    </div>';
	html += '    <span class="button btn btn-danger remove-contact-element">Удалить блок контактов</span>';
	html += '</div>';
	
	$('#tab-contact-' + language_id + ' > .contact-elements').append(html);
	
	return true;
}
</script>
<?php echo $footer; ?>
