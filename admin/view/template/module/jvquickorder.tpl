<?php echo $header; ?>
<div id="content" class="container">
    <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
    </ul>
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger">
        <i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
        <div class="panel-heading">
		 <div class="pull-right btn-group">
			<a onclick="sav_con()" class="btn btn-success"><span><?php echo $button_save_stay; ?></span></a>
			<a onclick="$('#form').submit();" class="btn btn-primary"><span><?php echo $button_save; ?></span></a>
			<a onclick="location = '<?php echo $cancel; ?>';" class="btn btn-danger"><span><?php echo $button_cancel; ?></span></a>
		</div>
		<h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
	  </div>
	  
	  <div class="panel-body">
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">		  						
			<ul id="settings" class="htabs nav nav-tabs">
					<li class="active"><a href="#tab-common" data-toggle="tab">
						<?php echo $tab_text_common; ?>
					</a></li>
					
					<li><a href="#tab-appearance" data-toggle="tab">
						<?php echo $tab_text_appearance; ?>
					</a></li>
					
					<li><a href="#tab-fields" data-toggle="tab">
						<?php echo $tab_text_fields; ?>
					<li></a></li>
					
					<li><a href="#tab-email" data-toggle="tab">
						<?php echo $tab_text_email; ?>
					</a></li>
					
					<li><a href="#tab-order" data-toggle="tab">
						<?php echo $tab_text_order; ?>
					</a></li>
					
					<li><a href="#tab-system-settings" data-toggle="tab">
						<?php echo $tab_text_system_settings; ?>
					</a></li>
					
			</ul>
			 <div class="tab-content">
			<div id="tab-common" class="tab-pane active">
				 <table class="table table-striped table-bordered table-hover">
				  <tr>
					<td>
						<h3><?php echo $entry_offon; ?></h3>
					</td>
					
					<td class="left">
						<select class="form-control" name="jvquickorder_status">
						<?php if ($jvquickorder_status == '1') { ?>
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
					<td><?php echo $entry_work_in_categories; ?></td>
					<td>
					<div class="scrollbox">
					  <?php $class = 'odd'; ?>
					  <?php foreach ($categories as $category) { ?>				  
						  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
						  <div class="<?php echo $class; ?>"> 					
							<?php if (isset($config_var_category[$category['category_id']]) && ($category['category_id'] == $config_var_category[$category['category_id']])) { ?>						
							<input type="checkbox" name="config_var_category[<?php echo $category['category_id']; ?>]" value="<?php echo $category['category_id']; ?>" checked="checked" />
							
							<a href="<?php echo $category['href']; ?>" target="_blank"><?php echo $category['name']; ?></a>
													
							<?php } else { ?>
							<input type="checkbox" name="config_var_category[<?php echo $category['category_id']; ?>]" value="<?php echo $category['category_id']; ?>" />
							
							<a href="<?php echo $category['href']; ?>" target="_blank"><?php echo $category['name']; ?></a>
							
							<?php } ?>
						  </div>
					  <?php } ?>
					</div>
					<a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a>
					</td>
				  </tr>
				  
				  <tr>
					<td>
						<?php echo $entry_in_stock; ?>
					</td>
					
					<td class="left">
						<select class="form-control" name="consider_in_stock">
						<?php if ($consider_in_stock == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>
  
				</table>
			</div>
			
			<div id="tab-appearance" class="tab-pane">
				 <table class="table table-striped table-bordered table-hover">

				  <tr>
					<td>
						<?php echo $entry_show_product_name_price; ?>
					</td>
					
					<td class="left">
						<select class="form-control" name="show_product_name_price">
						<?php if ($show_product_name_price == '1') { ?>
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
					<td>
						<?php echo $entry_show_product_desc; ?>
					</td>
					
					<td class="left">
						<select class="form-control" name="show_product_desc">
						<?php if ($show_product_desc == '1') { ?>
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
					<td>
						<?php echo $entry_show_product_images; ?>
					</td>
					
					<td class="left">
						<select class="form-control" name="show_product_images">
						<?php if ($show_product_images == '1') { ?>
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
					<td>
						<?php echo $entry_type_product_images; ?>
					</td>
					
					<td class="left">						
						<select class="form-control" name="type_product_images" >
							<?php foreach($type_product_images_option as $key => $value) { ?>
								<option value="<?php echo $key;?>" <?php if ($type_product_images == $key) { echo " selected"; }?> >
									<?php echo $value;?>
								</option>
							<?php } ?>
						</select>
					</td>				
				  </tr>  
				  
				  <tr>
					<td><?php echo $entry_title_before_form; ?></td>
					<td>
						<?php foreach ($languages as $language) { ?>
						  <input type="text" class="form-control" name="title_before_form[<?php echo $language['language_id']; ?>]" value="<?php echo isset($title_before_form[$language['language_id']]) ? $title_before_form[$language['language_id']] : ''; ?>"  size="100" />
						  &nbsp;<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br /><br />
						<?php } ?>
					</td>
				  </tr>
				  
				  <tr>
					  <td><?php echo $entry_text_before_form; ?></td>
					  
					  <td>
			
						  <ul class="nav nav-tabs" id="language-123">
                                <?php $i=0; foreach ($languages as $language) { ?>
                                <li class="<?php if( $i == 0): ?> active <?php endif; ?>"><a href="#tab-language-123-<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
                                <?php $i++; } ?>
                         </ul> 
						  
						  <div class="tab-content"> 
                                <?php $i=0; foreach ($languages as $language) { ?>
        						  <div id="tab-language-123-<?php echo $language['language_id']; ?>" class="tab-pane <?php if ($i == 0): ?> active <?php endif; ?>">						
    							     <textarea class="form-control" rows="8" cols="100" name="text_before_form[<?php echo $language['language_id']; ?>]" id="description-<?php echo $language['language_id']; ?>"><?php echo isset($text_before_form[$language['language_id']]) ? $text_before_form[$language['language_id']] : ''; ?></textarea>		  			
        						  </div>
    						  <?php $i++; } ?>
						  	  </div>
					  </td>		
				  </tr>
				  
				  <tr >
					<td style="padding-bottom: 20px;">
					</td>
					
					<td>
					</td>
				  </tr>
				  
				  <tr>
					<td>
						<?php echo $entry_show_popover; ?>
					</td>
					
					<td class="left">
						<select class="form-control" name="show_popover">
						<?php if ($show_popover == '1') { ?>
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
					<td>
						<?php echo $entry_colour_button_quickorder; ?>
					</td>
					
					<td class="left">						
						<select class="form-control" name="type_colour_button_quickorder" >
							<?php foreach($colour_button_quickorder_option as $key => $value) { ?>
								<option value="<?php echo $key;?>" <?php if ($type_colour_button_quickorder == $key) { echo " selected"; }?> >
									<?php echo $value;?>
								</option>
							<?php } ?>
						</select>
					</td>				
				  </tr>
				</table>
			</div>	
			
			<div id="tab-fields" class="tab-pane">
				 <table class="table table-striped table-bordered table-hover">

				  <tr>
					<td>
						<h3><?php echo $entry_field_user_name_title; ?></h3>
					</td>				
				  </tr>
				  
				  <tr> 
					<td>
						<?php echo $entry_field_user_name_show; ?>
					</td>
					
					<td class="left">
						<select class="form-control" name="field_user_name_show">
						<?php if ($field_user_name_show == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_yes; ?></option>
							<option value="0"><?php echo $text_no; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_yes; ?></option>
							<option value="0" selected="selected"><?php echo $text_no; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>
				  
				  <tr> 
					<td>
						<?php echo $entry_field_user_name_required; ?>
					</td>
					
					<td class="left">
						<select class="form-control" name="field_user_name_required">
						<?php if ($field_user_name_required == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_yes; ?></option>
							<option value="0"><?php echo $text_no; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_yes; ?></option>
							<option value="0" selected="selected"><?php echo $text_no; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>	


				  <tr>
					<td>
						<h3><?php echo $entry_field_user_phone_title; ?></h3>
					</td>				
				  </tr>
				  
				  <tr> 
					<td>
						<?php echo $entry_field_user_phone_show; ?>
					</td>
					
					<td class="left">
						<select class="form-control" name="field_user_phone_show">
						<?php if ($field_user_phone_show == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_yes; ?></option>
							<option value="0"><?php echo $text_no; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_yes; ?></option>
							<option value="0" selected="selected"><?php echo $text_no; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>
				  
				  <tr> 
					<td>
						<?php echo $entry_field_user_phone_required; ?>
					</td>
					
					<td class="left">
						<select class="form-control" name="field_user_phone_required">
						<?php if ($field_user_phone_required == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_yes; ?></option>
							<option value="0"><?php echo $text_no; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_yes; ?></option>
							<option value="0" selected="selected"><?php echo $text_no; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>	
				  
				  <tr> 
					<td>
						<?php echo $entry_field_user_phone_maskedinput; ?>
					</td>
					
					<td class="left">
						<input type="text" class="form-control" name="field_user_phone_maskedinput" value="<?php echo $field_user_phone_maskedinput; ?>"  size="30" />
					</td>				
				  </tr>
				  
				  
				  <tr>
					<td>
						<h3><?php echo $entry_field_email_title; ?></h3>
					</td>				
				  </tr>
				  
				  <tr> 
					<td>
						<?php echo $entry_field_email_show; ?>
					</td>
					
					<td class="left">
						<select class="form-control" name="field_email_show">
						<?php if ($field_email_show == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_yes; ?></option>
							<option value="0"><?php echo $text_no; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_yes; ?></option>
							<option value="0" selected="selected"><?php echo $text_no; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>
				  
				  <tr> 
					<td>
						<?php echo $entry_field_email_required; ?>
					</td>
					
					<td class="left">
						<select class="form-control" name="field_email_required">
						<?php if ($field_email_required == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_yes; ?></option>
							<option value="0"><?php echo $text_no; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_yes; ?></option>
							<option value="0" selected="selected"><?php echo $text_no; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>				  
				  
				  <tr>
					<td>
						<h3><?php echo $entry_field_comment_title; ?></h3>
					</td>				
				  </tr>
				  
				  <tr> 
					<td>
						<?php echo $entry_field_comment_show; ?>
					</td>
					
					<td class="left">
						<select class="form-control" name="field_comment_show">
						<?php if ($field_comment_show == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_yes; ?></option>
							<option value="0"><?php echo $text_no; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_yes; ?></option>
							<option value="0" selected="selected"><?php echo $text_no; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>
				  
				  <tr> 
					<td>
						<?php echo $entry_field_comment_required; ?>
					</td>
					
					<td class="left">
						<select class="form-control" name="field_comment_required">
						<?php if ($field_comment_required == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_yes; ?></option>
							<option value="0"><?php echo $text_no; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_yes; ?></option>
							<option value="0" selected="selected"><?php echo $text_no; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>				  
				  
				  <tr> 
					<td></td>
					<td></td>				
				  </tr>				  
				  
				  <tr>
					<td>
						<h3><?php echo $entry_field_product_quantity_title; ?></h3>
					</td>				
				  </tr>
				  
				  <tr> 
					<td>
						<?php echo $entry_field_product_quantity_show; ?>
					</td>
					
					<td class="left">
						<select class="form-control" name="field_product_quantity_show">
						<?php if ($field_product_quantity_show == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_yes; ?></option>
							<option value="0"><?php echo $text_no; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_yes; ?></option>
							<option value="0" selected="selected"><?php echo $text_no; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>
				  
				  <tr> 
					<td>
						<?php echo $entry_field_product_quantity_required; ?>
					</td>
					
					<td class="left">
						<select class="form-control" name="field_product_quantity_required">
						<?php if ($field_product_quantity_required == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_yes; ?></option>
							<option value="0"><?php echo $text_no; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_yes; ?></option>
							<option value="0" selected="selected"><?php echo $text_no; ?></option>
						<?php } ?>
						</select>
					</td>				
				  </tr>	
				  
				</table>
			</div>
			
			<div id="tab-email" class="tab-pane">
				 <table class="table table-striped table-bordered table-hover">

				  <tr>
					<td>
						<?php echo $entry_send_email_status; ?>
					</td>
					
					<td class="left">
						<select class="form-control" name="send_email_status">
						<?php if ($send_email_status == '1') { ?>
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
					<td>
						<?php echo $entry_type_email; ?>
					</td>
					
					<td class="left">						
						<select class="form-control" name="type_email" >
							<?php foreach($type_email_option as $key => $value) { ?>
								<option value="<?php echo $key;?>" <?php if ($type_email == $key) { echo " selected"; }?> >
									<?php echo $value;?>
								</option>
							<?php } ?>
						</select>
						
					</td>
				  </tr>
				  
				  <tr>
					<td>
						<?php echo $entry_offon_email_admin; ?>
					</td>
					
					<td class="left">
						<select class="form-control" name="offon_email_admin">
						<?php if ($offon_email_admin == '1') { ?>
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
					<td>
						<?php echo $entry_offon_email_additional; ?>
					</td>
					
					<td class="left">
						<textarea class="form-control" rows="5" cols="40" name="email_additional"><?php echo $email_additional; ?></textarea>
					</td>
				  </tr>
				  
				  <tr>
					<td>
						<?php echo $entry_offon_email_customer; ?>
					</td>
					
					<td class="left">
						<select class="form-control" name="offon_email_customer">
						<?php if ($offon_email_customer == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
						</select>
					</td>
				  </tr>
				  
				</table>
			</div>	

			<div id="tab-order" class="tab-pane">
				 <table class="table table-striped table-bordered table-hover">
				
				  <tr>
					<td>
						<?php echo $entry_order_offon; ?>
					</td>
					
					<td>
						<select class="form-control" name="order_offon">
						<?php if ($order_offon == '1') { ?>
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
					<td>
						<?php echo $entry_order_name_in_admin; ?>
					</td>
					
					<td>
						<input type="text" class="form-control" name="order_name_in_admin" value="<?php echo $order_name_in_admin; ?>"  size="30" />
					</td>
				  </tr>

				  <tr>
					<td><?php echo $entry_order_status; ?></td>
					<td><select class="form-control" name="order_order_status_id">
						<?php foreach ($order_statuses as $order_status) { ?>
						<?php if ($order_status['order_status_id'] == $order_order_status_id) { ?>
						<option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
						<?php } else { ?>
						<option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
						<?php } ?>
						<?php } ?>
					  </select></td>
				  </tr>		
				
				</table>
			</div>
			
			<div id="tab-system-settings" class="tab-pane">	
				 <table class="table table-striped table-bordered table-hover">
				  <tr>
					<td>
						<?php echo $entry_del_system_css_on_show; ?>
					</td>
					
					<td class="left">
						<select class="form-control" name="del_system_css_on_show">
						<?php if ($del_system_css_on_show == '1') { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
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
function sav_con(){
	$('#form').append('<input type="hidden" id="save_continue" name="save_continue" value="1"  />');
	$('#form').submit();
}
//--></script>

<?php echo $footer; ?>