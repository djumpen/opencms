var LivePCe = {
    token: '',
    addCategory: function($clicked){
        this.token = this.getQParam('token');
        var product_id = $clicked.parent('div').parent('td').attr('product-id');
        this.genAddCategoryForm(product_id);
    },
    genAddCategoryForm: function(product_id){
        $categories = $('#filter_by_category').clone(true)
        $categories.attr('id', 'add-category-alert');
        $categories.children('option').each(function(){
            if($(this).text() == '---') {
                $(this).remove();
            } else {
                $(this).removeAttr('selected');
            }
        });
        confirm($categories, function(result){
            if(result) {
                var category_id = $('#add-category-alert > option:selected').attr('category-id');
                var category_name = $('#add-category-alert > option:selected').text();
                
                $.ajax({
                    url: '/admin/index.php?route=catalog/product/addCategory&token=' + LivePCe.token,
                    type: 'post',
                    data: {category_id: category_id, product_id: product_id},
                    dataType: 'json',
                    success: function(response){
                        if(response.status) {
                            LivePCe.showCategoryView(product_id, category_id, category_name);
                        } else {
                            alert("Cant link category from product <br>Maybe some other edit it at this moment!");
                        }                    
                    },
                    error: function(){
                        alert("Category already added!");
                    }
                });
            }
        });
    },
    showCategoryView: function(product_id, category_id, category_name){
        $('.category-live').each(function(){
            if($(this).hasClass('product_id-' + product_id)) {
                $(this).children('.catList').append('<span product-category-id="' + category_id + '">' + category_name + '&nbsp;<i class="fa red fa-times product_category"></i></span>');
            }
        });
    },
    removeCategory: function($clicked){
        this.token = this.getQParam('token');
        var product_id = $clicked.parent('span').parent('.catList').parent('td').attr('product-id');
        var category_id = $clicked.parent('span').attr('product-category-id');
        confirm('Realy delete?', function(result){
            if(result) {
                $.ajax({
                    url: '/admin/index.php?route=catalog/product/removeCategory&token=' + LivePCe.token,
                    dataType: 'json',
                    data: {category_id: category_id, product_id: product_id},
                    type: 'post',
                    success: function(response){
                        if(response.status) {
                            LivePCe.removeCategoryView(product_id, category_id);
                        } else {
                            alert("Cant unlink category from product <br>Maybe some on other edit it at this moment!");
                        }
                    }, 
                    error: function(){
                        alert("Internal server error <br>Please contact your web developers!");
                    }
                }); 
            }
        });
    },
    removeCategoryView: function(product_id, category_id){
        $('.category-live[product-id=' + product_id + '] > .catList > span[product-category-id=' + category_id + ']').fadeOut(500);
    },
    getQParam: function(key){
        var sPageURL = window.location.search.substring(1);
        var sURLVariables = sPageURL.split('&');
        for (var i = 0; i < sURLVariables.length; i++) {
            var sParameterName = sURLVariables[i].split('=');
            if (sParameterName[0] == key){
                return sParameterName[1];
            }
        }
    }
}
/* Bind events */
$(document).ready(function(){
    /* Append new product category */
    $(document).on('click', '.category-live > .pluscat > i.fa-plus', function(){
        LivePCe.addCategory($(this));
    });
    /* Append new product category */
    /* Remove product category */
    $(document).on('click', '.category-live > .catList > span > i.fa-times', function(){
        LivePCe.removeCategory($(this));
    });
    /* Remove product category */
});
/* Bind events */