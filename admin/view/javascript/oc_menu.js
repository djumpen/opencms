/*
 * Pre actions
 */
$.fn.exists = function(){
	return this.length>0;
}
$.fn.getSelection = window.getSelection;
$(document).ready(function(){
	oc_menu.init();
});

/*
 * OC_MENU Events
 * */
$(document).on('click', '.save-list', function(){
	oc_menu.save_list();
});
$(document).on('click', 'button.delete', function(){
	var delete_group_element = this
	confirm('Вы уверены?', function(result){
		if(result) {
			if($(delete_group_element).attr('group-id') != undefined) {
				$(delete_group_element).parent('td').parent('tr').fadeOut(250).promise().done(function(){
					var group_id = $(delete_group_element).attr('group-id');
					oc_menu.delete_group(group_id);
					$('tr[group-id="' + group_id + '"]').remove();
				});
			}
		}
	});
});
$(document).on('click', '.actions button.edit', function(){
	var group_id = $(this).attr('group-id');
	oc_menu.open_list_box(group_id);
});
// Add new element to menu list
$(document).on('click', '.modal-footer .list-add', function(){
	oc_menu.open_form_box(false, false);
});
// Edit element in menu-list
$(document).on('click', '.node-info .fa-edit', function(){
	var node_id = parseInt($(this).parents('.node').attr('node-id'));
	node_id = node_id || 0;
	var node_tmp_id = parseInt($(this).parents('.node').attr('node-tmp-id'));
	node_tmp_id = node_tmp_id || 0;
	oc_menu.open_form_box(node_id, node_tmp_id);
});
// Delete element from menu-list
$(document).on('click', '.node-info .fa-times', function(){
	var _this = this;
	confirm({
		title: "Удаление элемента",
	    message: 'Вы уверены?',
	    callback: function(resolve) {
	    	if(resolve) {
	    		var node_id     = parseInt($(_this).attr('node-id'));
	    		var node_tmp_id = parseInt($(_this).attr('node-tmp-id'));
	    		var childs      = [];//Containe childs node-id and node-tmp-id
	    		$parent = $(_this).parents('.node').first().find('.node').each(function(){
	    			var node_id     = parseInt($(this).attr('node-id'));
	    			var node_tmp_id = parseInt($(this).attr('node-tmp-id'));
	    			childs.push({
	    				node_id: node_id,
	    				node_tmp_id: node_tmp_id
	    			});
	    		});
	    		if(node_id) {
	    			oc_menu.branch_data[node_id]['delete'] = true;
	    		} else if(node_tmp_id) {
	    			delete oc_menu.branch_data[0][node_tmp_id];
	    		}
	    		for(var c=0;c<childs.length;c++) {
	    			if(childs[c].node_id) {
	    				oc_menu.branch_data[childs[c].node_id]['delete'] = true;
	    			} else if(childs[c].node_tmp_id) {
	    				delete oc_menu.branch_data[0][childs[c].node_tmp_id];
	    			}
	    		}
	    		$(_this).parents('.node').first().remove();
	    	}
	    }
	});
});
// Save menu list
$(document).on('click', '.modal-footer .list-save', function(){
	oc_menu.saveMenu();
	$(this).parents('.modal-dialog').find('.close').first().trigger('click');
});
// Discard performed chages
$(document).on('click', '.modal-footer .list-discard', function(){
	oc_menu.branch_data = [];
	$(this).parents('.modal-dialog').find('.close').first().trigger('click');
});
// Switch element type
$(document).on('change', '.menu-edit-form .element-type', function(){
	var type_key = $(this).children('option:selected').attr('type-key');
	$('.menu-edit-form .element-type-properties').fadeOut(1).promise().done(function(){
		$(this).addClass('hidden');
		$('.menu-edit-form .element-type-properties.' + type_key).removeClass('hidden');
		$('.menu-edit-form .element-type-properties.' + type_key).fadeIn(1).promise().done(function(){
			oc_menu.applySelectedType[type_key]();
		});
	});
});
// Validate columns quantity and add/remove new column data form elements
$(document).on('change', '.menu-edit-form .element-column-quantity', function(){
	var quantity  = parseInt($(this).val());

	var min_value = parseInt($(this).attr('min'));
	var max_value = parseInt($(this).attr('max'));
	
	if(isNaN(quantity) || quantity < 1) {
		quantity = 1;
	}
	if(typeof min_value != undefined) {
		if(quantity < min_value) {
			quantity = min_value;
		}
	}
	if(typeof max_value != undefined) {
		if(quantity > max_value) {
			quantity = max_value;
		}
	}
	
	$(this).val(quantity);
	
	oc_menu.changeColumnsQuantity(quantity);
});
// Discard button for menu-edit-form
$(document).on('click', '.modal-footer .form-discard', function(){
	$(this).parents('.modal-dialog').find('.close').first().trigger('click');
});
$(document).on('click', '#clear-image', function(e){
    oc_menu.clear_icon();
    e.preventDefault();
})
// Save button for menu-edit-form
$(document).on('click', '.modal-footer .form-save', function(){
	if(oc_menu.validateForm()) {
		oc_menu.saveForm();
		$(this).parents('.modal-dialog').find('.close').first().trigger('click');
		setTimeout(function(){
			oc_menu.saveMenu();
		}, 500);
	}
});
/*
 * OC_MENU front logic
 * @todo: fix bug with remove menu button (some times button apply cant save removed menu group from setting)
 * @todo: maybe previous bug sometimes provoke incorrect setting saving when add new menu to... 
 * @todo: add feature that delete menu_group content on save removed from setting menu
 * @todo: add validation by type for drag and drop elements into child ul 
 * @todo: fix bug with empty CKEDITOR for html content type
 * */
var oc_menu = {
	// Delete menu from setting
	delete_group_uri: '',
	// Open menu tree
	open_list_box_uri: '',
	// Open element add/edit form
	open_form_box_uri: '',
	// get Node information from bd
	get_node_uri: '',
	// Elements data of curent menu group
	branch_data: [],
	// Current group id
	group_id: 0,
	// Changed elemente and new elements
	new_branch_data: [],
	// List of deleted elements
	removed_branch_data: [],
	// Menu types
	menu_types: [],
	// Init :)
	init: function(){
		this.delete_group_uri  = getLink('module/oc_menu/deleteGroup');
		this.open_list_box_uri = getLink('module/oc_menu/getGroupPage');
		this.open_form_box_uri = getLink('module/oc_menu/getFormPage');
		this.get_node_uri = getLink('module/oc_menu/getNodeInfo');
		this.getMenuTypes();
		for(var logic in this.initTypeLogic) {
			this.initTypeLogic[logic]();
		}
	},
	// Get menu types
	getMenuTypes: function(){
		$.ajax({
			url: getLink('module/oc_menu/getMenuTypes'),
			type: 'post',
			dataType: 'json',
			success: function(response){
				oc_menu.menu_types = response;
			}, 
			error: function(e1, e2) {
				console.log(e1);
				console.log(e2);
			}
		});
	},
	// Save module setting
	save_list: function(){
		var data = $('#form-oc_menu').serialize();
		var uri  = $('#form-oc_menu').attr('action');
		$.ajax({
			url: uri,
			type: 'post',
			dataType: 'json',
			data: data,
			success: function(response){
				if(response.status == 'ok') {
					alert('Изменения сохранены');
					oc_menu.show_edit_buttons();
				} else {
					alert('Internal server error');
					console.log('apply status not "ok"!');
				}
			},
			error: function(e1, e2){
				console.log(e1);
				console.log(e2);
			}
		});
	},
	// Delete menu group from setting
	delete_group: function(group_id){
		var data = {
			group_id : group_id	
		};
		$.ajax({
			url: this.delete_group_uri,
			dataType: 'json',
			type: 'post',
			data: data,
			success: function(response){
				console.log(response);
			},
			error: function(e1, e2){
				console.log(e1);
				console.log(e2);
			}
		});
	},
	// Show menu group edit button
	show_edit_buttons: function(){
		$('.actions button.edit').each(function(){
			if($(this).hasClass('hidden')) {
				$(this).show(250).removeClass('hidden');
			}
		});
	},
	// Open menu group tree
	open_list_box: function(group_id){
		var data = {
			group_id : group_id	
		};
		$.ajax({
			url: this.open_list_box_uri,
			dataType: 'json',
			type: 'post',
			data: data,
			success: function(response){
				if(response.status == 'ok') {
					alert(response.content);
					oc_menu.initMoves();
					oc_menu.changeListButtons();
					oc_menu.prepare_branch_data();
					$('[data-toggle=tooltip]').tooltip();
				} else {
					alert('Internal server error');
				}
			},
			error: function(e1, e2){
				console.log(e1);
				console.log(e2);
			}
		});
	},
	// Open add/edit element form
	open_form_box: function(node_id, node_new_id){
		$('.menu-edit-list').parents('.modal-dialog').find('.close').first().trigger('click'); 
		$.ajax({
			url: this.open_form_box_uri,
			type: 'post',
			success: function(response) {
				alert(response);
				node_id = node_id || 0;
				node_new_id = node_new_id || 0;
				$('.menu-edit-form').attr('node-id', node_id);
				$('.menu-edit-form').attr('node-tmp-id', node_new_id);
				/* Reinit some bt features*/
				$('[data-toggle=tooltip]').tooltip();
				$('[data-toggle=buttons]').button('toggle');
				$('[data-toggle=modal]').modal();
				$('.element-status').parents('.btn-success').trigger('click');
				// ---
				oc_menu.changeFormBoxButtons();
				// ---
				if(node_id || node_new_id) {
					oc_menu.fill_form_box(node_id, node_new_id);
				}
				/**
				 * TMP SCRIPT
				 * @todo: need refactoring
				 */
			    // Upload each image on fileinput change, always use iframe
				var $form3 = $('#icon-uploader');
			    // Instantiate Uploader
				
				var uploader3 = new Uploader({
					$form: $form3,
					postUrl: $form3.attr('action'),
				    onErrorCallback: function (result, file, $fileInput) {
				    	$fileInput.after($('<div />)', {
			    			'class': 'file-name is-' + result.status,
		    				'text': file.name + ' could not be uploaded, because: ' + result.responseText
			    		}));
				    },
				    onSuccessCallback: function (result, file, $fileInput) {
				    	if(result.fileName) {
				    		$('#element-icon-value').val(result.fileName);
				    		$('#element-icon').attr('src', result.fileName);
				    		$(document).css('cursor', 'default');
				    	}
				    },
				    uploadFn: 'UploaderWithIframe'
				});
				$('input[type=file]', $form3).on('upload.input.start', function () {
					$('.menu-edit-form').css('cursor', 'wait');
					$(this).closest('.form-control').addClass('is-uploading');
				});
				$('input[type=file]', $form3).on('upload.input.complete', function (evt, result) {
					$('.menu-edit-form').css('cursor', 'default');
					$(this).closest('.form-control').removeClass('is-uploading');
				});
				// doUploadSingleInput on change
				$('input[type="file"]', $form3).on('change', function () {
					var results = uploader3.doUploadSingleInput($(this));
				});
			},
			error: function(e1, e2){
				console.log(e1);
				console.log(e2);
			}
		});
	},
	changeColumnsQuantity: function(quantity){
		var columns_quantity = $('.menu-edit-form .element-columns .element-column-data').length;
		if(columns_quantity > quantity) {
			for(var i = columns_quantity; i > quantity; i--) {
				$('.element-column-data[column-number=' + i + ']').remove();
			}
		} else if(columns_quantity < quantity){
			for(var i = columns_quantity+1; i <= quantity; i++) {
				var $template = $('.menu-edit-form .element-columns .element-column-data').first().clone(true);
				
				$template.attr('column-number', i);
				$template.attr('column-id', 0);
				$template.find('.element-column-width').first().val('');
				$template.find('.element-column-style').first().val('');
				$template.appendTo('.menu-edit-form .element-columns-data');
			}
		}
	},
	fill_form_box: function(node_id, node_new_id){
		// get element data
		var node_info;
		if(node_id) {
			node_info =	this.branch_data[node_id];
		} else if(node_new_id) {
			node_info = this.branch_data[0][node_new_id];
		}
		
		// fill names and descriptions
		for(var i=0;i<node_info.descriptions.length;i++) {
			$('.menu-edit-form #tab-names-' + node_info.descriptions[i].language_id + ' .element-name').val(node_info.descriptions[i].name);
			$('.menu-edit-form #tab-names-' + node_info.descriptions[i].language_id + ' .element-description').val(node_info.descriptions[i].description);
		}
		// fill class
		$('.menu-edit-form .element-class').val(node_info['class']);
		// fill icon
		$('.menu-edit-form .element-icon').val(node_info.icon);
		if(node_info.icon) {
			$('.menu-edit-form #element-icon').attr('src', node_info.icon);
		} else {
			$('.menu-edit-form #element-icon').attr('src', '/image/no_image.jpg');
		}
		// set status
		var status = node_info.status;
		if(status != '1') {
			$('.menu-edit-form .element-status[value=0]').prop('chekced', true);
			$('.menu-edit-form .element-status[value=0]').parent('.btn-danger').addClass('active');
			$('.menu-edit-form .element-status[value=1]').removeAttr('checked');
			$('.menu-edit-form .element-status[value=1]').parent('.btn-success').removeClass('active');
		}
		// set type
		$('.menu-edit-form .element-type option:selected').removeAttr('selected');
		$('.menu-edit-form .element-type option[value=' + node_info.type_id + ']').prop('selected', true);
		$('.menu-edit-form .element-type').trigger('change');
		var type_key = $('.menu-edit-form .element-type option:selected').attr('type-key');
		oc_menu.fillProperties(node_info, type_key);
		// trigger type
		// fill type
		// set columns
		$('.menu-edit-form .element-column-quantity').val(node_info.columns.length);
		$('.menu-edit-form .element-column-quantity').trigger('change');
		if(node_info.columns.length) {
			for(var c=0;c<node_info.columns.length;c++) {
				var width = node_info.columns[c].width;
				var style = node_info.columns[c].style;
				$('.menu-edit-form .element-columns-data .element-column-data[column-number=' + (c+1) + '] .element-column-width').val(width);
				$('.menu-edit-form .element-columns-data .element-column-data[column-number=' + (c+1) + '] .element-column-style').val(style);
			}
		}
		// trigger columns
		// fill columns
	},
	// Fill properties for different element types
	fillProperties: function(node_info, type_key){
		setTimeout(function(){
			oc_menu.fillProperty[type_key](node_info);
		}, 100, type_key, node_info);
	},
	
	fillProperty: {
		category: function(node_info){
			if(node_info.properties) {
				for(var p=0;p<node_info.properties.length;p++){
					if(node_info.properties[p].type_key == 'category' && node_info.properties[p].name == 'category_id') {
						var prop = '<input type="hidden" value="' + node_info.properties[p].value + '" class="type-category-id"><div class="type-category-text">' + node_info.properties[p].value_name + '</div>';
						$('.menu-edit-form .element-type-properties.category .element-type-property .element-type-property-result').html(prop);
					}
				}
			}
		},
		information: function(node_info){
			if(node_info.properties) {
				for(var p=0;p<node_info.properties.length;p++){
					if(node_info.properties[p].type_key == 'information' && node_info.properties[p].name == 'information_id') {
						var prop = '<input type="hidden" value="' + node_info.properties[p].value + '" class="type-information-id"><div class="type-information-text">' + node_info.properties[p].value_name + '</div>';
						$('.menu-edit-form .element-type-properties.information .element-type-property .element-type-property-result').html(prop);
					}
				}
			}
		},
		gallery_link: function(node_info){
			
		},
		blog_category: function(node_info){
			if(node_info.properties) {
				for(var p=0;p<node_info.properties.length;p++){
					if(node_info.properties[p].type_key == 'blog_category' && node_info.properties[p].name == 'blog_category_id') {
						var prop = '<input type="hidden" value="' + node_info.properties[p].value + '" class="type-blog_category-id"><div class="type-blog_category-text">' + node_info.properties[p].value_name + '</div>';
						$('.menu-edit-form .element-type-properties.blog_category .element-type-property .element-type-property-result').html(prop);
					}
				}
			}
		},
		category_list: function(node_info){
			if(node_info.properties) {
				var deep_level = 0;
				var category_id = 0;
				var category_name = '';
				for(var p=0;p<node_info.properties.length;p++){
					if(node_info.properties[p].type_key == 'category_list' && node_info.properties[p].name == 'root_category_id') {
						category_id = node_info.properties[p].value;
						category_name = node_info.properties[p].value_name;
					}
					if(node_info.properties[p].type_key == 'category_list' && node_info.properties[p].name == 'deep_level') {
						deep_level = node_info.properties[p].value;
					}
				}
				$('.menu-edit-form .element-type-properties.category_list .type-category_list-text').first().text(category_name);
				$('.menu-edit-form .element-type-properties.category_list input.type-category_list-id').val(category_id);
				$('.menu-edit-form .element-type-properties.category_list .element-type-property-value').last().val(deep_level);
			}
		},
		manufacturer_link: function(node_info){
			
		},
		gallery: function(node_info){
			if(node_info.properties) {
				for(var p=0;p<node_info.properties.length;p++){
					if(node_info.properties[p].type_key == 'gallery' && node_info.properties[p].name == 'gallery_id') {
						var prop = '<input type="hidden" value="' + node_info.properties[p].value + '" class="type-gallery-id"><div class="type-gallery-text">' + node_info.properties[p].value_name + '</div>';
						$('.menu-edit-form .element-type-properties.gallery .element-type-property .element-type-property-result').html(prop);
					}
				}
			}
		},
		custom_link: function(node_info){
			if(node_info.properties) {
				for(var p=0;p<node_info.properties.length;p++){
					if(node_info.properties[p].type_key == 'custom_link' && node_info.properties[p].name == 'uri') {
						$('.menu-edit-form .element-type-properties.custom_link .element-type-property-value').val(node_info.properties[p].value);
					}
				}
			}
		},
		html: function(node_info){
			if(node_info.properties) {
				for(var p=0;p<node_info.properties.length;p++){
					if(node_info.properties[p].type_key == 'html' && node_info.properties[p].name == 'html') {
						$('.menu-edit-form .element-type-properties.html #type-html-content').val(node_info.properties[p].value);
					}
				}
			}
		},
		products_list: function(node_info){
			if(node_info.properties) {
				for(var p=0;p<node_info.properties.length;p++){
					if(node_info.properties[p].type_key == 'products_list' && node_info.properties[p].name == 'products_list') {
						var products = node_info.properties[p].value.split(',');
						for(var i=0;i<products.length;i++) {
							if(node_info.properties[p].value_name[i]) {
								var product_name = node_info.properties[p].value_name[i];
								var product_id   = products[i];
								var item_element = '<span class="products_list-element" product-id="' + product_id + '">' + product_name + '<i class="fa fa-times"></i></span>';

								var new_value = [];
								var current_value = $('.menu-edit-form .element-type-properties.products_list input.type-products_list-products').val();
								var new_values = current_value.split(',');
								$(new_values).each(function(){
									if((parseInt(this) > 0) && (new_value.indexOf(this + '') < 0)) {
										new_value.push(this + '');
									}
								});
								
								if(parseInt(product_id) > 0 && new_value.indexOf(product_id + '') < 0) {
									new_value.push(product_id + '');
									var value_string = new_value.join(',');
									$('.menu-edit-form .element-type-properties.products_list .type-products_list-text').append(item_element);
									$('.menu-edit-form .element-type-properties.products_list input.type-products_list-products').val(value_string);	
								}
							}
						}
					}
				}
			}
		}
	},
	// Collect data about elements that exists in current menu group
	prepare_branch_data: function(){
		
		this.group_id = $('.modal-content .menu-edit-list').attr('group-id');
		
		$('.menu-edit-list .node').each(function(){
			var node_id = parseInt($(this).attr('node-id'));
			node_id = node_id || 0;
			if(node_id) {
				oc_menu.prepare_node_data(node_id, false);
			}
		});
	},
	prepare_node_data: function(node_id) {
		var data = {
			node_id: node_id
		};
		$.ajax({
			url: this.get_node_uri,
			type: 'post',
			data: data,
			dataType: 'json',
			success: function(response) {
				if(response.menu_id != 'undefined' && response.menu_id != false) {
					oc_menu.branch_data[response.menu_id] = response;
				} else {
					alert('Cant get node info, please contact system administrator!');
				}
			},
			error: function(e1, e2){
				console.log(e1);
				console.log(e2);
			}
		});
	},
	// Add draggable/droppable/sortable for menu group tree
	initMoves: function(refresh){
		refresh = refresh || 0;
		
		var sort_options = {
			connectWith: ".menu-edit-list .inner-wrapper ul",
			items: ".node",
			revert: true,
		    placeholder: "hovered",
		    update: function(event, ui){
		    	var node = ui.item;
		    	
		    	/* Update parent id */
		    	var parent_id = parseInt($(node).parents('.node').attr('node-id'));
		    	parent_id = parent_id || 0;
		    	// ID of parent element that not already saved to db
		    	var parent_tmp_id = parseInt($(node).parents('.node').attr('node-tmp-id'));
		    	parent_tmp_id = parent_tmp_id || 0;
		    	
		    	var node_id = parseInt($(node).attr('node-id'));
		    	if(!node_id || node_id == 0) {
		    		var node_tmp_id = parseInt($(node).attr('node-tmp-id'));
		    		oc_menu.branch_data[0][node_tmp_id].parent_id = parent_id;
		    		oc_menu.branch_data[0][node_tmp_id].parent_tmp_id = parent_tmp_id;
		    	} else {
		    		oc_menu.branch_data[node_id].parent_id = parent_id;
		    		oc_menu.branch_data[node_id].parent_tmp_id = parent_tmp_id;
		    	}
		    	
		    	oc_menu.updateSortOrder();
		    }
		};
		if(refresh) {
			$('.menu-edit-list .inner-wrapper ul').sortable('destroy');
			$('.menu-edit-list .inner-wrapper ul').unbind();	
		}
		$('.menu-edit-list .inner-wrapper ul').sortable(sort_options);
	},
	updateSortOrder: function() {
		$('.node').each(function(){
			var node_id 	= parseInt($(this).attr('node-id'));
			var node_tmp_id = parseInt($(this).attr('node-tmp-id'));
			var sort_order  = parseInt($(this).index()) + 1;
			sort_order = sort_order || 1;
			node_id = node_id || 0;
			node_tmp_id = node_tmp_id || 0;
			if(!node_id || node_id == 0) {
				oc_menu.branch_data[0][node_tmp_id].sort_order = sort_order;
			} else {
				oc_menu.branch_data[node_id].sort_order = sort_order;
			}
		});
	},
	// Replace default alert buttons and insert custom to list
	changeListButtons: function(){
		var modal = $('.menu-edit-list').parents('.modal-content');
		modal.children('.modal-footer').children('button').remove();
		modal.children('.modal-footer').append('<span class="btn btn-primary list-add">Добавить</span>');
		modal.children('.modal-footer').append('<span class="btn btn-success list-save">Сохранить</span>');
//		modal.children('.modal-footer').append('<span class="btn btn-danger list-discard">Отмена</span>');
	},
	// Replace default alert buttons and insert custom to form
	changeFormBoxButtons: function() {
		var modal = $('.menu-edit-form').parents('.modal-content');
		modal.children('.modal-footer').children('button').remove();
		modal.children('.modal-footer').append('<span class="btn btn-success form-save">Сохранить</span>');
//		modal.children('.modal-footer').append('<span class="btn btn-danger form-discard">Отмена</span>');
	},
	// Modify type properties content when type is changed
	applySelectedType: {
		category: function(){
			oc_menu.resetTypePropertiesContent();
			var html = '<input type="hidden" value="" class="type-category-id"><div class="type-category-text"></div>';
			$('.element-type-properties.category .element-type-property-result').html(html);
		},
		information: function(){
			oc_menu.resetTypePropertiesContent();
			var html = '<input type="hidden" value="" class="type-information-id"><div class="type-information-text"></div>';
			$('.element-type-properties.information .element-type-property-result').html(html);
		},
		gallery_link: function(){
			oc_menu.resetTypePropertiesContent();
		},
		blog_category: function(){
			oc_menu.resetTypePropertiesContent();
			var html = '<input type="hidden" value="" class="type-blog_category-id"><div class="type-blog_category-text"></div>';
			$('.element-type-properties.blog_category .element-type-property-result').html(html);
		},
		category_list: function(){
			oc_menu.resetTypePropertiesContent();
			var html = '<input type="hidden" value="" class="type-category_list-id"><div class="type-category_list-text"></div>';
			$('.element-type-properties.category_list .element-type-property-result').first().html(html);
		},
		manufacturer_link: function(){
			oc_menu.resetTypePropertiesContent();
			
		},
		gallery: function(){
			oc_menu.resetTypePropertiesContent();
			oc_menu.resetTypePropertiesContent();
			var html = '<input type="hidden" value="" class="type-gallery-id"><div class="type-gallery-text"></div>';
			$('.element-type-properties.gallery .element-type-property-result').html(html);
		},
		custom_link: function(){
			oc_menu.resetTypePropertiesContent();
			
		},
		html: function(){
			oc_menu.resetTypePropertiesContent();
			var html = '<textarea value="" id="type-html-content" name="type-html-content" class="type-html-content"></textarea>';
			
			$('.element-type-properties.html').html(html);
			CKEDITOR.replace('type-html-content', {
				filebrowserBrowseUrl: getLink('common/filemanager'),
				filebrowserImageBrowseUrl: getLink('common/filemanager'),
				filebrowserFlashBrowseUrl: getLink('common/filemanager'),
				filebrowserUploadUrl: getLink('common/filemanager'),
				filebrowserImageUploadUrl: getLink('common/filemanager'),
				filebrowserFlashUploadUrl: getLink('common/filemanager'),
				toolbar: [
				{ name: 'document', groups: [ 'mode', ], items: [ 'Source', 'ShowBlocks' ] },
				{ name: 'clipboard', groups: [ 'undo' ], items: [ 'Undo', 'Redo' ] },
				'/',
				{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat' ] },
				{ name: 'paragraph', groups: [ 'list', 'align' ], items: [ 'NumberedList', 'BulletedList',  '-', 'Blockquote', 'CreateDiv', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ] },
				{ name: 'links', items: [ 'Link' ] },
				'/',
				{ name: 'styles', items: [ 'Styles', 'Format', 'Font', 'FontSize' ] },
				{ name: 'colors', items: [ 'TextColor', 'BGColor' ] }
			]
			});
		},
		products_list: function(){
			oc_menu.resetTypePropertiesContent();
			var html = '<input type="hidden" value="" class="type-products_list-products"><div class="type-products_list-text"></div>';
			$('.element-type-properties.products_list .element-type-property-result').html(html);
		}
	},
	resetTypePropertiesContent: function(){
		$('.menu-edit-form .element-type-property-value').val('');
		$('.menu-edit-form .element-type-property-result').html('');
	},
	// Logic of type properies
	initTypeLogic: {
		category: function(){
			$(document).on('focus', '.menu-edit-form .element-type-properties.category input.element-type-property-value', function(){
				$('.menu-edit-form .element-type-properties.category input.element-type-property-value').autocomplete({
					'source': function(request, response) {
						$.ajax({
							url: getLink('module/oc_menu/autocomplete'),
							dataType: 'json',
							type: 'post',
							data: {
								name: encodeURIComponent(request),
								type: 'category'
							},
							success: function(json) {
								response($.map(json, function(item) {
									return {
										label: item['name'],
										value: item['category_id']
									}
								}));
							}
						});
					},
					'select': function(item) {
						$('.menu-edit-form .element-type-properties.category .type-category-text').html(item['label']);
						$('.menu-edit-form .element-type-properties.category input.type-category-id').val(item['value']);
					}
				});
			});
		},
		information: function(){
			$(document).on('focus', '.menu-edit-form .element-type-properties.information input.element-type-property-value', function(){
				$('.menu-edit-form .element-type-properties.information input.element-type-property-value').autocomplete({
					'source': function(request, response) {
						$.ajax({
							url: getLink('module/oc_menu/autocomplete'),
							dataType: 'json',
							type: 'post',
							data: {
								name: encodeURIComponent(request),
								type: 'information'
							},
							success: function(json) {
								
								response($.map(json, function(item) {
									return {
										label: item['name'],
										value: item['information_id']
									}
								}));
							}
						});
					},
					'select': function(item) {
						$('.menu-edit-form .element-type-properties.information .type-information-text').html(item['label']);
						$('.menu-edit-form .element-type-properties.information input.type-information-id').val(item['value']);
					}
				});
			});
		},
		gallery_link: function(){
			
		},
		blog_category: function(){
			$(document).on('focus', '.menu-edit-form .element-type-properties.blog_category input.element-type-property-value', function(){
				$('.menu-edit-form .element-type-properties.blog_category input.element-type-property-value').autocomplete({
					'source': function(request, response) {
						$.ajax({
							url: getLink('module/oc_menu/autocomplete'),
							dataType: 'json',
							type: 'post',
							data: {
								name: encodeURIComponent(request),
								type: 'blog_category'
							},
							success: function(json) {
								
								response($.map(json, function(item) {
									return {
										label: item['name'],
										value: item['blog_category_id']
									}
								}));
							}
						});
					},
					'select': function(item) {
						$('.menu-edit-form .element-type-properties.blog_category .type-blog_category-text').html(item['label']);
						$('.menu-edit-form .element-type-properties.blog_category input.type-blog_category-id').val(item['value']);
					}
				});
			});
		},
		category_list: function(){
			$(document).on('focus', '.menu-edit-form .element-type-properties.category_list input.element-type-property-value', function(){
				$('.menu-edit-form .element-type-properties.category_list input.element-type-property-value').first().autocomplete({
					'source': function(request, response) {
						$.ajax({
							url: getLink('module/oc_menu/autocomplete'),
							dataType: 'json',
							type: 'post',
							data: {
								name: encodeURIComponent(request),
								type: 'category_list'
							},
							success: function(json) {
								response($.map(json, function(item) {
									return {
										label: item['name'],
										value: item['category_id']
									}
								}));
							}
						});
					},
					'select': function(item) {
						$('.menu-edit-form .element-type-properties.category_list .type-category_list-text').first().html(item['label']);
						$('.menu-edit-form .element-type-properties.category_list input.type-category_list-id').val(item['value']);
					}
				});
			});
		},
		manufacturer_link: function(){
			
		},
		gallery: function(){
			$(document).on('focus', '.menu-edit-form .element-type-properties.gallery input.element-type-property-value', function(){
				$('.menu-edit-form .element-type-properties.gallery input.element-type-property-value').autocomplete({
					'source': function(request, response) {
						$.ajax({
							url: getLink('module/oc_menu/autocomplete'),
							dataType: 'json',
							type: 'post',
							data: {
								name: encodeURIComponent(request),
								type: 'gallery'
							},
							success: function(json) {
								
								response($.map(json, function(item) {
									return {
										label: item['name'],
										value: item['gallery_category_id']
									}
								}));
							}
						});
					},
					'select': function(item) {
						$('.menu-edit-form .element-type-properties.gallery .type-gallery-text').html(item['label']);
						$('.menu-edit-form .element-type-properties.gallery input.type-gallery-id').val(item['value']);
					}
				});
			});
		},
		custom_link: function(){
			
		},
		html: function(){
			
		},
		products_list: function(){
			$(document).on('focus', '.menu-edit-form .element-type-properties.products_list input.element-type-property-value', function(){
				$('.menu-edit-form .element-type-properties.products_list input.element-type-property-value').autocomplete({
					'source': function(request, response) {
						$.ajax({
							url: getLink('module/oc_menu/autocomplete'),
							dataType: 'json',
							type: 'post',
							data: {
								name: encodeURIComponent(request),
								type: 'products_list'
							},
							success: function(json) {
								response($.map(json, function(item) {
									return {
										label: item['name'],
										value: item['product_id']
									}
								}));
							}
						});
					},
					'select': function(item) {
						var new_value = [];
						var current_value = $('.menu-edit-form .element-type-properties.products_list input.type-products_list-products').val();
						var new_values = current_value.split(',');
						$(new_values).each(function(){
							if((parseInt(this) > 0) && (new_value.indexOf(this + '') < 0)) {
								new_value.push(this + '');
							}
						});
						
						if(new_value.indexOf(item['value'] + '') < 0) {
							new_value.push(item['value'] + '');
							var value_string = new_value.join(',');
							var item_element = '<span class="products_list-element" product-id="' + item['value'] + '">' + item['label'] + '<i class="fa fa-times"></i></span>';
							$('.menu-edit-form .element-type-properties.products_list .type-products_list-text').append(item_element);
							$('.menu-edit-form .element-type-properties.products_list input.type-products_list-products').val(value_string);	
						}
					}
				});
			});
			$(document).on('click', '.products_list-element i.fa-times', function(){
				var product_id = $(this).parents('.products_list-element').attr('product-id');
				$(this).parents('.products_list-element').remove();
				
				var new_value = [];
				var current_value = $('.menu-edit-form .element-type-properties.products_list input.type-products_list-products').val();
				var new_values = current_value.split(',');
				$(new_values).each(function(){
					if((parseInt(this) > 0) && (new_value.indexOf(this + '') < 0) && (parseInt(this) != parseInt(product_id))) {
						new_value.push(this + '');
					}
				});
				var value_string = new_value.join(',');
				$('.menu-edit-form .element-type-properties.products_list input.type-products_list-products').val(value_string);
			});
		}
	},
	saveForm: function(){
		var content = {};
		// Get descriptions
		var descriptions = [];
		$('.menu-edit-form .element-descriptions').each(function(){
			var language_id = $(this).attr('language-id');
			var name = $(this).find('.element-name').first().val();
			var description = $(this).find('.element-description').first().val();
			descriptions.push({
				name: name,
				description: description,
				language_id: language_id
			});
		});
		content.descriptions = descriptions;
		// Get class
		content['class'] = $('.menu-edit-form .element-class').val();
		// Get icon
		content['icon'] = $('.menu-edit-form .element-icon').val();
		// Get type
		content['type_id'] = parseInt($('.menu-edit-form select.element-type option:selected').val());
		content.columns = [];
		// Get columns
		$('.menu-edit-form .element-column-data').each(function(){
			var width = $(this).find('.element-column-width').first().val();
			var style = $(this).find('.element-column-style').first().val();
			content.columns.push({
				width: width,
			    style: style
			});
		});
		// Get properties
		content.properties = [];
		var type_key = $('.menu-edit-form select.element-type option:selected').attr('type-key');
		content.type_key = type_key;
		
		$('.menu-edit-form .element-type-properties.' + type_key).each(function(){
			
			var property_name = '';
			var property_value = '';
			switch(type_key) {
				case 'category':
					property_name  = $(this).find('.element-type-property').first().attr('prop-name');
					property_value = $(this).find('.type-category-id').first().val();
					content.properties.push({
						name: property_name,
						type_key: type_key,
						type_id: content['type_id'],
						value: property_value
					});
					break;
				case 'information':
					property_name  = $(this).find('.element-type-property').first().attr('prop-name');
					property_value = $(this).find('.type-information-id').first().val();
					content.properties.push({
						name: property_name,
						type_key: type_key,
						type_id: content['type_id'],
						value: property_value
					});
					break;
				case 'gallery_link':
					
					break;
				case 'blog_category':
					property_name  = $(this).find('.element-type-property').first().attr('prop-name');
					property_value = $(this).find('.type-blog_category-id').first().val();
					content.properties.push({
						name: property_name,
						type_key: type_key,
						type_id: content['type_id'],
						value: property_value
					});
					break;
				case 'category_list':
					property_name  = 'root_category_id';
					property_value = $(this).find('.element-type-property[prop-name=root_category_id] .type-category_list-id').first().val();
					content.properties.push({
						name: property_name,
						type_key: type_key,
						type_id: content['type_id'],
						value: property_value
					});
					property_name  = 'deep_level';
					property_value = $(this).find('.element-type-property[prop-name=deep_level] .element-type-property-value').first().val();
					content.properties.push({
						name: property_name,
						type_key: type_key,
						type_id: content['type_id'],
						value: property_value
					});
					break;
				case 'manufacturer_link':
					
					break;
				case 'gallery':
					property_name  = $(this).find('.element-type-property').first().attr('prop-name');
					property_value = $(this).find('.type-gallery-id').first().val();
					content.properties.push({
						name: property_name,
						type_key: type_key,
						type_id: content['type_id'],
						value: property_value
					});
					break;
				case 'custom_link':
					property_name  = $(this).find('.element-type-property').first().attr('prop-name');
					property_value = $(this).find('.element-type-property-value').first().val();
					content.properties.push({
						name: property_name,
						type_key: type_key,
						type_id: content['type_id'],
						value: property_value
					});
					break;
				case 'html':
					property_name  = $(this).find('.element-type-property').first().attr('prop-name');
					property_value = CKEDITOR.instances['type-html-content'].getData();
					content.properties.push({
						name: 'html',
						type_key: 'html',
						type_id: content['type_id'],
						value: property_value
					});
					break;
				case 'products_list':
					property_name  = $(this).find('.element-type-property').first().attr('prop-name');
					property_value = $(this).find('.type-products_list-products').first().val();
					content.properties.push({
						name: property_name,
						type_key: type_key,
						type_id: content['type_id'],
						value: property_value
					});
					break;
				default:
					break;
			}
		});
		// status
		if($('.menu-edit-form input[name=element_status]:checked').val()) {
			content.status = $('.menu-edit-form input[name=element_status]:checked').val();
		} else {
			content.status = '0';
		}
		var node_id     = parseInt($('.menu-edit-form').attr('node-id'));
		var node_tmp_id = parseInt($('.menu-edit-form').attr('node-tmp-id'));
		var new_element = false;
		
		node_id     = node_id     || 0;
		node_tmp_id = node_tmp_id || 0;
		
		
		if(!node_id && !node_tmp_id) {
			new_element = true;
		}
		
		node_tmp_id = this.applyBranchData(node_id, node_tmp_id, content, new_element);
		
		this.applyNewList(node_id, node_tmp_id, content, new_element);
	},
	applyBranchData: function(node_id, node_tmp_id, content, new_element){
		var new_content = {
			'class': '',
			'columns': [],
			'descriptions': [],
			'group_id': '',
			'icon': '',
			'menu_id': '',
			'parent_id': '',
			'properties': [],
			'sort_order': '',
			'status': '',
			'type_id': '',
		};
		
		node_id     = node_id     || 0;
		node_tmp_id = node_tmp_id || 0;
		
		new_content['class'] = content['class'];
		// Columns
		for(var c=0;c<content.columns.length;c++) {
			new_content.columns.push({
				column_id: c+1,
				menu_id: node_id,
				style: content.columns[c].style,
				width: content.columns[c].width
			});
		}
		// Descriptions
		for(var d=0;d<content.descriptions.length;d++) {
			new_content.descriptions.push({
				description: content.descriptions[d].description,
				language_id: content.descriptions[d].language_id,
				name: content.descriptions[d].name,
				menu_id: node_id
			});
		}
		new_content.group_id = this.group_id;
		new_content.icon = content.icon;
		if(node_id) {
			new_content.menu_id = node_id;
		} else  {
			new_content.menu_id = 0;
		}
		new_content.type_id = content.type_id;
		new_content.status  = content.status;
		
		if(node_id) {
			new_content.parent_id  = this.branch_data[node_id].parent_id;
			new_content.sort_order = this.branch_data[node_id].sort_order;
		} else  if(node_tmp_id){
			new_content.parent_id  = this.branch_data[0][node_tmp_id].parent_id;
			new_content.sort_order = this.branch_data[0][node_tmp_id].sort_order;
		} else if(new_element){
			new_content.parent_id  = 0;
			new_content.sort_order = 0;
		}
		
		// Properties
		for(var p=0;p<content.properties.length;p++) {
			new_content.properties.push({
				name: content.properties[p].name,
				type_id: content.properties[p].type_id,
				value: content.properties[p].value,
				type_key: content.properties[p].type_key,
				value_name: oc_menu.getValueName(content.properties[p].type_key, content.properties[p].value),
				property_id: oc_menu.getPropertyId(content.properties[p].type_key, content.properties[p].name),
				menu_id: (node_id?node_id:0)
			});
		}
		
		new_content.type_key = content.type_key;
		
		// Apply changes to branch
		if(node_id) {
			new_content.node_id = node_id;
			new_content.node_tmp_id = node_tmp_id;
			oc_menu.branch_data[node_id] = new_content;
		} else if(node_tmp_id) {
			new_content.node_id = node_id;
			new_content.node_tmp_id = node_tmp_id;
			oc_menu.branch_data[0][node_tmp_id] = new_content;
		} else {
			if(typeof oc_menu.branch_data[0] != 'undefined') {
				node_tmp_id = oc_menu.branch_data[0].length;
				new_content.node_id = node_id;
				new_content.node_tmp_id = node_tmp_id;
				oc_menu.branch_data[0][node_tmp_id] = new_content;
			} else {
				node_tmp_id = 1;
				new_content.node_id = node_id;
				new_content.node_tmp_id = node_tmp_id;
				oc_menu.branch_data[0] = [];
				oc_menu.branch_data[0][1] = new_content;
				
			}
		}
		
		// DANGER!!! it can be usabled only for new elements
		return node_tmp_id;
	},
	// Get value name from server
	getValueName: function(type_key, value) {
		var property_value_name = '';
		$.ajax({
			url: getLink('module/oc_menu/getValueName'),
			type: 'post',
			dataType: 'json',
			data: {
				type:  type_key,
				value: value
			},
			async: false,
			success: function(response){
				property_value_name = response.name;
			},
			error: function(e1, e2){
				console.log(e1);
				console.log(e2);
			}
		});
		
		return property_value_name;
	},
	// Get property id from server
	getPropertyId: function(type_key, property_name) {
		var type_property_id = 0;
		$.ajax({
			url: getLink('module/oc_menu/getTypePropertyId'),
			type: 'post',
			dataType: 'json',
			data: {
				type: type_key,
				prop: property_name
			},
			async: false,
			success: function(response){
				type_property_id = response.id;
			},
			error: function(e1, e2){
				console.log(e1);
				console.log(e2);
			}
		});
		
		return type_property_id; 
	},
	// Apply changes of saved form to menu-list
	applyNewList: function(node_id, node_tmp_id, content, new_element) {
		/*
		 * @todo: Must be implement in feature (select id of descriptions array thar equal to selected language)
		 * var language_id      = $('input[name=config_language_id]').val();
		 * var language_index   = loop...in description
		 * */
		node_id     = node_id     || 0;
		node_tmp_id = node_tmp_id || 0;
		
		var node_type_icon   = '';
		var node_type_id     = content.type_id;
		var node_type_title  = '';
		var node_title       = '';
		var node_name        = '';
		var node_type        = {};
		for (var i=0;i<this.menu_types.length;i++) {
			if(this.menu_types[i].type_id == node_type_id) {
				node_type = this.menu_types[i];
			}
		}
		
		node_type_icon  = node_type.icon;
		node_type_title = node_type.name;
		node_title = content.descriptions[0].description;
		node_name  = content.descriptions[0].name;
		
		if(new_element && node_tmp_id) {
			var node_level   = 1;
			// Create new element of ment (may be edited after template changes)
			var new_element_content = '<li class="node level-1" node-id="0" node-tmp-id="' + node_tmp_id + '" node-type="' + node_type_id + '"><div class="node-info"><span class="type ' + node_type_icon + '" title="" data-toggle="tooltip" data-original-title="' + node_type_icon + '"></span><span class="name" title="' + node_title + '" data-toggle="tooltip">' + node_name + '</span><div class="actions pull-right"><div class="edit fa fa-edit" node-id="0" node-tmp-id="' + node_tmp_id + '"></div><div class="delete fa fa-times" node-id="0" node-tmp-id="' + node_tmp_id + '"></div></div></div><ul class="node-container"></ul></li>';
			$('.menu-edit-list').find('.node-container').first().append(new_element_content);
		} else {
			if(node_id) {
				$('li.node[node-id=' + node_id + ']').attr('node-type', node_type_id);
				$('li.node[node-id=' + node_id + ']').find('span.type').first()
					.attr('node-type', node_type_id)
					.removeAttr('class')
					.addClass('type')
					.addClass(node_type_icon)
					.attr('title', node_type_title);
				$('li.node[node-id=' + node_id + ']').find('span.name').first()
					.attr('title', node_title).text(node_name);
			} else if(node_tmp_id) {
				$('li.node[node-tmp-id=' + node_tmp_id + ']').attr('node-type', node_type_id);
				$('li.node[node-tmp-id=' + node_tmp_id + ']').find('span.type').first()
					.attr('node-type', node_type_id)
					.removeAttr('class')
					.addClass('type')
					.addClass(node_type_icon)
					.attr('title', node_type_title);
				$('li.node[node-tmp-id=' + node_tmp_id + ']').find('span.name').first()
					.attr('title', node_title).text(node_name);
			}
		}
		$('[data-toggle=tooltip]').tooltip();
		this.initMoves(true);
	},
	saveMenu: function(){
		$('.menu-edit-list').parents('.modal-dialog').find('.close').first().trigger('click');
		console.log(this.branch_data);
		
		var numCategoryes  = 0;
		for ( var indx in this.branch_data ) {
		  if ( ! isNaN(indx) ) {
			  numCategoryes ++; // count not empty branch_data
		  }
		}

		var i = 1;
		var i_last = 1;
		var partLength = 2;
		var branch_data_part = {};

		for (var part in this.branch_data ) {
			branch_data_part[part] = this.branch_data[part];
			
			if (numCategoryes < partLength) {
				saveMenuCategory(this.branch_data);
				break;
			} else if (	i == partLength ) {
				saveMenuCategory(branch_data_part);
				i = 0;
				branch_data_part = {};
			} else if (numCategoryes%partLength != 0 && i_last == numCategoryes) {
				saveMenuCategory(branch_data_part);
				branch_data_part = {};
			}
			i++;
			i_last++;
		}
			
		function saveMenuCategory(data_part){
			console.log(data_part);
			$.ajax({
				url: getLink('module/oc_menu/saveMenuList'),
				data: {
					branch: data_part
				},
				dataType: 'json',
				type: 'post',
				async: false,
				success: function(){
					//oc_menu.branch_data = [];
					//oc_menu.open_list_box(oc_menu.group_id);
				},
				error: function(e1, e2){
					console.log(e1);
					console.log(e2);
				}
			});

		};	
		
		oc_menu.branch_data = [];
		oc_menu.open_list_box(oc_menu.group_id);
	},
	validateForm: function(){
		var errors = [];
		var type_key = $('.menu-edit-form .element-type option:selected').attr('type-key');
		switch(type_key) {
			case 'category':
				if(!parseInt($('.menu-edit-form .type-category-id').val())) {
					errors.push('Выберите категорию');
				} 
				break;
			case 'information':
				if(!parseInt($('.menu-edit-form .type-information-id').val())) {
					errors.push('Выберите статью');
				} 
				break;
			case 'gallery':
				if(!parseInt($('.menu-edit-form .type-gallery-id').val())) {
					errors.push('Выберите альбом галлереи');
				} 
				break;
			case 'blog_category':
				if(!parseInt($('.menu-edit-form .type-blog_category-id').val())) {
					errors.push('Выберите категориб блога');
				} 
				break;
			case 'category_list':
				if(!parseInt($('.menu-edit-form .type-category_list-id').val())) {
					errors.push('Выберите категорию');
				}
				break;
			case 'manufacturer_link':
				$('.menu-edit-form .element-descriptions .element-name').each(function(){
					if($(this).val().trim().length < 1) {
						var language_name = $(this).attr('language-name');
						errors.push('Заполните имя элемента (' + language_name + ')');
					}
				});
				break;
			case 'gallery_link':
				$('.menu-edit-form .element-descriptions .element-name').each(function(){
					if($(this).val().trim().length < 1) {
						var language_name = $(this).attr('language-name');
						errors.push('Заполните имя элемента (' + language_name + ')');
					}
				});				
				break;
			case 'custom_link':
				$('.menu-edit-form .element-descriptions .element-name').each(function(){
					if($(this).val().trim().length < 1) {
						var language_name = $(this).attr('language-name');
						errors.push('Заполните имя элемента (' + language_name + ')');
					}
				});
				break;
			case 'html':
				
				break;
			case 'products_list':
				if(!parseInt($('.menu-edit-form .type-products_list-products').val())) {
					errors.push('Выберите минимум 1 продукт');
				}
				break;
			default:
				break;
		}
		if(errors.length > 0) {
			$(errors).each(function(){
				oc_menu.showMessage(this, 'error');
			});
			
			return false;
		} else {
			return true; 
		}
	},
	showMessage: function(text, message_type){
		    var opts = {
	    		title: 'Проверьте форму',
	    		text: text,
		        styling: 'bootstrap3',
	        	addclass: 'oc_noty',
	        	icon: 'picon picon-32 picon-fill-color',
	        	opacity: .8,
	        	nonblock: {
	        		nonblock: true
	        	}
		    };
		    switch (message_type) {
			    case 'error':
			        opts.type = 'error';
			        break;
			    case 'info':
			        opts.type = 'info';
			        break;
			    case 'success':
			        opts.type = 'success';
			        break;
		    }
		    new PNotify(opts);
	},
	upload_icon: function(field_id, thumb_id){
		
	},
    clear_icon: function(){
        $('#element-icon-value').val('');
        $('#element-icon').attr('src', '/image/no_image.jpg');
    }
};