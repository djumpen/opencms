<?php echo $header; ?>
<div id="content" class="container">
	<ul class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
		<?php } ?>
	</ul>
	<script type="text/javascript" src="view/javascript/fileuploader.js"></script>
	<link rel="stylesheet" type="text/css" href="view/stylesheet/fileuploader.css" />
	<div class="panel panel-default">
		<div class="panel-heading">
			<div class="pull-right">
				<button type="submit" form="form-product" class="btn btn-primary ">
					<i class="fa fa-check"></i> <?php echo $button_save; ?>
				</button>
				<a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a>
			</div>
			<h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
		</div>
		<div class="panel-body">
			<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-product" class="form-horizontal">
				<!-- Unusable for this moment -->
				<input type="hidden" name="sku" value="<?php echo $sku; ?>" />
				<input type="hidden" name="upc" value="<?php echo $upc; ?>" />
				<input type="hidden" name="ean" value="<?php echo $ean; ?>" />
				<input type="hidden" name="jan" value="<?php echo $jan; ?>" />
				<input type="hidden" name="isbn" value="<?php echo $isbn; ?>" />
				<input type="hidden" name="mpn" value="<?php echo $mpn; ?>" />
				<input type="hidden" name="location" value="<?php echo $location; ?>" />
				<input type="hidden" name="product_store[]" value="<?php echo (isset($stores[0])? $stores[0]['store_id']:0); ?>" />
				<!-- Unusable for this moment -->
				<ul class="nav nav-tabs">
					<li class="active">
						<a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a>
					</li>
					<li>
						<a href="#tab-seo" data-toggle="tab"><?php echo $tab_seo; ?></a>
					</li>
					<?php if(isset($this->session->data['user_id']) && $this->session->data['user_id'] == 1) { ?>
					<li>
						<a href="#tab-design" data-toggle="tab"><?php echo $tab_design; ?></a>
					</li>
					<?php } ?>
				</ul>

				<?php asort($languages);?>

				<!-- TAB GENERAL -->
				<div class="tab-content">
					<div class="tab-pane active" id="tab-general">

						<ul class="nav nav-tabs" id="language-general">
							<?php $l=0;foreach ($languages as $language) { ?>
							<li class="<?php if(!$l) { print 'active';} ?>">
								<a  href="#language-general<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
							</li>
							<?php $l++;} ?>
						</ul>
						<div class="tab-content">
							<?php $l=0;foreach ($languages as $language) { ?>

							<div class="tab-pane <?php if(!$l) { print 'active';} ?>" id="language-general<?php echo $language['language_id']; ?>">
								<!-- Name field -->
								<div class="form-group required col-xs-3 row" >
									<label class="col-xs-12 control-label" for="input-name<?php echo $language['language_id']; ?>"><?php echo $entry_name; ?></label>
									<div class="col-xs-12">
										<input type="text" name="product_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['name'] : ''; ?>" id="input-name<?php echo $language['language_id']; ?>" class="form-control" />
									</div>
								</div>
								<!-- Name field -->
							</div>
							<?php $l++;} ?>
						</div>
						<div class="form-group required col-xs-2">
							<!-- FIELD PRICE -->
							<label class="col-xs-12 control-label" for="input-price"><?php echo $entry_price; ?></label>
							<div class="col-xs-12">
								<input type="text" name="price" value="<?php echo $price; ?>" id="input-price" class="form-control" />
							</div>
							<!-- FIELD PRICE -->
						</div>
						<div class="form-group required col-xs-2">
							<!-- FIELD QUANTITY -->
							<label class="col-xs-12 control-label" for="input-quantity"><?php echo $entry_quantity; ?></label>
							<div class="col-xs-12">
								<input type="text" name="quantity" value="<?php echo $quantity; ?>" id="input-quantity" class="form-control" />
							</div>
							<!-- FIELD QUANTITY -->
						</div>

						<!-- FIELD WHOLE_SALE PRICE -->
						<?php if($this->config->get('config_whole_sale_price')) { ?>
						<div class="form-group required col-xs-2">
							<label class="col-xs-12 control-label" for="input-whole_sale_price">Оптовая цена</label>
							<div class="col-xs-12">
								<input type="text" name="whole_sale_price" value="<?php echo $whole_sale_price; ?>" id="input-whole_sale_price" class="form-control" />
							</div>
						</div>
						<?php } ?>
						<!-- FIELD WHOLE_SALE PRICE -->

						<!-- FIELD WHOLE_SALE PRICE -->
						<?php if($this->config->get('config_whole_sale_price')) { ?>
						<div class="form-group required col-xs-2">
							<label class="col-xs-12 control-label" for="input-whole_sale_price_quantity">Оптовая цена от: (Количество)</label>
							<div class="col-xs-12">
								<input type="text" name="whole_sale_price_quantity" value="<?php echo $whole_sale_price_quantity; ?>" id="input-whole_sale_price_quantity" class="form-control" />
							</div>
							<!-- FIELD WHOLE_SALE PRICE -->
						</div>
						<?php } ?>
						<div class="form-group required col-xs-2">
							<!-- FIELD MODEL -->
							<label class="col-xs-12 control-label" for="input-model"><?php echo $entry_model; ?></label>
							<div class="col-xs-12">
								<input type="text" name="model" value="<?php echo $model; ?>" id="input-model" class="form-control" />
							</div>
							<!-- FIELD MODEL -->
						</div>
						<!-- FIELD MANUFACTURER -->
						<div class="form-group col-xs-3">
							<label class="col-xs-12 control-label" for="input-manufacturer"><?php echo $entry_manufacturer; ?></label>
							<div class="col-xs-12">
								<input type="text" name="manufacturer" value="<?php echo $manufacturer ?>" id="input-manufacturer" class="form-control" />
								<input type="hidden" name="manufacturer_id" value="<?php echo $manufacturer_id; ?>" />
							</div>
						</div>
						<!-- FIELD MANUFACTURER -->
						<!-- FIELD SORT ORDER -->
						<div class="form-group col-xs-2">
							<label class="col-xs-12 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
							<div class="col-xs-12">
								<input type="text" name="sort_order" value="<?php echo $sort_order; ?>" id="input-sort-order" class="form-control" />
							</div>
						</div>
						<!-- FIELD SORT ORDER -->

						<!-- FIELD CATEGORY -->
						<div class="form-group col-xs-4 ">
							<label class="col-xs-12 control-label" for="input-category"><?php echo $entry_category; ?></label>
							<div class="col-xs-12">
								<input type="text" name="category" value="" id="input-category" class="form-control" />

								<div id="product-category" class="well">
									<?php foreach ($product_categories as $product_category) { ?>
									<div id="product-category<?php echo $product_category['category_id']; ?>">
										<i class="fa fa-minus-circle"></i> <?php echo $product_category['name']; ?>
										<input type="hidden" name="product_category[]" value="<?php echo $product_category['category_id']; ?>" />
									</div>
									<?php } ?>
								</div>
							</div>
						</div>
						<!-- FIELD CATEGORY -->
						<!-- FIELD RELATED PRODUCTS -->
						<div class="form-group col-xs-4">
							<label class="col-xs-12 control-label" for="input-related"><?php echo $entry_related; ?> </label>
							<div class="col-xs-12">
								<input type="text" name="related" value="" id="input-related" class="form-control" />

								<div id="product-related" class="well">
									<?php foreach ($product_related as $product_related) { ?>
									<div id="product-related<?php echo $product_related['product_id']; ?>">
										<i class="fa fa-minus-circle"></i> <?php echo $product_related['name']; ?>
										<input type="hidden" name="product_related[]" value="<?php echo $product_related['product_id']; ?>" />
									</div>
									<?php } ?>
								</div>
							</div>
						</div>
						<!-- FIELD RELATED PRODUCTS -->
						<!-- FIELD STATUS -->
						<div class="form-group col-xs-4">
							<label class="col-xs-12 control-label" for="input-status"><?php echo $entry_status; ?></label>
							<div class="col-xs-12">
								<div class="btn-group" data-toggle="buttons">
									<label class="btn btn-success<?php if ($status == 1) { ?> active<?php } ?>"> <i class="fa fa-check"></i>
										<input type="radio" name="status" id="input-status" value="1" <?php if ($status == 1) { ?>checked<?php } ?>>
										<?php echo $text_enabled; ?> 
									</label>
									<label class="btn btn-danger<?php if ($status == 0) { ?> active<?php } ?>"> <i class="fa fa-times"></i>
										<input type="radio" name="status" id="input-status" value="0" <?php if ($status == 0) { ?>checked<?php } ?>>
										<?php echo $text_disabled; ?> 
									</label>
								</div>
							</div>
						</div>
						<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
						<div class="row"></div>
						<ul class="nav nav-tabs" >
							<li class="active">
								<a href="#tab-image" data-toggle="tab"><i class="fa fa-file-image-o"></i>  <?php echo $tab_image; ?></a>
							</li>
							<li>
								<a  href="#obshee" data-toggle="tab"><i class="fa fa-align-center"></i> Описание</a>
							</li>
							<li>
								<a href="#tab-data" data-toggle="tab"><i class="fa fa-list-alt"></i> <?php echo $tab_data; ?></a>
							</li>

							<li>
								<a href="#tab-atributu" data-toggle="tab"><i class="fa fa-bars"></i> <?php echo $text_attr ?></a>
							</li>
							<li>
								<a href="#tab-option" data-toggle="tab"><i class="fa fa-check-square-o"></i> <?php echo $tab_option; ?></a>
							</li>
							<li>
								<a href="#tab-events" data-toggle="tab"><i class="fa fa-bookmark-o"></i> <?php echo $tab_events; ?></a>
							</li>
							<?php if($this->config->get('config_product_video')) { ?>
							<li>
								<a href="#video" data-toggle="tab"><i class="fa fa-video-camera"></i> Видео</a>
							</li>
							<?php } ?>

						</ul>
						<div class="tab-content">
							<!-- TAB IMAGES -->
							<div class="tab-pane active" id="tab-image">
								<!-- FIELD IMAGES -->
								<div class="table-responsive">
									<table id="images" class="table table-striped table-bordered table-hover imgT">
										<thead>
											<tr>
												<td class="text-center" style="width: 100px;"><?php echo $entry_image; ?></td>
												<?php /* ?><td></td><?php */ ?>
												<td class="text-center" style="width: 50px;"><?php echo $entry_sort_order; ?></td>
												<td class="text-center" style="width: 150px;">Изображение по умолчанию</td>
												<td></td>
											</tr>
										</thead>
										<tbody>
											<?php $image_row = 0; ?>
											<?php foreach ($product_images as $product_image) { ?>
											<tr id="image-row<?php echo $image_row; ?>">
												<td class="text-left"><img src="<?php echo $product_image['thumb']; ?>" alt="" class="img-thumbnail" id="img-thumb<?php echo $image_row; ?>" />
													<input type="hidden" name="product_image[<?php echo $image_row; ?>][image]" value="<?php echo $product_image['image']; ?>" id="img-image<?php echo $image_row; ?>"/>
												</td>
														<?php /* ?>
														<td class="text-left">
															<div class="btn-group">
																<button type="button" onclick="image_upload('img-image<?php echo $image_row; ?>', 'img-thumb<?php echo $image_row; ?>');" data-toggle="modal" data-target="#dialog" class="btn btn-success">
																	<span class="fa fa-pencil"></span> <?php echo $text_browse; ?>
																</button>
																<button type="button" onclick="$('#img-thumb<?php echo $image_row; ?>').attr('src', '<?php echo $no_image; ?>'); $('#img-image<?php echo $image_row; ?>').attr('value', '');return false;" class="btn btn-info">
																	<span class="fa fa-trash-o"></span> <?php echo $text_clear; ?>
																</button>
																
															</div>
														</td>
														<?php */ ?>
												<td class="text-right">
													<input type="text" name="product_image[<?php echo $image_row; ?>][sort_order]" value="<?php echo $product_image['sort_order']; ?>" class="form-control" />
												</td>
												<td class="text-right">
													<input type="radio" <?php if(isset($product_image['image']) && $product_image['image'] == $image) {?>checked="checked"<?php } ?>name="def_img" value="<?php  if (isset($product_image['image'])) { echo $product_image['image']; } ?>">
												</td>
												<td class="text-left">
															<button type="button" onclick="$('#image-row<?php echo $image_row; ?>').remove();" class="btn btn-danger">
																	<i class="fa fa-minus-circle"></i> <?php echo $button_remove; ?>
																</button>
														</td>
											</tr>
											<?php $image_row++; ?>
											<?php } ?>
										</tbody>
									</table>
									<div id="file-uploader">
										<noscript>
											<p>
												Please enable JavaScript to use file uploader.
											</p>
											<!-- or put a simple form for upload here -->
										</noscript>
									</div>
								</div>
								<!-- FIELD IMAGES -->
							</div>
							<!-- TAB IMAGES -->
							<!--////////////////////////////////////////-->
							<!-- описание -->
							<div class="tab-pane" id="obshee">
								<ul class="nav nav-tabs" id="language-second-general">
									<?php $l=0;foreach ($languages as $language) { ?>
									<li class="<?php if(!$l) { print 'active';} ?>">
										<a  href="#language-second-general<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
									</li>
									<?php $l++;} ?>
								</ul>
								<div class="tab-content">
									<?php $l=0;foreach ($languages as $language) { ?>
									<div class="tab-pane <?php if(!$l) { print 'active';} ?>" id="language-second-general<?php echo $language['language_id']; ?>">
										<!-- FIELD DESCRIPTION -->
										<div class="form-group">
											<label class="col-xs-2 control-label" for="input-description<?php echo $language['language_id']; ?>"><?php echo $entry_description; ?></label>
											<div class="col-xs-10">
												<textarea name="product_description[<?php echo $language['language_id']; ?>][description]" id="input-description<?php echo $language['language_id']; ?>"><?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['description'] : ''; ?></textarea>
											</div>
										</div>
										<!-- FIELD DESCRIPTION -->
										<!-- FIELD SHORT DESCRIPTION -->
										<?php if($this->config->get('config_short_product_description')) { ?>
										<div class="form-group">
											<label class="col-xs-2 control-label" for="input-short-description<?php echo $language['language_id']; ?>">Краткое описание</label>
											<div class="col-xs-10">
												<textarea name="product_description[<?php echo $language['language_id']; ?>][short_description]" id="input-short-description<?php echo $language['language_id']; ?>"><?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['short_description'] : ''; ?></textarea>
											</div>
										</div>
										<?php } ?>
										<!-- FIELD SHORT DESCRIPTION -->
									</div>
									<?php $l++; } ?>
								</div>
							</div>
							<!-- //////////////////////////////////////////////////////////////////// -->
							<!-- Характеристики товара -->
							<div class="tab-pane" id="tab-data">
								<div class="col-xs-2">
									<div class="form-group container">
										<label class=" control-label" for="input-length"><?php echo $entry_dimension; ?></label>
										<input type="text" name="length" value="<?php echo $length; ?>" id="input-length" class="form-control" />
									</div>
									<div class="form-group container">
										<label class=" control-label">Ширина</label>
										<input type="text" name="width" value="<?php echo $width; ?>" id="input-width" class="form-control" />
									</div>
									<div class="form-group container">
										<label class=" control-label" >Высота</label>
										<input type="text" name="height" value="<?php echo $height; ?>" id="input-height" class="form-control" />
									</div>
								</div>
								<div class="col-xs-2">
									<div class="form-group container">
										<label class=" control-label" for="input-length-class"><?php echo $entry_length; ?></label>
										<select name="length_class_id" id="input-length-class" class="form-control">
											<?php foreach ($length_classes as $length_class) { ?>
											<?php if ($length_class['length_class_id'] == $length_class_id) { ?>
											<option value="<?php echo $length_class['length_class_id']; ?>" selected="selected"><?php echo $length_class['title']; ?></option>
											<?php } else { ?>
											<option value="<?php echo $length_class['length_class_id']; ?>"><?php echo $length_class['title']; ?></option>
											<?php } ?>
											<?php } ?>
										</select>
									</div>

									<div class="form-group container">
										<label class="control-label" for="input-weight-class"><?php echo $entry_weight_class; ?></label>
										<select name="weight_class_id" id="input-weight-class" class="form-control">
											<?php foreach ($weight_classes as $weight_class) { ?>
											<?php if ($weight_class['weight_class_id'] == $weight_class_id) { ?>
											<option value="<?php echo $weight_class['weight_class_id']; ?>" selected="selected"><?php echo $weight_class['title']; ?></option>
											<?php } else { ?>
											<option value="<?php echo $weight_class['weight_class_id']; ?>"><?php echo $weight_class['title']; ?></option>
											<?php } ?>
											<?php } ?>
										</select>
									</div>
									<div class="form-group container">
										<label class="control-label" for="input-weight"><?php echo $entry_weight; ?></label>
										<div>
											<input type="text" name="weight" value="<?php echo $weight; ?>" id="input-weight" class="form-control" />
										</div>
									</div>
								</div>
								<div class="col-xs-3">
									<div class="form-group container">
										<label class="control-label" for="input-tax-class"><?php echo $entry_tax_class; ?></label>
										<select name="tax_class_id" id="input-tax-class" class="form-control">
											<option value="0"><?php echo $text_none; ?></option>
											<?php foreach ($tax_classes as $tax_class) { ?>
											<?php if ($tax_class['tax_class_id'] == $tax_class_id) { ?>
											<option value="<?php echo $tax_class['tax_class_id']; ?>" selected="selected"><?php echo $tax_class['title']; ?></option>
											<?php } else { ?>
											<option value="<?php echo $tax_class['tax_class_id']; ?>"><?php echo $tax_class['title']; ?></option>
											<?php } ?>
											<?php } ?> 
										</select>
									</div>
									<div class="form-group container">
										<label class=" control-label" for="input-stock-status"><?php echo $entry_stock_status; ?></label>
										<select name="stock_status_id" id="input-stock-status" class="form-control">
											<?php foreach ($stock_statuses as $stock_status) { ?>
											<?php if ($stock_status['stock_status_id'] == $stock_status_id) { ?>
											<option value="<?php echo $stock_status['stock_status_id']; ?>" selected="selected"><?php echo $stock_status['name']; ?></option>
											<?php } else { ?>
											<option value="<?php echo $stock_status['stock_status_id']; ?>"><?php echo $stock_status['name']; ?></option>
											<?php } ?>
											<?php } ?>
										</select>
									</div>
									<div class="form-group container">
										<label class=" control-label" for="input-subtract"><?php echo $entry_subtract; ?></label>
										<div>
											<div class="btn-group" data-toggle="buttons">
												<label class="btn btn-success<?php if ($subtract == 0) { ?> active<?php } ?>"> <i class="fa fa-times"></i>
													<input type="radio" name="subtract" id="input-status" value="0" <?php if ($status == 0) { ?>checked<?php } ?>>
													<?php echo $text_disabled; ?>
												</label>
												<label class="btn btn-danger<?php if ($subtract == 1) { ?> active<?php } ?>"> <i class="fa fa-check"></i>
													<input type="radio" name="subtract" id="input-status" value="1" <?php if ($status == 1) { ?>checked<?php } ?>>
													<?php echo $text_enabled; ?>
												</label>
											</div>
										</div>
									</div>
								</div>
								<div class="col-xs-3">
									<div class="form-group container">
										<label  class="control-label" for="input-minimum"><?php echo $entry_minimum; ?> </label>
										<input type="text" name="minimum" value="<?php echo $minimum; ?>" id="input-minimum" class="form-control" />
									</div>
									<div class="form-group container">
										<label class=" control-label" for="input-available"><?php echo $entry_date_available; ?></label>
										<div>
											<input name="date_available" value="<?php echo $date_available; ?>" id="input-available" class="form-control datepicker" />
										</div>
									</div>
									<div class="form-group container">
										<label class=" control-label"><?php echo $entry_shipping; ?></label>
										<div>
											<div class="btn-group" data-toggle="buttons">
												<label class="btn btn-success<?php if ($shipping == 1) { ?> active<?php } ?>"> <i class="fa fa-check"></i>
													<input type="radio" name="shipping" id="input-status" value="1" <?php if ($shipping == 1) { ?>checked<?php } ?>>
													<?php echo $text_yes; ?>
												</label>
												<label class="btn btn-danger<?php if ($shipping == 0) { ?> active<?php } ?>"> <i class="fa fa-times"></i>
													<input type="radio" name="shipping" id="input-status" value="0" <?php if ($shipping == 0) { ?>checked<?php } ?>>
													<?php echo $text_no; ?>
												</label>
											</div>
										</div>
									</div>
								</div>
								<div class="col-xs-2">
									<div class="form-group container"> 
										<label class=" control-label" for="input-download"><?php echo $entry_download; ?></label>
										<input type="text" name="download" value="" id="input-download" class="form-control" />
										<div id="product-download" class="well">
											<?php foreach ($product_downloads as $product_download) { ?>
											<div id="product-download<?php echo $product_download['download_id']; ?>">
												<i class="fa fa-minus-circle"></i> <?php echo $product_download['name']; ?>
												<input type="hidden" name="product_download[]" value="<?php echo $product_download['download_id']; ?>" />
											</div>
											<?php } ?>
										</div>
									</div>
								</div>
								<!-- FIELD PROFILES -->					
							</div>
							<div class="tab-pane" id="tab-atributu">
								<table id="attribute" class="table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<td class="text-left" style="width: 150px;"><?php echo $entry_attribute; ?></td>
											<td class="text-left"><?php echo $entry_text; ?></td>
											<td></td>
										</tr>
									</thead>
									<tbody>
										<?php $attribute_row = 0; ?>
										<?php foreach ($product_attributes as $product_attribute) { ?>
										<tr id="attribute-row<?php echo $attribute_row; ?>">
											<td class="text-left">
												<input type="text" name="product_attribute[<?php echo $attribute_row; ?>][name]" value="<?php echo $product_attribute['name']; ?>" class="form-control" />
												<input type="hidden" name="product_attribute[<?php echo $attribute_row; ?>][attribute_id]" value="<?php echo $product_attribute['attribute_id']; ?>" />
											</td>
											<td class="text-left"><?php foreach ($languages as $language) { ?>
												<div class="input-group col-xs-6">
													<span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
													<textarea name="product_attribute[<?php echo $attribute_row; ?>][product_attribute_description][<?php echo $language['language_id']; ?>][text]" rows="5" class="form-control"><?php echo isset($product_attribute['product_attribute_description'][$language['language_id']]) ? $product_attribute['product_attribute_description'][$language['language_id']]['text'] : ''; ?></textarea>
												</div> <?php } ?>
											</td>
											<td class="text-left">
												<button type="button" onclick="$('#attribute-row<?php echo $attribute_row; ?>').remove();" class="btn btn-danger">
													<i class="fa fa-minus-circle"></i> <?php echo $button_remove; ?>
												</button>
											</td>
										</tr>
										<?php $attribute_row++; ?>
										<?php } ?>
									</tbody>
									<tfoot>
										<tr>
											<td colspan="2"></td>
											<td class="text-left">
												<button type="button" onclick="addAttribute();" class="btn btn-primary">
													<i class="fa fa-plus-circle"></i> <?php echo $button_add_attribute; ?>
												</button>
											</td>
										</tr>
									</tfoot>
								</table>
							</div>
							<!-- //////////////////////////////////////////// -->	
							<!-- TAB OPTIONS -->
							<div class="tab-pane" id="tab-option">
								<!-- FIELD OPTIONS -->
								<div class="row">
									<div class="col-xs-2">
										<ul class="nav nav-pills nav-stacked" id="option">
											<?php $option_row = 0; ?>
											<?php foreach ($product_options as $product_option) { ?>
											<?php Debug::log($product_option);?>
											<li>
												<a href="#tab-option<?php echo $option_row; ?>" data-toggle="tab"><i class="fa fa-minus-circle" onclick="$('a[href=\'#tab-option<?php echo $option_row; ?>\']').parent().remove(); $('#tab-option<?php echo $option_row; ?>').remove(); $('#option a:first').tab('show');"></i> <?php echo $product_option['name']; ?></a>
											</li>
											<?php $option_row++; ?>
											<?php } ?>
											<li>
												<input type="text" name="option" value="" id="input-option" class="form-control" />
											</li>
										</ul>
									</div>
									<div class="col-xs-10">
										<div class="tab-content">
											<?php $option_row = 0; ?>
											<?php $option_value_row = 0; ?>
											<?php foreach ($product_options as $product_option) { ?>
											<div class="tab-pane" id="tab-option<?php echo $option_row; ?>">
												<input type="hidden" name="product_option[<?php echo $option_row; ?>][product_option_id]" value="<?php echo $product_option['product_option_id']; ?>" />
												<input type="hidden" name="product_option[<?php echo $option_row; ?>][name]" value="<?php echo $product_option['name']; ?>" />
												<input type="hidden" name="product_option[<?php echo $option_row; ?>][option_id]" value="<?php echo $product_option['option_id']; ?>" />
												<input type="hidden" name="product_option[<?php echo $option_row; ?>][type]" value="<?php echo $product_option['type']; ?>" />
												<?php if (isset($error_duplicate_option[$product_option['option_id']])) { ?>
												<span class="error"><?php echo $error_duplicate_option[$product_option['option_id']]; ?></span>
												<?php } ?>
												<?php if (isset($error_ajax_option_value_failure[$product_option['option_id']])) { ?>
												<span class="error"><?php echo $error_ajax_option_value_failure[$product_option['option_id']]; ?></span>
												<?php } ?>
												<div class="form-group">
													<label class="col-xs-12 control-label" for="input-required<?php echo $option_row; ?>"><?php echo $entry_required; ?></label>
													<div class="col-xs-12">						
														<div class="btn-group" data-toggle="buttons">
															<?php if($product_option['product_page']) {?>
															<label class="btn btn-success<?php if ($product_option['required'] == 1) { ?> active<?php } ?>"> <i class="fa fa-check"></i>
																<input type="radio" name="product_option[<?php echo $option_row; ?>][required]" id="input-required<?php echo $option_row; ?>" value="1" <?php if ($product_option['required'] == 1) { ?>checked<?php } ?>>
																<?php echo $text_yes; ?>
															</label>
															<?php } ?>
															<label class="btn btn-danger<?php if ($product_option['required'] == 0) { ?> active<?php } ?>"> <i class="fa fa-times"></i>
																<input type="radio" name="product_option[<?php echo $option_row; ?>][required]" id="input-required<?php echo $option_row; ?>" value="0" <?php if ($product_option['required'] == 0) { ?>checked<?php } ?>>
																<?php echo $text_no; ?>
															</label>
														</div>
													</div>
												</div>
												<?php if ($product_option['type'] == 'select') { // DEPENDEND ?>
												<div class="table-responsive">
													<table class="table table-striped table-bordered table-hover">
														<tr>
															<td><?php echo $entry_parent_option; ?></td>
															<td>
																<select id="parent-<?php echo $option_row; ?>" name="product_option[<?php echo $option_row; ?>][parent_option_id]" class="form-control">
																	<option value=""><?php echo $text_none; ?></option>
																	<?php foreach ($select_options as $select_option) { ?>
																	<?php if ($select_option['option_id'] == $product_option['parent_option_id']) { ?>
																	<option value="<?php echo $select_option['option_id']; ?>" selected="selected"><?php echo $select_option['name']; ?></option>
																	<?php } else if ($select_option['option_id'] !== $product_option['option_id']) { ?>
																	<option value="<?php echo $select_option['option_id']; ?>"><?php echo $select_option['name']; ?></option>
																	<?php } ?>
																	<?php } ?>
																</select> <?php if (isset($error_missing_option[$product_option['option_id']])) { ?> <span class="error"><?php echo $error_missing_option[$product_option['option_id']]; ?></span> <?php } ?>
																<?php if (isset($error_parent_option_recursion[$product_option['option_id']])) { ?> <span class="error"><?php echo $error_parent_option_recursion[$product_option['option_id']]; ?></span> <?php } ?>
															</td>
														</tr>
														<tr>
															<td colspan="2" style="border-bottom: none; padding-top: 10px;"><?php echo $text_parent_select; ?></td>
														</tr>
													</table>
												</div>
												<?php } // DEPENDEND ?>
												<?php if ($product_option['type'] == 'text') { ?>
												<div class="form-group">
													<label class="col-xs-12 control-label" for="input-value<?php echo $option_row; ?>"><?php echo $entry_option_value; ?></label>
													<div class="col-xs-12">
														<input type="text" name="product_option[<?php echo $option_row; ?>][option_value]" value="<?php echo $product_option['option_value']; ?>" id="input-value<?php echo $option_row; ?>" class="form-control" />
													</div>
												</div>
												<?php } ?>
												<?php if ($product_option['type'] == 'textarea') { ?>
												<div class="form-group">
													<label class="col-xs-12 control-label" for="input-value<?php echo $option_row; ?>"><?php echo $entry_option_value; ?></label>
													<div class="col-xs-12">
														<textarea name="product_option[<?php echo $option_row; ?>][option_value]" rows="5" id="input-value<?php echo $option_row; ?>" class="form-control"><?php echo $product_option['option_value']; ?></textarea>
													</div>
												</div>
												<?php } ?>
												<?php if ($product_option['type'] == 'file') { ?>
												<div class="form-group" style="display: none;">
													<label class="col-xs-12 control-label" for="input-value<?php echo $option_row; ?>"><?php echo $entry_option_value; ?></label>
													<div class="col-xs-12">
														<input type="text" name="product_option[<?php echo $option_row; ?>][option_value]" value="<?php echo $product_option['option_value']; ?>" id="input-value<?php echo $option_row; ?>" class="form-control" />
													</div>
												</div>
												<?php } ?>
												<?php if ($product_option['type'] == 'date') { ?>
												<div class="form-group">
													<label class="col-xs-12 control-label" for="input-value<?php echo $option_row; ?>"><?php echo $entry_option_value; ?></label>
													<div class="col-xs-12">
														<input type="text" name="product_option[<?php echo $option_row; ?>][option_value]" value="<?php echo $product_option['option_value']; ?>" id="input-value<?php echo $option_row; ?>" class="form-control datepicker" />
													</div>
												</div>
												<?php } ?>
												<?php if ($product_option['type'] == 'datetime') { ?>
												<div class="form-group">
													<label class="col-xs-12 control-label" for="input-value<?php echo $option_row; ?>"><?php echo $entry_option_value; ?></label>
													<div class="col-xs-12">
														<input type="datetime-local" name="product_option[<?php echo $option_row; ?>][option_value]" value="<?php echo $product_option['option_value']; ?>" id="input-value<?php echo $option_row; ?>" class="form-control" />
													</div>
												</div>
												<?php } ?>
												<?php if ($product_option['type'] == 'time') { ?>
												<div class="form-group">
													<label class="col-xs-12 control-label" for="input-value<?php echo $option_row; ?>"><?php echo $entry_option_value; ?></label>
													<div class="col-xs-12">
														<input type="time" name="product_option[<?php echo $option_row; ?>][option_value]" value="<?php echo $product_option['option_value']; ?>" id="input-value<?php echo $option_row; ?>" class="form-control" />
													</div>
												</div>
												<?php } ?>
												<?php if ($product_option['type'] == 'select' || $product_option['type'] == 'radio' || $product_option['type'] == 'radiocolor' || $product_option['type'] == 'radiolabel' || $product_option['type'] == 'checkbox' || $product_option['type'] == 'checkboxcolor' || $product_option['type'] == 'checkboxlabel' || $product_option['type'] == 'image' || $product_option['type'] == 'custom_text') { ?>
												<div class="table-responsive">
													<table id="option-value<?php echo $option_row; ?>" class="table table-striped table-bordered table-hover">
														<thead>
															<tr>
																<td class="text-left"><?php echo $entry_option_value; ?></td>
																<td class="text-right"><?php echo $entry_quantity; ?></td>
																<td class="text-left"><?php echo $entry_subtract; ?></td>
																<?php if ($product_option['type'] == 'select') { ?>
																<td class="left"><?php echo $entry_parent_option_value; ?></td>
																<?php } ?>
																<td class="text-right"><?php echo $entry_price; ?></td>
																<td class="text-right"><?php echo $entry_option_points; ?></td>
																<?php //<td class="text-right"><?php echo $entry_weight; ?\></td> ?> <td class="text-right"><?php echo $entry_product_option_image?></td>
																<td></td>
															</tr>
														</thead>
														<tbody>
															<?php if (isset($error_no_option_values_set[$product_option['option_id']])) { ?>
															<div class="text-danger">
																<?php echo $error_no_option_values_set[$product_option['option_id']]; ?>
															</div>
															<?php } ?>
															<?php foreach ($product_option['product_option_value'] as $product_option_value) { ?>
															<tr id="option-value-row<?php echo $option_value_row; ?>">
																<td class="text-left">
																	<select name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][option_value_id]" class="form-control">
																		<?php if (isset($option_values[$product_option['option_id']])) { ?>
																		<?php foreach ($option_values[$product_option['option_id']] as $option_value) { ?>
																		<?php if ($option_value['option_value_id'] == $product_option_value['option_value_id']) { ?>
																		<option value="<?php echo $option_value['option_value_id']; ?>" selected="selected"><?php echo $option_value['name']; ?></option>
																		<?php } else { ?>
																		<option value="<?php echo $option_value['option_value_id']; ?>"><?php echo $option_value['name']; ?></option>
																		<?php } ?>
																		<?php } ?>
																		<?php } ?>
																	</select>
																	<input type="hidden" name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][product_option_value_id]" value="<?php echo $product_option_value['product_option_value_id']; ?>" />
																	<?php if (isset($error_duplicate_option_value[$product_option_value['option_value_id']])) { ?> <span class="error"><?php echo $error_duplicate_option_value[$product_option_value['option_value_id']]; ?></span> <?php } ?>
																	<?php if ($product_option_value['option_value_id'] === false) { ?> <span class="error"><?php echo $error_option_value_load_failure; ?></span> <?php } ?>
																</td>
																<td class="text-right">
																	<input type="text" name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][quantity]" value="<?php echo $product_option_value['quantity']; ?>" class="form-control" />
																</td>
																<td class="text-left">
																	<select name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][subtract]" class="form-control">
																		<?php if ($product_option_value['subtract']) { ?>
																		<option value="0"><?php echo $text_no; ?></option>
																		<option value="1" selected="selected"><?php echo $text_yes; ?></option>
																		<?php } else { ?>
																		<option value="0" selected="selected"><?php echo $text_no; ?></option>
																		<option value="1"><?php echo $text_yes; ?></option>
																		<?php } ?>
																	</select> <?php if (isset($error_required_option_parents[$product_option['option_id']])) { ?> <span class="error"><?php echo $error_required_option_parents[$product_option['option_id']]; ?></span> <?php } ?>
																</td>
																<?php if ($product_option['type'] == 'select') { ?>
																<td class="left">
																	<select id="child-<?php echo $option_value_row; ?>" name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][parent_option_value][]" multiple="multiple">
																		<?php foreach ($select_option_values as $select_option_value) { ?>
																		<?php if (is_array($product_option_value['parent_option_value']) && in_array($select_option_value['option_value_id'], $product_option_value['parent_option_value'])) { ?>
																		<option value="<?php echo $select_option_value['option_value_id']; ?>" class="<?php echo $select_option_value['option_id']; ?>" selected="selected"><?php echo $select_option_value['name']; ?></option>
																		<?php } else { ?>
																		<option value="<?php echo $select_option_value['option_value_id']; ?>" class="<?php echo $select_option_value['option_id']; ?>"><?php echo $select_option_value['name']; ?></option>
																		<?php } ?>
																		<?php } ?>
																	</select> <?php if (isset($error_no_parent_option_values_set[$product_option_value['option_value_id']])) { ?> <span class="error"><?php echo $error_no_parent_option_values_set[$product_option_value['option_value_id']]; ?></span> <?php } ?>
																	<?php if (isset($error_missing_option_value[$product_option_value['option_value_id']])) { ?> <span class="error"><?php echo $error_missing_option_value[$product_option_value['option_value_id']]; ?></span> <?php } ?>
																	<?php if (isset($error_parent_option_stock_level[$product_option_value['option_value_id']])) { ?> <span class="error"><?php echo $error_parent_option_stock_level[$product_option_value['option_value_id']]; ?></span> <?php } ?>
																</td>
																<?php } ?>
																<td class="text-right">
																	<select name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][price_prefix]" class="form-control">
																		<?php if ($product_option_value['price_prefix'] == '+') { ?>
																		<option value="+" selected="selected">+</option>
																		<?php } else { ?>
																		<option value="+">+</option>
																		<?php } ?>
																		<?php if ($product_option_value['price_prefix'] == '-') { ?>
																		<option value="-" selected="selected">-</option>
																		<?php } else { ?>
																		<option value="-">-</option>
																		<?php } ?>
																	</select>
																	<input type="text" name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][price]" value="<?php echo $product_option_value['price']; ?>" class="form-control" />
																</td>
																<td class="text-right">
																	<select name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][points_prefix]" class="form-control">
																		<?php if ($product_option_value['points_prefix'] == '+') { ?>
																		<option value="+" selected="selected">+</option>
																		<?php } else { ?>
																		<option value="+">+</option>
																		<?php } ?>
																		<?php if ($product_option_value['points_prefix'] == '-') { ?>
																		<option value="-" selected="selected">-</option>
																		<?php } else { ?>
																		<option value="-">-</option>
																		<?php } ?>
																	</select>
																	<input type="text" name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][points]" value="<?php echo $product_option_value['points']; ?>" class="form-control" />
																</td>
																<td class="text-left"><!-- Hide Weight option -->
																	<span style="display:none;">
																		<select name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][weight_prefix]" class="form-control">
																			<?php if ($product_option_value['weight_prefix'] == '+') { ?>
																			<option value="+" selected="selected">+</option>
																			<?php } else { ?>
																			<option value="+">+</option>
																			<?php } ?>
																			<?php if ($product_option_value['weight_prefix'] == '-') { ?>
																			<option value="-" selected="selected">-</option>
																			<?php } else { ?>
																			<option value="-">-</option>
																			<?php } ?>
																		</select>
																		<input type="text" name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][weight]" value="<?php echo $product_option_value['weight']; ?>" class="form-control" />
																	</span>
																	<input type="hidden" name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][weight_prefix]" value="+" />
																	<input type="hidden" name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][weight]" value="<?php echo $product_option_value['weight']; ?>" />
																	<!-- End trick --><img src="<?php echo $product_option_value['product_option_image_thumb']; ?>" alt="" class="img-thumbnail" id="thumb<?php echo $option_value_row; ?>" />
																	<input type="hidden" name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][product_option_image]" value="<?php echo $product_option_value['product_option_image']; ?>" id="image<?php echo $option_value_row; ?>"/>
																	<br />
																	<br />
																	<div class="btn-group">
																		<button type="button" data-toggle="modal" data-target="#dialog" class="btn btn-info" onclick="image_upload('image<?php echo $option_value_row; ?>', 'thumb<?php echo $option_value_row; ?>');">
																			<span class="fa fa-pencil"></span> <?php echo $text_browse; ?>
																		</button>
																		<button type="button" onclick="$('#thumb<?php echo $option_value_row; ?>').attr('src', '<?php echo $no_image; ?>'); $('#image<?php echo $option_value_row; ?>').attr('value', '');return false;" class="btn btn-danger">
																			<span class="fa fa-trash-o"></span> <?php echo $text_clear; ?>
																		</button>
																	</div>
																</td>
																<td class="text-left">
																	<button type="button" onclick="$('#option-value-row<?php echo $option_value_row; ?>').remove();" class="btn btn-danger">
																		<i class="fa fa-minus-circle"></i> <?php echo $button_remove; ?>
																	</button>
																</td>
															</tr>
															<?php if ($product_option['type'] == 'select') { ?>
															<script type="text/javascript">
																$('#child-<?php echo $option_value_row; ?>').chained('#parent-<?php echo $option_row; ?>');
															</script>
															<?php } ?>
															<?php $option_value_row++; ?>
															<?php } ?>
														</tbody>
														<tfoot>
															<tr>
																<?php if ($product_option['type'] == 'select') { ?>
																<td colspan="7"></td>
																<?php } else { ?>
																<td colspan="6"></td>
																<?php } ?>
																<td class="text-left">
																	<button type="button" onclick="addOptionValue('<?php echo $option_row; ?>', '<?php echo $product_option['type']; ?>');" class="btn btn-primary">
																		<i class="fa fa-plus-circle"></i> <?php echo $button_add_option_value; ?>
																	</button>
																</td>
															</tr>
														</tfoot>
													</table>
												</div>
												<select id="option-values<?php echo $option_row; ?>" style="display: none;">
													<?php if (isset($option_values[$product_option['option_id']])) { ?>
													<?php foreach ($option_values[$product_option['option_id']] as $option_value) { ?>
													<option value="<?php echo $option_value['option_value_id']; ?>"><?php echo $option_value['name']; ?></option>
													<?php } ?>
													<?php } ?>
												</select>
												<?php } ?>
											</div>
											<?php $option_row++; ?>
											<?php } ?>
										</div>
									</div>
								</div>
								<!-- FIELD OPTIONS -->
							</div>
							<!-- TAB OPTIONS -->
							<!-- //////////////////////////////////////////// -->
							<div class="tab-pane " id="tab-events">
								<?php if($this->config->get('config_product_percent_events')) { ?>
								<div class="table-responsive">
									<table id="discount" class="table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<td class="text-left"><?php echo $entry_customer_group; ?></td>
												<td class="text-right"><?php echo $entry_quantity; ?></td>
												<td class="text-right"><?php echo $entry_priority; ?></td>
												<td class="text-right"><?php echo $entry_price; ?></td>
												<td class="text-left"><?php echo $entry_date_start; ?></td>
												<td class="text-left"><?php echo $entry_date_end; ?></td>
												<td></td>
											</tr>
										</thead>
										<tbody>
											<?php $discount_row = 0; ?>
											<?php foreach ($product_discounts as $product_discount) { ?>
											<tr id="discount-row<?php echo $discount_row; ?>">
												<td class="text-left">
													<select name="product_discount[<?php echo $discount_row; ?>][customer_group_id]" class="form-control">
														<?php foreach ($customer_groups as $customer_group) { ?>
														<?php if ($customer_group['customer_group_id'] == $product_discount['customer_group_id']) { ?>
														<option value="<?php echo $customer_group['customer_group_id']; ?>" selected="selected"><?php echo $customer_group['name']; ?></option>
														<?php } else { ?>
														<option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
														<?php } ?>
														<?php } ?>
													</select>
												</td>
												<td class="text-right">
													<input type="text" name="product_discount[<?php echo $discount_row; ?>][quantity]" value="<?php echo $product_discount['quantity']; ?>" class="form-control" />
												</td>
												<td class="text-right">
													<input type="text" name="product_discount[<?php echo $discount_row; ?>][priority]" value="<?php echo $product_discount['priority']; ?>" class="form-control" />
												</td>
												<td class="text-right">
													<input type="text" name="product_discount[<?php echo $discount_row; ?>][price]" value="<?php echo $product_discount['price']; ?>" class="form-control" />
												</td>
												<td class="text-left">
													<input type="text" name="product_discount[<?php echo $discount_row; ?>][date_start]" value="<?php echo $product_discount['date_start']; ?>" class="form-control datepicker" />
												</td>
												<td class="text-left">
													<input type="text" name="product_discount[<?php echo $discount_row; ?>][date_end]" value="<?php echo $product_discount['date_end']; ?>"  class="form-control" />
												</td>
												<td class="text-left">
													<button type="button" onclick="$('#discount-row<?php echo $discount_row; ?>').remove();" class="btn btn-danger">
														<i class="fa fa-minus-circle"></i> <?php echo $button_remove; ?>
													</button>
												</td>
											</tr>
											<?php $discount_row++; ?>
											<?php } ?>
										</tbody>
										<tfoot>
											<tr>
												<td colspan="6"></td>
												<td class="text-left">
													<button type="button" onclick="addDiscount();" class="btn btn-primary">
														<i class="fa fa-plus-circle"></i> <?php echo $button_add_discount; ?>
													</button>
												</td>
											</tr>
										</tfoot>
									</table>
								</div>
								<!-- FIELD DISCOUNTS -->
								<?php } ?>
								<!-- FIELD SPECIAL -->
								<div class="table-responsive">
									<div class="row form-group">
										<!-- FIELD PROMO BANNER -->
										<div class="col-xs-4">
											<label class="control-label" for="input-stock-status"><?php echo $entry_promo_banner; ?></label>
										</div>
										<div class="col-xs-8">
										<label class="control-label mb10" for="input-stock-status"><?php echo $entry_promo_date; ?></label>
										</div>
										<div class="col-xs-4">
											<select name="promo_top_right" class="form-control">
												<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
												<?php foreach ($promotags as $promotag) { ?>
												<?php if ($promotag['promo_direction'] == '0') { ?>
												<?php if ($promotag['promo_tags_id'] == $promo_top_right) { ?>
												<option value="<?php echo $promotag['promo_tags_id']; ?>" selected="selected"><?php echo $promotag['promo_text']; ?></option>
												<?php } else { ?>
												<option value="<?php echo $promotag['promo_tags_id']; ?>"><?php echo $promotag['promo_text']; ?></option>
												<?php } ?>
												<?php } ?>
												<?php } ?>
											</select>
										</div>
										<div class="col-xs-4">
											<input type="text" name="promo_date_start" value="<?php echo $promo_date_start;?>" class="form-control datepicker" data-date-format="YYYY-MM-DD HH:mm:ss" />
										</div>
										<div class="col-xs-4">
											<input type="text" name="promo_date_end" value="<?php echo $promo_date_end; ?>" class="form-control datepicker" data-date-format="YYYY-MM-DD HH:mm:ss" />
										</div>
										<!-- FIELD PROMO BANNER -->
									</div>
									<table id="special" class="table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<td class="text-left"><?php echo $entry_customer_group; ?></td>
												<td class="text-right"><?php echo $entry_priority; ?></td>
												<td class="text-right"><?php echo $entry_price; ?></td>
												<td class="text-left"><?php echo $entry_date_start; ?></td>
												<td class="text-left"><?php echo $entry_date_end; ?></td>
												<td></td>
											</tr>
										</thead>
										<tbody>
											<?php $special_row = 0; ?>
											<?php foreach ($product_specials as $product_special) { ?>
											<tr id="special-row<?php echo $special_row; ?>">
												<td class="text-left">
													<select name="product_special[<?php echo $special_row; ?>][customer_group_id]" class="form-control">
														<?php foreach ($customer_groups as $customer_group) { ?>
														<?php if ($customer_group['customer_group_id'] == $product_special['customer_group_id']) { ?>
														<option value="<?php echo $customer_group['customer_group_id']; ?>" selected="selected"><?php echo $customer_group['name']; ?></option>
														<?php } else { ?>
														<option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
														<?php } ?>
														<?php } ?>
													</select>
												</td>
												<td class="text-right">
													<input type="text" name="product_special[<?php echo $special_row; ?>][priority]" value="<?php echo $product_special['priority']; ?>" class="form-control" />
												</td>
												<td class="text-right">
													<input type="text" name="product_special[<?php echo $special_row; ?>][price]" value="<?php echo $product_special['price']; ?>" class="form-control" />
												</td>
												<td class="text-left">
													<input type="text" name="product_special[<?php echo $special_row; ?>][date_start]" value="<?php echo $product_special['date_start']; ?>" class="form-control datetimepicker" data-date-format="YYYY-MM-DD HH:mm:ss" />
												</td>
												<td class="text-left">
													<input type="text" name="product_special[<?php echo $special_row; ?>][date_end]" value="<?php echo $product_special['date_end']; ?>" class="form-control datetimepicker" data-date-format="YYYY-MM-DD HH:mm:ss" />
												</td>
												<td class="text-left">
													<button type="button" onclick="$('#special-row<?php echo $special_row; ?>').remove();" class="btn btn-danger">
														<i class="fa fa-minus-circle"></i> <?php echo $button_remove; ?>
													</button></td>
												</tr>
												<?php $special_row++; ?>
												<?php } ?>
											</tbody>
											<tfoot>
												<tr>
													<td colspan="5"></td>
													<td class="text-left">
														<button type="button" onclick="addSpecial();" class="btn btn-primary">
															<i class="fa fa-plus-circle"></i> <?php echo $button_add_special; ?>
														</button>
													</td>
												</tr>
											</tfoot>
										</table>
									</div>
									<!-- FIELD SPECIAL -->
									<!-- FIELD POINTS -->
									<?php if($this->config->get('config_bonus_points')) { ?>
									<div class="form-group">
										<label class="col-xs-2 control-label" for="input-points"><?php echo $entry_points; ?></label>
										<div class="col-xs-10">
											<input type="text" name="points" value="<?php echo $points; ?>" id="input-points" class="form-control" />
										</div>
									</div>
									<div class="table-responsive">
										<table class="table table-striped table-bordered table-hover">
											<thead>
												<tr>
													<td class="text-left"><?php echo $entry_customer_group; ?></td>
													<td class="text-right"><?php echo $entry_reward; ?></td>
												</tr>
											</thead>
											<tbody>
												<?php foreach ($customer_groups as $customer_group) { ?>
												<tr>
													<td class="text-left"><?php echo $customer_group['name']; ?></td>
													<td class="text-right">
														<input type="text" name="product_reward[<?php echo $customer_group['customer_group_id']; ?>][points]" value="<?php echo isset($product_reward[$customer_group['customer_group_id']]) ? $product_reward[$customer_group['customer_group_id']]['points'] : ''; ?>" class="form-control" />
													</td>
												</tr>
												<?php } ?>
											</tbody>
										</table>
									</div>
									<?php } ?>
								</div>
								<!-- //////////////////////////////////////////// -->	
								<div class="tab-pane" id="reklamL">
									
								</div>
								<!-- ///////////////////////////////////////////////// -->	
								<?php if($this->config->get('config_product_video')) { ?>
								<div class="tab-pane" id="video">

									<div class="col-xs-6">
										<label class="" for="input-video"><?php echo $entry_video; ?></label>
										<textarea name="video" id="input-video" class="form-control"><?php echo $video; ?></textarea>
									</div>
								</div>
								<?php } ?>
							</div>
						</div>
						<!-- TAB GENERAL -->
						<!-- TAB SEO -->
						<div class="tab-pane" id="tab-seo">
							<ul class="nav nav-tabs" id="language-seo">
								<?php $l = 0;foreach ($languages as $language) { ?>
								<li class="<?php if(!$l){print 'active';} ?>">
									<a href="#language-seo<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
								</li>
								<?php $l++;} ?>
							</ul>
							<div class="tab-content">
								<?php $l = 0; foreach ($languages as $language) { ?>
								<div class="tab-pane <?php if(!$l){print 'active';} ?>" id="language-seo<?php echo $language['language_id']; ?>">
									<!-- Custom H1 -->
									<div class="form-group">
										<label class="col-xs-12" for="input-custom-h1<?php echo $language['language_id']; ?>"><?php echo $entry_custom_h1; ?></label>
										<div class="col-xs-6">
											<input id="input-custom-h1<?php echo $language['language_id']; ?>" class="form-control" type="text" name="product_description[<?php echo $language['language_id']; ?>][custom_h1]" size="100" value="<?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['custom_h1'] : ''; ?>" />
										</div>
									</div>
									<!-- Custom H1 -->
									<!-- Custom ALT -->
									<div class="form-group">
										<label class="col-xs-12" for="input-custom-alt<?php echo $language['language_id']; ?>"><?php echo $entry_custom_alt; ?></label>
										<div class="col-xs-6">
											<input id="input-custom-alt<?php echo $language['language_id']; ?>" class="form-control" type="text" name="product_description[<?php echo $language['language_id']; ?>][custom_alt]" size="100" value="<?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['custom_alt'] : ''; ?>" />
										</div>
									</div>
									<!-- Custom ALT -->
									<!-- META DESCRIPTION -->
									<div class="form-group">
										<label class="col-xs-12" for="input-meta-description<?php echo $language['language_id']; ?>"><?php echo $entry_meta_description; ?></label>
										<div class="col-xs-6">
											<textarea name="product_description[<?php echo $language['language_id']; ?>][meta_description]" rows="5" id="input-meta-description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['meta_description'] : ''; ?></textarea>
										</div> 
									</div>
									<!-- META DESCRIPTION -->
									<!-- Custom Title --> 
									<div class="form-group">
										<label class="col-xs-12" for="input-custom-title<?php echo $language['language_id']; ?>"><?php echo $entry_custom_title; ?></label>
										<div class="col-xs-6">
											<input id="input-custom-title<?php echo $language['language_id']; ?>" class="form-control" type="text" name="product_description[<?php echo $language['language_id']; ?>][custom_title]" size="100" value="<?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['custom_title'] : ''; ?>" />
										</div>
									</div>
									<!-- Custom Title -->
									<!-- Meta keyword -->
									<div class="form-group">
										<label class="col-xs-12" for="input-meta-keyword<?php echo $language['language_id']; ?>"><?php echo $entry_meta_keyword; ?></label>
										<div class="col-xs-6">
											<input type="text" name="product_description[<?php echo $language['language_id']; ?>][meta_keyword]" rows="5" id="input-meta-keyword<?php echo $language['language_id']; ?>" value="<?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['meta_keyword'] : ''; ?>" class="form-control">
										</div>
									</div>
									<!-- Meta keyword -->
									<!-- FIELD KEYWORD -->
									<div class="form-group">
										<label class="col-xs-12" for="input-keyword"><?php echo $entry_keyword; ?></label>
										<div class="col-xs-6">
											<input id="input-keyword<?php print $language['language_id']; ?>" class="form-control" type="text" name="keyword[<?php echo $language['language_id']; ?>]" value="<?php  if (isset($keyword[$language['language_id']])) { echo $keyword[$language['language_id']]; } ?>" />
										</div>
									</div>
									<!-- FIELD KEYWORD -->
								</div>
								<?php $l++;} ?>
							</div>
						</div>
						<!-- END TAB SEO -->
						<!-- TAB DESIGN -->
						<?php if(isset($this->session->data['user_id']) && $this->session->data['user_id'] == 1) { ?>
						<div class="tab-pane" id="tab-design">
							<!-- FIELD DESIGN -->
							<div class="table-responsive">
								<table class="table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<td class="text-left"><?php echo $entry_store; ?></td>
											<td class="text-left"><?php echo $entry_layout; ?></td>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="text-left"><?php echo $text_default; ?></td>
											<td class="text-left">
												<select name="product_layout[0][layout_id]" class="form-control">
													<option value=""></option>
													<?php foreach ($layouts as $layout) { ?>
													<?php if (isset($product_layout[0]) && $product_layout[0] == $layout['layout_id']) { ?>
													<option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
													<?php } else { ?>
													<option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
													<?php } ?>
													<?php } ?>
												</select>
											</td>
										</tr>
										<?php foreach ($stores as $store) { ?>
										<tr>
											<td class="text-left"><?php echo $store['name']; ?></td>
											<td class="text-left">
												<select name="product_layout[<?php echo $store['store_id']; ?>][layout_id]" class="form-control">
													<option value=""></option>
													<?php foreach ($layouts as $layout) { ?>
													<?php if (isset($product_layout[$store['store_id']]) && $product_layout[$store['store_id']] == $layout['layout_id']) { ?>
													<option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
													<?php } else { ?>
													<option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
													<?php } ?>
													<?php } ?>
												</select>
											</td>
										</tr>
										<?php } ?>
									</tbody>
								</table>
							</div>
							<!-- FIELD DESIGN -->
						</div>
						<!-- TAB DESIGN -->
						<?php } else { ?>
						<?php foreach ($stores as $store) { ?>
						<input type="hidden"  name="product_layout[<?php echo $store['store_id']; ?>][layout_id]" value="<?php foreach ($layouts as $layout) { ?><?php if (isset($product_layout[$store['store_id']]) && $product_layout[$store['store_id']] == $layout['layout_id']) { ?><?php print $layout['layout_id']; ?><?php } ?><?php } ?>">
						<?php } ?>
						<?php } ?>
					</div>
					<!--END DESI-->
				</form>
			</div>
		</div>
	</div>
	<link rel="stylesheet" href="view/javascript/bootstrap-tagsinput/bootstrap-tagsinput.css">
	<script src="view/javascript/bootstrap-tagsinput/bootstrap-tagsinput.js"></script>
	<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>
	<script type="text/javascript">

		<?php foreach ($languages as $language) { ?>
		CKEDITOR.replace('input-description<?php echo $language['language_id']; ?>', {
			filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
		});
		<?php if($this->config->get('config_short_product_description')) {?>
		CKEDITOR.replace('input-short-description<?php echo $language['language_id']; ?>', {
			filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
		});
		<?php } ?>
		<?php } ?>
	</script>
	<script type="text/javascript">
	$('input[name=\'manufacturer\']').autocomplete({
		'source' : function(request, response) {
			$.ajax({
				url : 'index.php?route=catalog/manufacturer/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
				dataType : 'json',
				success : function(json) {
					json.unshift({
						'manufacturer_id' : 0,
						'name' : '<?php echo $text_none; ?>'
					});
					response($.map(json, function(item) {
						return {
							label : item['name'],
							value : item['manufacturer_id']
						}
					}));
				}
			});
		},
		'select' : function(item) {
			$('input[name=\'manufacturer\']').val(item['label']);
			$('input[name=\'manufacturer_id\']').val(item['value']);
		}	
	});
	$('input[name=\'category\']').autocomplete({ 
		'source' : function(request, response) {
			$.ajax({
				url : 'index.php?route=catalog/category/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
				dataType : 'json',
				success : function(json) {
					response($.map(json, function(item) {
						return {
							label : item['name'],
							value : item['category_id']
						}
					}));
				}
			});
		},
		'select' : function(item) {
			$('input[name=\'category\']').val('');
			$('#product-category' + item['value']).remove();
			$('#product-category').append('<div id="product-category' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="product_category[]" value="' + item['value'] + '" /></div>');
		}
	});
	$('#product-category').delegate('.fa-minus-circle', 'click', function() {
		$(this).parent().remove();
	});
	$('#product-filter').delegate('.fa-minus-circle', 'click', function() {
		$(this).parent().remove();
	});

	// Downloads
	$('input[name=\'download\']').autocomplete({
		'source' : function(request, response) {
			$.ajax({
				url : 'index.php?route=catalog/download/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
				dataType : 'json',
				success : function(json) {
					response($.map(json, function(item) {
						return {
							label : item['name'],
							value : item['download_id']
						}
					}));
				}
			});
		},
		'select' : function(item) {
			$('input[name=\'download\']').val('');
	
			$('#product-download' + item['value']).remove();
	
			$('#product-download').append('<div id="product-download' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="product_download[]" value="' + item['value'] + '" /></div>');
		}
	});
	$('#product-download').delegate('.fa-minus-circle', 'click', function() {
		$(this).parent().remove();
	});

	// Related
	$('input[name=\'related\']').autocomplete({
		'source' : function(request, response) {
			$.ajax({
				url : 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
				dataType : 'json',
				success : function(json) {
					response($.map(json, function(item) {
						return {
							label : item['name'],
							value : item['product_id']
						}
					}));
				}
			});
		},
		'select' : function(item) {
			$('input[name=\'related\']').val('');
			$('#product-related' + item['value']).remove();
			$('#product-related').append('<div id="product-related' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="product_related[]" value="' + item['value'] + '" /></div>');
		}
	});
	$('#product-related').delegate('.fa-minus-circle', 'click', function() {
		$(this).parent().remove();
	});
	</script>
	<script type="text/javascript">
	var attribute_row =    <?php echo $attribute_row; ?>;
	function addAttribute() {
		html = '<tr id="attribute-row' + attribute_row + '">';
		html += '  <td class="text-left"><input type="text" name="product_attribute[' + attribute_row + '][name]" value="" class="form-control" /><input type="hidden" name="product_attribute[' + attribute_row + '][attribute_id]" value="" /></td>';
		html += '  <td class="text-left">';
		<?php foreach ($languages as $language) { ?>
			html += '<div class="input-group col-xs-6"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span><textarea name="product_attribute[' + attribute_row + '][product_attribute_description][<?php echo $language['language_id']; ?>][text]" rows="5" class="form-control"></textarea></div>';
			<?php } ?>
			html += '  </td>';
			html += '  <td class="text-left"><button type="button" onclick="$(\'#attribute-row' + attribute_row + '\').remove();" class="btn btn-danger"><i class="fa fa-minus-circle"></i> <?php echo $button_remove; ?></button></td>';
			html += '</tr>';

			$('#attribute tbody').append(html);

			attributeautocomplete(attribute_row);

			attribute_row++;
	}
	function attributeautocomplete(attribute_row) {
		$('input[name=\'product_attribute[' + attribute_row + '][name]\']').autocomplete({
			'source' : function(request, response) {
				$.ajax({
					url : 'index.php?route=catalog/attribute/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
					dataType : 'json',
					success : function(json) {
						response($.map(json, function(item) {
							return {
								category : item.attribute_group,
								label : item.name,
								value : item.attribute_id
							}
						}));
					}
				});
			},
			'select' : function(item) {
				$('input[name=\'product_attribute[' + attribute_row + '][name]\']').val(item['label']);
				$('input[name=\'product_attribute[' + attribute_row + '][attribute_id]\']').val(item['value']);
			}
		});
	}
	$('#attribute tbody tr').each(function(index, element) {
		attributeautocomplete(index);
	});
	</script>
	<script type="text/javascript">
		var option_row = <?php echo $option_row; ?>;
		$('input[name=\'option\']').autocomplete({
			'source': function(request, response) {
				$.ajax({
					url: 'index.php?route=catalog/option/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
					dataType: 'json',
					success: function(json) {

						var exists = [];
						$('#option>li>a').each(function(){
							exists.push($.trim($(this).text()));
						});

						var newJson = [];
						for(var index = 0; index < json.length; index++){
							if(jQuery.inArray(json[index].name, exists) == -1){
								newJson.push(json[index]);
							}
						}

						response($.map(newJson, function(item) {
							return {
								category: item['category'],
								label: item['name'],
								product_page: item['product_page'],
								value: item['option_id'],
								type: item['type'],
								option_value: item['option_value']
							}
						}));
					}
				});
			},
			'select': function(item) {
				html  = '<div class="tab-pane" id="tab-option' + option_row + '">';
				html += '	<input type="hidden" name="product_option[' + option_row + '][product_option_id]" value="" />';
				html += '	<input type="hidden" name="product_option[' + option_row + '][name]" value="' + item['label'] + '" />';
				html += '	<input type="hidden" name="product_option[' + option_row + '][option_id]" value="' + item['value'] + '" />';
				html += '	<input type="hidden" name="product_option[' + option_row + '][type]" value="' + item['type'] + '" />';

				html += '	<div class="form-group">';
				html += '	  <label class="col-xs-12 control-label" for="input-required' + option_row + '"><?php echo $entry_required; ?></label>';
				html += '	  <div class="col-xs-12"><div class="btn-group" data-toggle="buttons">';
				if(item.product_page != 1) {

				} else {
					html += '	      <label class="btn btn-warning"><i class="fa fa-check"></i> <input type="radio" name="product_option[' + option_row + '][required]" id="input-required' + option_row + '" id="input-status"> <?php echo $text_yes; ?></label>';
				}
				html += '	      <label class="btn btn-warning active"><i class="fa fa-times"></i> <input type="radio" name="product_option[' + option_row + '][required]" id="input-required' + option_row + '" id="input-status" checked> <?php echo $text_no; ?></label>';
				html += '	  </div></div>';
				html += '	</div>';

				if (item['type'] == 'select') {
					html += '<div class="table-responsive">';
					html += '  <table class="table table-striped table-bordered table-hover">';
					html += '     <tr>';
					html += '       <td><?php echo $entry_parent_option; ?></td>';
					html += '       <td><select id="parent-' + option_row + '" name="product_option[' + option_row + '][parent_option_id]" class="form-control">';
					html += '           <option value=""><?php echo $text_none; ?></option>';
					<?php foreach ($select_options as $select_option) { ?>
					if (item['value'] !== '<?php echo $select_option['option_id']; ?>') {
						html += '           <option value="<?php echo $select_option['option_id']; ?>"><?php echo addslashes($select_option['name']); ?></option>';
					}
					<?php } ?>
					html += '       </select></td>';
					html += '     </tr>';
					html += '  </table>';
					html += '</div>';
				}

				if (item['type'] == 'text') {
					html += '	<div class="form-group">';
					html += '	  <label class="col-xs-12 control-label" for="input-value' + option_row + '"><?php echo $entry_option_value; ?></label>';
					html += '	  <div class="col-xs-12"><input type="text" name="product_option[' + option_row + '][option_value]" value="" id="input-value' + option_row + '" class="form-control" /></div>';
					html += '	</div>';
				}

				if (item['type'] == 'textarea') {
					html += '	<div class="form-group">';
					html += '	  <label class="col-xs-12 control-label" for="input-value' + option_row + '"><?php echo $entry_option_value; ?></label>';
					html += '	  <div class="col-xs-12"><textarea name="product_option[' + option_row + '][option_value]" rows="5" id="input-value' + option_row + '" class="form-control"></textarea></div>';
					html += '	</div>';
				}

				if (item['type'] == 'file') {
					html += '	<div class="form-group" style="display: none;">';
					html += '	  <label class="col-xs-12 control-label" for="input-value' + option_row + '"><?php echo $entry_option_value; ?></label>';
					html += '	  <div class="col-xs-12"><input type="text" name="product_option[' + option_row + '][option_value]" value="" id="input-value' + option_row + '" class="form-control" /></div>';
					html += '	</div>';
				}

				if (item['type'] == 'date') {
					html += '	<div class="form-group">';
					html += '	  <label class="col-xs-12 control-label" for="input-value' + option_row + '"><?php echo $entry_option_value; ?></label>';
					html += '	  <div class="col-xs-12"><input type="text" name="product_option[' + option_row + '][option_value]" value="" id="input-value' + option_row + '" class="form-control datepicker" /></div>';
					html += '	</div>';
				}

				if (item['type'] == 'datetime') {
					html += '	<div class="form-group">';
					html += '	  <label class="col-xs-12 control-label" for="input-value' + option_row + '"><?php echo $entry_option_value; ?></label>';
					html += '	  <div class="col-xs-12"><input type="datetime-local" name="product_option[' + option_row + '][option_value]" value="" id="input-value' + option_row + '" class="form-control" /></div>';
					html += '	</div>';
				}

				if (item['type'] == 'time') {
					html += '	<div class="form-group">';
					html += '	  <label class="col-xs-12 control-label" for="input-value' + option_row + '"><?php echo $entry_option_value; ?></label>';
					html += '	  <div class="col-xs-12"><input type="time" name="product_option[' + option_row + '][option_value]" value="" id="input-value' + option_row + '" class="form-control" /></div>';
					html += '	</div>';
				}

				if (item['type'] == 'select' || item['type'] == 'radio' || item['type'] == 'radiocolor' || item['type'] == 'radiolabel' || item['type'] == 'checkbox' || item['type'] == 'checkboxcolor' || item['type'] == 'checkboxlabel' || item['type'] == 'checkboxcolor' || item['type'] == 'radiocolor' || item['type'] == 'image' || item['type'] == 'custom_text' ) {
					html += '<div class="table-responsive">';
					html += '  <table id="option-value' + option_row + '" class="table table-striped table-bordered table-hover">';
					html += '  	 <thead>';
					html += '      <tr>';
					html += '        <td class="text-left"><?php echo $entry_option_value; ?></td>';
					html += '        <td class="text-right"><?php echo $entry_quantity; ?></td>';
					html += '        <td class="text-left"><?php echo $entry_subtract; ?></td>';
					if (item['type'] == 'select') {
						html += '    <td class="left"><?php echo $entry_parent_option_value; ?></td>';
					}
					html += '        <td class="text-right"><?php echo $entry_price; ?></td>';
					html += '        <td class="text-right"><?php echo $entry_option_points; ?></td>';
					html += '        <td class="text-right"><?php echo $entry_weight; ?></td>';
					html += '        <td></td>';
					html += '      </tr>';
					html += '  	 </thead>';
					html += '  	 <tbody>';
					html += '    </tbody>';
					html += '    <tfoot>';
					html += '      <tr>';
					if (item['type'] == 'select') {
						html += '        <td colspan="7"></td>';
					} else {
						html += '        <td colspan="6"></td>';
					}
					html += '        <td class="text-left"><button type="button" onclick="addOptionValue(' + option_row + ', \'' + item['type'] + '\');" class="btn btn-primary"><i class="fa fa-plus-circle"></i> <?php echo $button_add_option_value; ?></button></td>';
					html += '      </tr>';
					html += '    </tfoot>';
					html += '  </table>';
					html += '</div>';

					html += '  <select id="option-values' + option_row + '" style="display: none;">';

					for (i = 0; i < item['option_value'].length; i++) {
						html += '  <option value="' + item['option_value'][i]['option_value_id'] + '">' + item['option_value'][i]['name'] + '</option>';
					}

					html += '  </select>';
					html += '</div>';
				}

				$('#tab-option .tab-content').append(html);

				$('#option > li:last-child').before('<li><a href="#tab-option' + option_row + '" data-toggle="tab"><i class="fa fa-minus-circle" onclick="$(\'a[href=\\\'#tab-option' + option_row + '\\\']\').parent().remove(); $(\'#tab-option' + option_row + '\').remove(); $(\'#option a:first\').tab(\'show\')"></i> ' + item['label'] + '</li>');

				$('#option a[href=\'#tab-option' + option_row + '\']').tab('show');

				option_row++;
			}
		});
	</script>
	<script type="text/javascript">
	var option_value_row =    <?php echo $option_value_row; ?>;
	function addOptionValue(option_row, type) {
		console.log('in add option value method');
		html = '<tr id="option-value-row' + option_value_row + '">';
		html += '  <td class="text-left"><select name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][option_value_id]" class="form-control">';
		html += $('#option-values' + option_row).html();
		html += '  </select><input type="hidden" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][product_option_value_id]" value="" /></td>';
		html += '  <td class="text-right"><input type="text" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][quantity]" value=""  class="form-control" /></td>';
		html += '  <td class="text-left"><select name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][subtract]" class="form-control">';
		html += '    <option value="0" selected="selected"><?php echo $text_no; ?></option>';
		html += '    <option value="1"><?php echo $text_yes; ?></option>';
		html += '  </select></td>';
		if (type == 'select') {
			html += '    <td class="left"><select id="child-' + option_value_row + '" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][parent_option_value][]" multiple="multiple">';
			<?php foreach ($select_option_values as $select_option_value) { ?>
			html += '      <option value="<?php echo $select_option_value['option_value_id']; ?>" class="<?php echo $select_option_value['option_id']; ?>" selected="selected"><?php echo addslashes($select_option_value['name']); ?></option>';
			<?php } ?>
			html += '    </select></td>';
		}
		html += '  <td class="text-right"><select name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][price_prefix]" class="form-control">';
		html += '    <option value="+">+</option>';
		html += '    <option value="-">-</option>';
		html += '  </select>';
		html += '  <input type="text" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][price]" value="" class="form-control" /></td>';
		html += '  <td class="text-right"><select name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][points_prefix]" class="form-control">';
		html += '    <option value="+">+</option>';
		html += '    <option value="-">-</option>';
		html += '  </select>';
		html += '  <input type="text" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][points]" value="" class="form-control" /></td>';
		html += '  <td class="text-right">';
		html += '  <input type="hidden" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][weight_prefix]" value="+" />';
		html += '  <input type="hidden" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][weight]" value="0" />';
		html += '  <img src="<?php echo $no_image ?>" alt="" class="img-thumbnail" id="thumb' + option_value_row + '" />';
		html += '  <input type="hidden" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][product_option_image]" value="no_image.jpg" id="image' + option_value_row + '"/><br /><br />';
		html += '  <div class="btn-group">';
		html += '  <button type="button" data-toggle="modal" data-target="#dialog" class="btn btn-info" onclick="image_upload(\'image' + option_value_row + '\', \'thumb' + option_value_row + '\');"><span class="fa fa-pencil"></span> <?php echo $text_browse; ?></button>';
		html += '  <button type="button" onclick="$(\'#thumb' + option_value_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#image' + option_value_row + '\').attr(\'value\', \'\');return false;" class="btn btn-danger"><span class="fa fa-trash-o"></span> <?php echo $text_clear; ?></button>';
		html += '  </div>';
		html += '  </td>';
		html += '  <td class="text-left"><button type="button" onclick="$(\'#option-value-row' + option_value_row + '\').remove();" class="btn btn-danger"><i class="fa fa-minus-circle"></i> <?php echo $button_remove; ?></button></td>';
		html += '</tr>';
		if (type == 'select') {
			html += '<script type="text/javascript">';
			html += '$(\'#child-' + option_value_row + '\').chained(\'#parent-' + option_row + '\');';
			html += '<\/script>';
		}
		$('#option-value' + option_row + ' tbody').append(html);
		option_value_row++;
	}
	</script>

	<?php if($this->config->get('config_product_percent_events')) { ?>
	<script type="text/javascript">
	var discount_row =    <?php echo $discount_row; ?>;
	function addDiscount() {
		html = '<tr id="discount-row' + discount_row + '">';
		html += '  <td class="text-left"><select name="product_discount[' + discount_row + '][customer_group_id]" class="form-control">';
		<?php foreach ($customer_groups as $customer_group) { ?>
		html += '    <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>';
		<?php } ?>
		html += '  </select></td>';
		html += '  <td class="text-right"><input type="text" name="product_discount[' + discount_row + '][quantity]" value="" class="form-control" /></td>';
		html += '  <td class="text-right"><input type="text" name="product_discount[' + discount_row + '][priority]" value="" class="form-control" /></td>';
		html += '  <td class="text-right"><input type="text" name="product_discount[' + discount_row + '][price]" value="" class="form-control" /></td>';
		html += '  <td class="text-left"><input type="date" name="product_discount[' + discount_row + '][date_start]" value="" class="form-control" /></td>';
		html += '  <td class="text-left"><input type="date" name="product_discount[' + discount_row + '][date_end]" value="" class="form-control" /></td>';
		html += '  <td class="text-left"><button type="button" onclick="$(\'#discount-row' + discount_row + '\').remove();" class="btn btn-danger"><i class="fa fa-minus-circle"></i> <?php echo $button_remove; ?></button></td>';
		html += '</tr>';

		$('#discount tbody').append(html);

		discount_row++;
	}
	</script>
	<?php } ?>
	<script type="text/javascript">

	var special_row =    <?php echo $special_row; ?>;

	function addSpecial() {
		html = '<tr id="special-row' + special_row + '">';
		html += '  <td class="text-left"><select name="product_special[' + special_row + '][customer_group_id]" class="form-control">';
		<?php foreach ($customer_groups as $customer_group) { ?>
		html += '      <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>';
		<?php } ?>
		html += '  </select></td>';
		html += '  <td class="text-right"><input type="text" name="product_special[' + special_row + '][priority]" value="" class="form-control" /></td>';
		html += '  <td class="text-right"><input type="text" name="product_special[' + special_row + '][price]" value="" class="form-control" /></td>';
		html += '  <td class="text-left"><input type="text" name="product_special[' + special_row + '][date_start]" value="" class="form-control datetimepicker" data-date-format="YYYY-MM-DD HH:mm:ss" /></td>';
		html += '  <td class="text-left"><input type="text" name="product_special[' + special_row + '][date_end]" value="" class="form-control datetimepicker" data-date-format="YYYY-MM-DD HH:mm:ss" /></td>';
		html += '  <td class="text-left"><button type="button" onclick="$(\'#special-row' + special_row + '\').remove();" class="btn btn-danger"><i class="fa fa-minus-circle"></i> <?php echo $button_remove; ?></button></td>';
		html += '</tr>';

		$('#special tbody').append(html);
		$('.datetimepicker').datetimepicker({
			language: 'ru'
		});
		special_row++;
	}
	</script>
	<div class="modal fade" id="dialog" data-field="" data-thumb="">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						&times;
					</button>
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

	$(document.body).on('show.bs.modal', '#dialog', function() {
		$(this).find('#dialog-confirm').addClass('hide');
	});

	$(document.body).on('hidden.bs.modal', '#dialog', function() {
		var field = $(this).attr('data-field');
		var thumb = $(this).attr('data-thumb');

		if ($('#' + field).attr('value')) {
			$.ajax({
				url : 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).val()) + '&json=1',
				dataType : 'JSON',
				success : function(data) {
					console.log(data);
					$('#' + thumb).replaceWith('<img src="' + data.thumb + '" alt="" id="' + thumb + '">');
					var row = field.replace('img-image', '');

					var isDefaultExist = false;
					$('#images input[type="radio"]').each(function() {
						if ($(this).is(':checked'))
							isDefaultExist = true;
					});

					if (isDefaultExist == false) {
						$('#image-row' + row + ' input[type="radio"]').prop('checked', 'checked');
						$('#image-row' + row + ' input[type="radio"]').attr('checked', 'checked');
					}

					$('#image-row' + row + ' input[type="radio"]').removeAttr('disabled');
					$('#image-row' + row + ' input[type="radio"]').val(data.image);
				}
			});
		}
		$('#dialog').attr('data-field', '');
		$('#dialog').attr('data-thumb', '');
		$('#dialog #fm-iframe').attr('src', '');
	}); 
	</script>
	<script type="text/javascript">
	var image_row =    <?php echo $image_row; ?>;
	function addImage() {
		html = '<tr id="image-row' + image_row + '">';
		html += '  <td class="text-left"><img src="<?php echo $no_image; ?>" alt="" class="img-thumbnail" id="img-thumb' + image_row + '"/><input type="hidden" name="product_image[' + image_row + '][image]" value="" id="img-image' + image_row + '"/></td>';
		html += '  <td class="text-left"><div class="btn-group"><button type="button" data-toggle="modal" data-target="#dialog" class="btn btn-success" onclick="image_upload(\'img-image' + image_row + '\', \'img-thumb' + image_row + '\');"><span class="fa fa-pencil"></span> <?php echo $text_browse; ?></button><button class="btn btn-info" onclick="$(\'#img-thumb' + image_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#img-image' + image_row + '\').attr(\'value\', \'\');return false"><span class="fa fa-trash-o"></span> <?php echo $text_clear; ?></button><button type="button" onclick="$(\'#image-row' + image_row + '\').remove();" class="btn btn-danger"><i class="fa fa-minus-circle"></i> <?php echo $button_remove; ?></button></div></td>';
		html += '  <td class="text-right"><input type="text" name="product_image[' + image_row + '][sort_order]" value="" class="form-control" /></td>';
		html += '  <td class="text-right"><input type="radio" name="def_img" id="radio_' + image_row + '" value="" disabled="disabled"></td>';
		
		html += '</tr>';
		$('#images tbody').append(html);

		image_row++;
	}
	</script>
	<script type="text/javascript">
	$("input#input-tag<?php echo $language['language_id']; ?>").val();
	$("input#input-meta-keyword<?php echo $language['language_id']; ?>").val();
	$("input#input-keyword").val();
	$('#language a:first').tab('show');
	$('#option a:first').tab('show');
	//-->
	</script>
	<script type="text/javascript">
	// Product filter start
	var filter = {
		update : function() {
			//     var category_id = $('input[name=\'product_category[]\']:checked:last').val(), html = '';
			var category_id = $('input[name=\'product_category[]\']').last().val(), html = '';
			if (category_id) {
				$.get('index.php?route=catalog/filter/callback', 'token=<?php echo $token; ?>&category_id=' + category_id + (filter.product_id ? '&product_id=' + filter.product_id : ''), function(json) {
					if (!json['message']) {
						html += '<table class="form">';

						$.each(json['options'], function(k, o) {
							var values = '', selecteds = '';

							html += '<tr' + (o['status'] == 0 ? ' class="disabled"' : '') + '>';
							html += '<td width="20%"><b>' + o['name'] + '</b></td>';
							html += '<td width="80%">';

							if (o['values'].length) {
								$.each(o['values'], function(kv, v) {
									var checked = '';

									if (v['selected']) {
										selecteds += '<span id="v-' + v['value_id'] + '">' + v['name'] + o['postfix'] + '</span>';
										checked += ' checked="checked"';
									}

									values += '<label><input type="checkbox" name="product_to_value_id[' + o['option_id'] + '][values][' + v['value_id'] + ']" value="' + v['value_id'] + '"' + checked + ' />' + v['name'] + o['postfix'] + '</label>';
								});

								if (!selecteds)
									selecteds = '<b><?php echo $text_select; ?></b>';

								html += '<div class="switcher"><div class="selected">' + selecteds + '</div><div class="values">' + values + '</div>';
							} else {
								html += '<a href="index.php?route=catalog/filter/update&token=<?php echo $token; ?>&option_id=' + o['option_id'] + '" target="_blank"><?php echo $entry_values; ?></a>';
							}
							html += '</td>';
							html += '</tr>';

						});
					html += '</table>';
					} else {
						html = '<p style="text-align:center;font-size:20px;">' + json['message'] + '</p>';
					}
				
					$('#tab-product-filter').html(html);
				}, 'json');
			} else {
				$('#tab-product-filter').html('<p style="text-align:center;font-size:20px;"><?php echo $text_select_category; ?></p>');
			}
		},
		product_id : 0
	}
	<?php if (isset($this->request->get['product_id'])) { ?>
	filter.product_id =    <?php echo $this->request->get['product_id']; ?>;
	filter.update();
	<?php } ?>
	$('input[name=\'product_category[]\']').live('change', function() {
		filter.update();
	});
	// Start filter switcher
	$(document).ready(function() {
		$('.switcher .selected').on('click', function() {

			$('.values').hide();

			if (!$(this).hasClass('active')) {
				$('.switcher .selected').removeClass('active');
				$('.switcher').removeClass('switcher-active');
				$(this).addClass('active').parent().addClass('switcher-active');
				$(this).next('.values').show();
			} else {
				$(this).removeClass('active').parent().removeClass('switcher-active');
				$(this).next('.values').hide();
			}
		});

		$('.switcher input').live('change', function() {
			var selected = $(this).parents('.switcher').find('.selected');
			var text = $(this).parent('label').text();
			var length = selected.find('span').length;

			selected.find('b').remove();

			if ($(this).prop('checked')) {
				selected.append('<span id="v-' + this.value + '">' + text + '</span>');
			} else {
				var span = $('#v-' + this.value);

				if (length == 1) {
					span.replaceWith('<b><?php echo $text_select; ?></b>');
				} else {
					span.remove();
				}
			}
		});
	});
	$(document).click(function(e) {
		if ($(e.target).parents().filter('.switcher').length != 1) {
			$('.values').hide();
			$('.selected').removeClass('active');
		}
	});
	// End filter switcher
	</script>
	<script type="text/javascript">
	<!--$('#language a:first').tab('show');
	$('#option a:first').tab('show');
	//-->
	</script>
	<script type="text/javascript">
	<!--
	var uploader = new qq.FileUploader({
		element : document.getElementById('file-uploader'),
		action : 'index.php?route=tool/upload&token=<?php echo $token;?>',
		allowedExtensions : ['jpg', 'jpeg', 'png', 'gif'],
		onComplete : function(id, fileName, responseJSON) {
			addMultiImage(responseJSON.fileName);
		}
	});
	$(document).ready(function() {
		$(document).on('click', '.qq-upload-button > a', function() {
			$(this).parent('div').children('input[type=file]').trigger('click');
		});
	});
	var image_row =    <?php echo $image_row; ?>;
	function addMultiImage(img) {
		html = '<tr id="image-row' + image_row + '">';
		html += '  <td class="text-left"><img src="<?php echo HTTP_CATALOG."image"; ?>/' + img + '" alt="" class="img-thumbnail" id="img-thumb' + image_row + '" /><input type="hidden" name="product_image[' + image_row + '][image]" value="' + img + '" id="img-image' + image_row + '"/></td>';
		//html += '  <td class="text-left"><div class="btn-group"><button type="button" data-toggle="modal" data-target="#dialog" class="btn btn-info" onclick="image_upload(\'img-image' + image_row + '\', \'img-thumb' + image_row + '\');"><span class="fa fa-pencil"></span> <?php echo $text_browse; ?></button><button class="btn btn-danger" onclick="$(\'#img-thumb' + image_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#img-image' + image_row + '\').attr(\'value\', \'\');return false"><span class="fa fa-trash-o"></span> <?php echo $text_clear; ?></button></div></td>';
		html += '  <td class="text-right"><input type="text" name="product_image[' + image_row + '][sort_order]" value="0" class="form-control" /></td>';
		html += '  <td class="text-right"><input type="radio" name="def_img" id="radio_' + image_row + '" value="' + img + '"></td>';
		html += '  <td class="text-left"><button type="button" onclick="$(\'#image-row' + image_row + '\').remove();" class="btn btn-danger"><i class="fa fa-minus-circle"></i> <?php echo $button_remove; ?></button></td>';
		html += '</tr>';

		$('#images tbody').append(html);

		var isDefaultExist = false;
		$('#images input[type="radio"]').each(function() {
			if ($(this).is(':checked'))
				isDefaultExist = true;
		});

		if (isDefaultExist == false) {
			$('#image-row' + image_row + ' input[type="radio"]').prop('checked', 'checked');
			$('#image-row' + image_row + ' input[type="radio"]').attr('checked', 'checked');
		}

		image_row++;
	}

	//-->
	</script>
	<script>
		var isCtrl = false;
		$(document).keyup(function(e) {
			if (e.which == 17)
				isCtrl = false;
		}).keydown(function(e) {
			if (e.which == 17)
				isCtrl = true;
			if (e.which == 83 && isCtrl == true) {
				$('#content > div > div.panel-heading > div > button').trigger('click');
				return false;
			}
		}); 
	</script>
	<script type="text/javascript">
	$(function () {
		$('.datetimepicker').datetimepicker({
			language: 'ru'
		});
	});
	</script>
	<script type="text/javascript">
		var opts = {
    		title: 'Проверьте форму',
    		type: 'error',
	        styling: 'bootstrap3',
        	addclass: 'oc_noty',
        	icon: 'picon picon-32 picon-fill-color',
        	opacity: .8,
        	nonblock: {
        		nonblock: true
        	}
		};
		/*** Проверка на наименование товара (RUS/ENG) ***/
		<?php foreach ($languages as $language) { ?>
			<?php if (isset($error_name[$language['language_id']])) { ?>
				$(function () {
					$('#input-name<?php echo $language['language_id']; ?>').css('border-color', '#F00');
					opts.text = '<?php echo $error_name[$language['language_id']]; ?> (Язык формы: <?php echo $language['name']; ?>)'
				    new PNotify(opts);
				});
			<?php } ?>
		<?php } ?>
		/*** Проверка на артикуль товара ***/
		<?php if ($error_model) { ?>
			$(function () {
				$('#input-model').css('border-color', '#F00');
		    	opts.text = '<?php echo $error_model; ?>';
		        new PNotify(opts);
			});
		<?php } ?>
	</script>
<?php echo $footer; ?>