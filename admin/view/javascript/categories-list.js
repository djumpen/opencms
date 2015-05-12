/**
 * Response for category list page
 * make xhr request to get children categories and append it to parent
 * maybe used in feature to add some features
 *  
 */
var CategoryFetcher = {
	url: '',
	token: '',
	categoeies: [],
	parent_id: 0,
	template: '',
	$clicked: '',
	start_callback: '',
	finish_callback: '',
	lock: false,
	init: function(){
		this.token = $('#current_token').val();
		this.url = '/admin/index.php?route=catalog/category/getCategoriesList&token=' + this.token;
	},
	setOnStartCallback: function(callback){
		this.start_callback = callback;
	},
	setOnFinishCallback: function(callback){
		this.finish_callback = callback;
	},
	getCategories: function($clicked){
		if(this.lock) return;
		this.$clicked = $clicked;
		this.parent_id = this.$clicked.parent('tr').children('.category_checkbox').children('input').val();
		var data = {
			parent_id: this.parent_id
		};
		if(this.$clicked.parent('tr').children('.category_name').hasClass('loaded')) {
			if(this.$clicked.parent('tr').children('.category_name').hasClass('opened')) {
				this.hideChilds();
			} else {
				this.displayChilds();
			}
		} else {
			$.ajax({
				url: this.url,
				start_callback: this.start_callback,
				finish_callback: this.finish_callback,
				data: data,
				dataType: 'json',
				type: 'post',
				beforeSend: function(){
					//show preloader
					if(this.start_callback.toString().length > 0){
						eval(this.start_callback.toString() + "();");
					}
					CategoryFetcher.lock = true;
				},
				success: function(response){
					if(response) {
						CategoryFetcher.categories = response;
						CategoryFetcher.appendCategories(response);
					}
				}, 
				complete: function(){
					//remove preloader
					if(this.finish_callback.toString().length > 0){
						eval(this.finish_callback.toString() + "();");
					}
					CategoryFetcher.lock = false;
				},
				error: function(e1, e2){
					console.log(e1);
					console.log(e2);
				}
		    });
		}
	},
	appendCategories: function(categories){
		this.$clicked.addClass('opened');
		this.$clicked.addClass('loaded');
		this.template = this.$clicked.parent('tr');
		$(categories).each(function(){
			var template = CategoryFetcher.template.clone(true);
			template.children('.category_checkbox').children('input').val(this.category_id);
			template.children('.category_name').children('span').text(this.name);
			template.children('.category_sortorder').text(this.sort_order);
			template.children('.category_actions').children('a').attr('href', this.href.replace('&amp;', '&').replace('&amp;', '&'));
			template.children('.category_name').removeClass('opened');
			if(this.hasChilds) {
				template.children('.category_name').addClass('hasChilds');
			} else {
				template.children('.category_name').removeClass('hasChilds');
			}
			template.children('.category_name').removeClass('loaded');
			template.children('.category_name').removeClass('opened');
			// @todo: make level remove dyn
			template.children('.category_name').removeClass('level-1');
			template.children('.category_name').removeClass('level-2');
			template.children('.category_name').removeClass('level-3');
			template.children('.category_name').removeClass('level-4');
			template.children('.category_name').addClass('level-' + this.level);
			var levels = '';
			var classes = '';
			classes = CategoryFetcher.template.attr('class');
			if(classes) {
				classes = classes.split(' ');
				$(classes).each(function(){
					if(this.indexOf("live-") > -1) {
						levels += ' ' + this + ' ';
					}
				});
			}
			CategoryFetcher.template.after('<tr class="live-' + CategoryFetcher.parent_id + ' ' + levels + '">' + template.html() + '</tr>');
		});
	},
	displayChilds: function(){
		console.log('in show');
		$('tr.live-' + this.parent_id).show();
		this.$clicked.parent('tr').children('.category_name').addClass('opened');
	},
	hideChilds: function(){
		console.log('in hide');
		$('tr.live-' + this.parent_id).hide();
		this.$clicked.parent('tr').children('.category_name').removeClass('opened');
	}
};